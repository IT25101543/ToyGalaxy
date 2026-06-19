package servlet;

import model.Product;
import service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/user/product-details")
public class ProductDetailsServlet extends HttpServlet {
    private ProductService productService;
    private service.ReviewService reviewService;

    @Override
    public void init() throws ServletException {
        productService = new ProductService();
        reviewService = new service.ReviewService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        Product product = productService.getProductById(productId);

        if (product != null) {
            request.setAttribute("product", product);
            request.setAttribute("reviews", reviewService.getReviewsByProductId(productId));
            request.getRequestDispatcher("/client/productDetails.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/user/products");
        }
    }
}
