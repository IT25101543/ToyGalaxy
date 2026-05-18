package servlet;

import service.OrderService;
import service.ProductService;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin")
public class AdminDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UserService userService = new UserService();
    private final ProductService productService = new ProductService();
    private final OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        // Real stats
        int totalUsers = userService.getUserCount();

        // "Pending Products" = inactive products
        long pendingProducts = productService.getAllProducts().stream()
                .filter(p -> !p.isActive()).count();

        // Monthly sales = total revenue from all Paid orders
        double monthlySales = orderService.getTotalRevenue();

        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("pendingProducts", (int) pendingProducts);
        request.setAttribute("monthlySales", String.format("%.2f", monthlySales));

        request.getRequestDispatcher("/admin/adminDashboard.jsp").forward(request, response);
    }
}
