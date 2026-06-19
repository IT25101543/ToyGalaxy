package servlet;

import model.Order;
import model.Product;
import model.Seller;
import service.OrderService;
import service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/seller/orders")
public class SellerOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final OrderService orderService = new OrderService();
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("seller") == null) {
            response.sendRedirect(request.getContextPath() + "/seller/login");
            return;
        }

        Seller seller = (Seller) session.getAttribute("seller");
        int sellerId = seller.getId();

        // Get all orders for this seller
        List<Order> orders = orderService.getOrdersBySellerId(sellerId, productService);

        // Build a map of productId -> Product for display in JSP
        Map<Integer, Product> productMap = new LinkedHashMap<>();
        for (Order o : orders) {
            if (!productMap.containsKey(o.getProductId())) {
                Product p = productService.getProductById(o.getProductId());
                if (p != null) productMap.put(o.getProductId(), p);
            }
        }

        request.setAttribute("orders", orders);
        request.setAttribute("productMap", productMap);
        request.getRequestDispatcher("/client/seller/sellerOrders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("seller") == null) {
            response.sendRedirect(request.getContextPath() + "/seller/login");
            return;
        }

        // Handle order status update
        String orderIdParam = request.getParameter("orderId");
        String newStatus    = request.getParameter("status");

        if (orderIdParam != null && newStatus != null) {
            int orderId = Integer.parseInt(orderIdParam);
            orderService.updateOrderStatus(orderId, newStatus);
        }

        response.sendRedirect(request.getContextPath() + "/seller/orders");
    }
}