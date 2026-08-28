package com.app.controller;

import com.app.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "VerifyOTPServlet", urlPatterns = {"/verify-otp"})
public class VerifyOTPServlet extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String success = request.getParameter("success");
        String error = request.getParameter("error");

        request.setAttribute("username", username);
        if (success != null) request.setAttribute("successMessage", success);
        if (error != null) request.setAttribute("error", error);

        request.getRequestDispatcher("/views/verify-otp.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String action = request.getParameter("action"); // 'verify' or 'resend'

        if ("resend".equals(action)) {
            boolean resent = userService.resendOTP(username);
            if (resent) {
                response.sendRedirect(request.getContextPath() 
                        + "/verify-otp?username=" + java.net.URLEncoder.encode(username, "UTF-8")
                        + "&success=" + java.net.URLEncoder.encode("Mã OTP mới đã được gửi lại vào email của bạn.", "UTF-8"));
            } else {
                response.sendRedirect(request.getContextPath() 
                        + "/verify-otp?username=" + java.net.URLEncoder.encode(username, "UTF-8")
                        + "&error=" + java.net.URLEncoder.encode("Gửi lại mã OTP thất bại! Tài khoản có thể đã được kích hoạt.", "UTF-8"));
            }
            return;
        }

        String otp = request.getParameter("otp");
        boolean verified = userService.verifyOTP(username, otp);

        if (verified) {
            response.sendRedirect(request.getContextPath() 
                    + "/login?success=" + java.net.URLEncoder.encode("Kích hoạt tài khoản thành công! Bạn có thể đăng nhập ngay.", "UTF-8"));
        } else {
            request.setAttribute("username", username);
            request.setAttribute("error", "Mã OTP không hợp lệ hoặc đã hết hạn!");
            request.getRequestDispatcher("/views/verify-otp.jsp").forward(request, response);
        }
    }
}
