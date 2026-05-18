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

    /**
     * GET: Only show checkout page, never place an order.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/client/login.jsp");
            return;
        }

        String productIdParam = request.getParameter("productId");
        String quantityParam  = request.getParameter("quantity");

        if (productIdParam == null || quantityParam == null) {
            response.sendRedirect(request.getContextPath() + "/user/shop");
            return;
        }

        int productId = Integer.parseInt(productIdParam);
        int quantity  = Integer.parseInt(quantityParam);

        Product product = productService.getProductById(productId);
        if (product == null || product.getQuantity() < quantity) {
            session.setAttribute("error", "Product unavailable or out of stock.");
            response.sendRedirect(request.getContextPath() + "/user/product-details?productId=" + productId);
            return;
        }

        request.setAttribute("product", product);
        request.setAttribute("quantity", quantity);
        request.getRequestDispatcher("/client/user/checkout.jsp").forward(request, response);
    }

    /**
     * POST: Place the order only when action=confirm.
     */
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
        int quantity  = Integer.parseInt(request.getParameter("quantity"));

        Product product = productService.getProductById(productId);
        if (product == null || product.getQuantity() < quantity) {
            session.setAttribute("error", "Product unavailable or out of stock.");
            response.sendRedirect(request.getContextPath() + "/user/product-details?productId=" + productId);
            return;
        }

        String action = request.getParameter("action");

        if ("confirm".equals(action)) {
            // Build order
            Order order = new Order();
            order.setUserId(user.getId());
            order.setProductId(productId);
            order.setQuantity(quantity);
            order.setTotalPrice(product.getPrice() * quantity);
            order.setOrderDate(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            order.setStatus("Pending"); // <-- FIXED: use "Pending" so seller dashboard counts correctly

            // Place order first, then reduce stock atomically
            if (orderService.placeOrder(order)) {
                product.setQuantity(product.getQuantity() - quantity);
                productService.updateProduct(product);

                request.setAttribute("order", order);
                request.setAttribute("product", product);
                request.getRequestDispatcher("/client/user/orderSuccess.jsp").forward(request, response);
            } else {
                session.setAttribute("error", "Failed to place order. Please try again.");
                response.sendRedirect(request.getContextPath() + "/user/product-details?productId=" + productId);
            }

        } else {
            // "Buy Now" click — show checkout page
            request.setAttribute("product", product);
            request.setAttribute("quantity", quantity);
            request.getRequestDispatcher("/client/user/checkout.jsp").forward(request, response);
        }
    }
}