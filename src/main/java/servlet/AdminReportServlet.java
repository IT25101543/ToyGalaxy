package servlet;

import model.Order;
import model.Product;
import service.OrderService;
import service.ProductService;
import service.ReviewService;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/reports")
public class AdminReportServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final OrderService orderService     = new OrderService();
    private final ProductService productService = new ProductService();
    private final ReviewService reviewService   = new ReviewService();
    private final UserService userService       = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        // --- Order stats ---
        List<Order> allOrders = orderService.getAllOrders();
        int totalOrders    = allOrders.size();
        int pendingOrders  = orderService.getOrderCountByStatus("Pending");
        int paidOrders     = orderService.getOrderCountByStatus("Paid");
        int codOrders      = orderService.getOrderCountByStatus("Cash on Delivery");
        int cancelledOrders = orderService.getOrderCountByStatus("Cancelled");
        double totalRevenue = orderService.getTotalRevenue();

        // --- Product map for order table (productId -> product name) ---
        Map<Integer, String> productNameMap = new LinkedHashMap<>();
        for (Order o : allOrders) {
            if (!productNameMap.containsKey(o.getProductId())) {
                Product p = productService.getProductById(o.getProductId());
                productNameMap.put(o.getProductId(), p != null ? p.getProductName() : "Unknown");
            }
        }

        // --- Review stats ---
        int totalReviews = reviewService.getAllReviews().size();

        // --- User stats ---
        int totalUsers = userService.getUserCount();

        // --- Product stats ---
        List<Product> allProducts = productService.getAllProducts();
        long activeProducts   = allProducts.stream().filter(Product::isActive).count();
        long inactiveProducts = allProducts.stream().filter(p -> !p.isActive()).count();

        request.setAttribute("allOrders",       allOrders);
        request.setAttribute("productNameMap",  productNameMap);
        request.setAttribute("totalOrders",     totalOrders);
        request.setAttribute("pendingOrders",   pendingOrders);
        request.setAttribute("paidOrders",      paidOrders);
        request.setAttribute("codOrders",       codOrders);
        request.setAttribute("cancelledOrders", cancelledOrders);
        request.setAttribute("totalRevenue",    String.format("%.2f", totalRevenue));
        request.setAttribute("totalReviews",    totalReviews);
        request.setAttribute("totalUsers",      totalUsers);
        request.setAttribute("activeProducts",  (int) activeProducts);
        request.setAttribute("inactiveProducts",(int) inactiveProducts);

        request.getRequestDispatcher("/admin/adminReports.jsp").forward(request, response);
    }
}