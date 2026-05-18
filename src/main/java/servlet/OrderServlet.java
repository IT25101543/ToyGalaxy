package servlet;

import model.Order;
import model.Product;
import model.User;
import service.OrderService;
import service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/user/order")
public class OrderServlet extends HttpServlet {
    private OrderService orderService;
    private ProductService productService;

    @Override
    public void init() throws ServletException {
        orderService = new OrderService();
        productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/client/login.jsp");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Product product = productService.getProductById(productId);
        if (product == null || product.getQuantity() < quantity) {
            session.setAttribute("error", "Product unavailable or out of stock.");
            response.sendRedirect(request.getContextPath() + "/user/product-details?productId=" + productId);
            return;
        }

        // Instead of creating and placing order immediately, forward to checkout
        String action = request.getParameter("action");
        if ("confirm".equals(action)) {
            // Finalize the order (payment card no longer required)

            Order order = new Order();
            order.setUserId(user.getId());
            order.setProductId(productId);
            order.setQuantity(quantity);
            order.setTotalPrice(product.getPrice() * quantity);
            order.setOrderDate(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            order.setStatus("Cash on Delivery");

            if (orderService.placeOrder(order)) {
                product.setQuantity(product.getQuantity() - quantity);
                productService.updateProduct(product);
                request.setAttribute("order", order);
                request.setAttribute("product", product);
                request.getRequestDispatcher("/client/user/orderSuccess.jsp").forward(request, response);
            } else {
                session.setAttribute("error", "Failed to place order.");
                response.sendRedirect(request.getContextPath() + "/user/product-details?productId=" + productId);
            }
        } else {
            // Initial "Buy Now" click - forward to checkout
            request.setAttribute("product", product);
            request.setAttribute("quantity", quantity);
            request.getRequestDispatcher("/client/user/checkout.jsp").forward(request, response);
        }
    }
}
