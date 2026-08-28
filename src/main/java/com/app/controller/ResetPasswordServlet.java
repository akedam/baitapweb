package com.app.controller;

import com.app.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/reset-password"})
public class ResetPasswordServlet extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String success = request.getParameter("success");

        request.setAttribute("email", email);
        if (success != null) request.setAttribute("successMessage", success);

        request.getRequestDispatcher("/views/reset-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String otp = request.getParameter("otp");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (newPassword == null || !newPassword.equals(confirmPassword)) {
            request.setAttribute("email", email);
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("/views/reset-password.jsp").forward(request, response);
            return;
        }

        boolean resetSuccess = userService.resetPassword(email, otp, newPassword);

        if (resetSuccess) {
            response.sendRedirect(request.getContextPath() 
                    + "/login?success=" + java.net.URLEncoder.encode("Đặt lại mật khẩu thành công! Hãy đăng nhập bằng mật khẩu mới.", "UTF-8"));
        } else {
            request.setAttribute("email", email);
            request.setAttribute("error", "Mã OTP không hợp lệ hoặc đã hết hạn!");
            request.getRequestDispatcher("/views/reset-password.jsp").forward(request, response);
        }
    }
}
