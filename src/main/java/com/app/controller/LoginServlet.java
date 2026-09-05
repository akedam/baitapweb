package com.app.controller;

import com.app.model.User;
import com.app.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is already logged in via session
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // Check Cookie for "Remember Me"
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("rememberedUser".equals(cookie.getName())) {
                    request.setAttribute("rememberedUser", cookie.getValue());
                    break;
                }
            }
        }

        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("rememberMe");

        // Server-side validation
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            return;
        }

        User user = userService.login(username.trim(), password.trim());

        if (user != null) {
            // Check if account is active
            if (!user.isActive()) {
                response.sendRedirect(request.getContextPath() 
                        + "/verify-otp?username=" + java.net.URLEncoder.encode(username, "UTF-8")
                        + "&error=" + java.net.URLEncoder.encode("Tài khoản chưa được kích hoạt! Vui lòng nhập mã OTP để kích hoạt.", "UTF-8"));
                return;
            }

            // Create session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("username", user.getUsername());
            session.setAttribute("fullName", user.getFullName());
            session.setAttribute("userAvatar", user.getImages());

            // Handle "Remember Me" cookie
            if ("true".equals(remember) || "on".equals(remember)) {
                Cookie cookie = new Cookie("rememberedUser", user.getUsername());
                cookie.setMaxAge(7 * 24 * 60 * 60); // 7 days
                cookie.setPath(request.getContextPath());
                response.addCookie(cookie);
            } else {
                Cookie cookie = new Cookie("rememberedUser", "");
                cookie.setMaxAge(0);
                cookie.setPath(request.getContextPath());
                response.addCookie(cookie);
            }

            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác!");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
}
