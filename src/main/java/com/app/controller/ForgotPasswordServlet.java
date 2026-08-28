package com.app.controller;

import com.app.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgot-password"})
public class ForgotPasswordServlet extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        boolean otpSent = userService.sendForgotPasswordOTP(email);

        if (otpSent) {
            response.sendRedirect(request.getContextPath() 
                    + "/reset-password?email=" + java.net.URLEncoder.encode(email, "UTF-8")
                    + "&success=" + java.net.URLEncoder.encode("Mã xác nhận khôi phục mật khẩu đã được gửi qua email.", "UTF-8"));
        } else {
            request.setAttribute("error", "Email không tồn tại trong hệ thống!");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/views/forgot-password.jsp").forward(request, response);
        }
    }
}
