package com.app.controller;

import com.app.model.User;
import com.app.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    private UserService userService;

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

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");

        User user = new User(username, password, fullName, email);
        String result = userService.register(user);

        if ("SUCCESS".equals(result)) {
            response.sendRedirect(request.getContextPath() 
                    + "/verify-otp?username=" + java.net.URLEncoder.encode(username, "UTF-8")
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
