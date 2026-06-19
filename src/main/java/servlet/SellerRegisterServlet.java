package servlet;

import model.Seller;
import service.SellerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/seller/register")
public class SellerRegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final SellerService sellerService = new SellerService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String storeName = request.getParameter("storeName");

        // Check if email already exists
        if (sellerService.getSellerByEmail(email) != null) {
            request.setAttribute("error", "An account with this email already exists.");
            request.getRequestDispatcher("/client/sellerlogin.jsp").forward(request, response);
            return;
        }

        Seller seller = new Seller();
        seller.setName(name);
        seller.setEmail(email);
        seller.setPassword(password);
        seller.setStoreName(storeName);
        seller.setApproved(true); // Auto-approve on self-registration

        boolean success = sellerService.createSeller(seller);

        if (success) {
            request.setAttribute("success", "Account created successfully! You can now sign in.");
            request.getRequestDispatcher("/client/sellerlogin.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/client/sellerlogin.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/seller/login");
    }
}
