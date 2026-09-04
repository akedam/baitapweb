package com.app.controller;

import com.app.model.Product;
import com.app.model.User;
import com.app.service.CategoryService;
import com.app.service.ProductService;
import com.app.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductService productService;
    private CategoryService categoryService;
    private UserService userService;

    @Override
    public void init() throws ServletException {
        productService = new ProductService();
        categoryService = new CategoryService();
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check session - redirect to login if not authenticated
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");
        User freshUser = userService.findByUsername(sessionUser.getUsername());
        if (freshUser != null) {
            session.setAttribute("user", freshUser);
            session.setAttribute("fullName", freshUser.getFullName());
            session.setAttribute("userAvatar", freshUser.getImages());
        }

        // 10 sản phẩm mới nhất
        List<Product> latestProducts = productService.getLatestProducts(10);
        int totalProducts = productService.getAllProducts().size();
        int totalCategories = categoryService.getAllCategories().size();

        request.setAttribute("latestProducts", latestProducts);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalCategories", totalCategories);

        request.getRequestDispatcher("/views/home.jsp").forward(request, response);
    }
}
