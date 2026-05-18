package servlet;

import model.Product;
import service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/toys")
public class AdminManageToysServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        List<Product> products = productService.getAllProducts();
        request.setAttribute("products", products);
        request.getRequestDispatcher("/admin/manageToys.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");
        String message;
        boolean isError = false;

        try {
            if ("delete".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("id"));
                if (productService.deleteProduct(productId)) {
                    message = "Product deleted successfully.";
                } else {
                    message = "Failed to delete product.";
                    isError = true;
                }
            } else {
                message = "Unknown action.";
                isError = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "Error: " + e.getMessage();
            isError = true;
        }

        if (isError) {
            session.setAttribute("error", message);
        } else {
            session.setAttribute("success", message);
        }

        response.sendRedirect(request.getContextPath() + "/admin/toys");
    }
}
