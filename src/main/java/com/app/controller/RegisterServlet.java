package com.app.controller;

import com.app.model.User;
import com.app.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.regex.Pattern;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService;
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[a-zA-Z0-9_]{3,30}$");

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");

        // Server-side validation
        StringBuilder errorMsg = new StringBuilder();

        if (fullName == null || fullName.trim().length() < 2) {
            errorMsg.append("Họ và tên phải có tối thiểu 2 ký tự.<br>");
        }

        if (username == null || !USERNAME_PATTERN.matcher(username.trim()).matches()) {
            errorMsg.append("Tên đăng nhập phải từ 3 đến 30 ký tự, chỉ gồm chữ cái, số và dấu gạch dưới.<br>");
        }

        if (email == null || !EMAIL_PATTERN.matcher(email.trim()).matches()) {
            errorMsg.append("Địa chỉ email không đúng định dạng.<br>");
        }

        if (password == null || password.length() < 6) {
            errorMsg.append("Mật khẩu phải có ít nhất 6 ký tự.<br>");
        } else if (confirmPassword != null && !password.equals(confirmPassword)) {
            errorMsg.append("Mật khẩu xác nhận không khớp.<br>");
        }

        if (errorMsg.length() > 0) {
            request.setAttribute("error", errorMsg.toString());
            request.setAttribute("username", username);
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        User user = new User(username.trim(), password, fullName.trim(), email.trim());
        user.setImages("default-avatar.png");
        String result = userService.register(user);

        if ("SUCCESS".equals(result)) {
            response.sendRedirect(request.getContextPath() 
                    + "/verify-otp?username=" + java.net.URLEncoder.encode(username.trim(), "UTF-8")
                    + "&success=" + java.net.URLEncoder.encode("Đăng ký thành công! Một mã OTP đã được gửi đến email của bạn.", "UTF-8"));
        } else {
            request.setAttribute("error", result);
            request.setAttribute("username", username);
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
        }
    }
}
