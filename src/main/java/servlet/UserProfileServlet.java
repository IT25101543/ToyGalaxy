package servlet;

import model.User;
import service.OrderService;
import service.ReviewService;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Set;

@WebServlet("/user/profile")
public class UserProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ReviewService reviewService   = new ReviewService();
    private final service.ProductService productService = new service.ProductService();
    private final UserService  userService      = new UserService();
    private final OrderService orderService     = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/client/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        // Submitted reviews
        request.setAttribute("reviews", reviewService.getReviewsByUserId(user.getId()));
        request.setAttribute("productService", productService);

        // Full order history (all statuses, newest first)
        java.util.List<model.Order> orders = orderService.getOrdersByUserId(user.getId());
        java.util.Collections.reverse(orders);   // newest first
        request.setAttribute("orders", orders);

        // Orders awaiting a review
        Set<Integer> reviewedOrderIds = reviewService.getReviewedOrderIdsByUser(user.getId());
        request.setAttribute("unreviewedOrders",
                orderService.getUnreviewedOrdersByUserId(user.getId(), reviewedOrderIds));

        request.getRequestDispatcher("/client/user/userProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        User sessionUser = (User) session.getAttribute("user");

        try {
            if ("update".equals(action)) {
                sessionUser.setName(request.getParameter("name"));
                sessionUser.setEmail(request.getParameter("email"));
                sessionUser.setPhone(request.getParameter("phone"));
                sessionUser.setAddress(request.getParameter("address"));
                String password = request.getParameter("password");
                if (password != null && !password.isEmpty()) {
                    sessionUser.setPassword(password);
                }
                boolean success = userService.updateUser(sessionUser);
                if (success) {
                    session.setAttribute("user", sessionUser);
                    request.setAttribute("success", "Profile updated successfully.");
                } else {
                    request.setAttribute("error", "Failed to update profile.");
                }
            } else if ("delete".equals(action)) {
                boolean deleted = userService.deleteUser(sessionUser.getId());
                if (deleted) {
                    session.invalidate();
                    response.sendRedirect(request.getContextPath() + "/login?deleted=true");
                    return;
                } else {
                    request.setAttribute("error", "Failed to delete account.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
        }

        // Re-load data for the re-rendered page
        request.setAttribute("reviews", reviewService.getReviewsByUserId(sessionUser.getId()));
        request.setAttribute("productService", productService);
        java.util.List<model.Order> orders = orderService.getOrdersByUserId(sessionUser.getId());
        java.util.Collections.reverse(orders);
        request.setAttribute("orders", orders);
        Set<Integer> reviewedOrderIds = reviewService.getReviewedOrderIdsByUser(sessionUser.getId());
        request.setAttribute("unreviewedOrders",
                orderService.getUnreviewedOrdersByUserId(sessionUser.getId(), reviewedOrderIds));

        request.getRequestDispatcher("/client/user/userProfile.jsp").forward(request, response);
    }
}
