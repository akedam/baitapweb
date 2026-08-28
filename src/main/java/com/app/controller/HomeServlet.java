package com.app.controller;

import com.app.model.Product;
import com.app.model.User;
import com.app.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {
    private ProductService productService;

    @Override
    public void init() throws ServletException {
        productService = new ProductService();
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

        User user = (User) session.getAttribute("user");
        request.setAttribute("user", user);

        // Lấy 10 sản phẩm mới nhất
        List<Product> latestProducts = productService.getLatestProducts(10);
        request.setAttribute("latestProducts", latestProducts);

        request.getRequestDispatcher("/views/home.jsp").forward(request, response);
    }
}
