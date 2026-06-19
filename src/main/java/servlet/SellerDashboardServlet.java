package servlet;

import model.Seller;
import service.OrderService;
import service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/seller/dashboard")
public class SellerDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ProductService productService = new ProductService();
    private final OrderService orderService = new OrderService();

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

        // Fetch seller's products
        List<model.Product> products = productService.getProductsBySellerId(sellerId);
        int totalProducts = products.size();

        // Pending orders = orders with status "Pending" linked to this seller's products
        int pendingOrders = orderService.getPendingOrderCountForSeller(sellerId, productService);

        // Total sales = sum of all non-cancelled orders for this seller
        double totalSales = orderService.getTotalSalesForSeller(sellerId, productService);

        // Total order count for this seller (all statuses)
        int totalOrders = orderService.getOrdersBySellerId(sellerId, productService).size();

        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("pendingOrders", pendingOrders);
        request.setAttribute("totalSales", String.format("%.2f", totalSales));
        request.setAttribute("totalOrders", totalOrders); // bonus stat for JSP

        request.getRequestDispatcher("/client/seller/sellerDashboard.jsp").forward(request, response);
    }
}