package com.app.controller;

import com.app.model.User;
import com.app.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;
import java.util.regex.Pattern;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,        // 1MB
    maxFileSize = 1024 * 1024 * 5,           // 5MB
    maxRequestSize = 1024 * 1024 * 10        // 10MB
)
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService;
    private static final String UPLOAD_DIR = "uploads" + File.separator + "users";
    private static final Pattern PHONE_PATTERN = Pattern.compile("^(0|\\+84)(3|5|7|8|9)[0-9]{8}$");

    @Override
    public void init() throws ServletException {
        this.userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");
        User user = userService.findByUsername(sessionUser.getUsername());
        if (user == null) {
            user = sessionUser;
        }

        request.setAttribute("currentUser", user);
        request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");
        User currentUser = userService.findByUsername(sessionUser.getUsername());
        if (currentUser == null) {
            currentUser = sessionUser;
        }

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        Part filePart = request.getPart("image");

        // Validate form inputs
        StringBuilder errorMsg = new StringBuilder();

        if (fullName == null || fullName.trim().isEmpty()) {
            errorMsg.append("Họ và tên không được để trống.<br>");
        } else if (fullName.trim().length() < 2 || fullName.trim().length() > 100) {
            errorMsg.append("Họ và tên phải từ 2 đến 100 ký tự.<br>");
        }

        if (phone != null && !phone.trim().isEmpty()) {
            String trimmedPhone = phone.trim();
            if (!PHONE_PATTERN.matcher(trimmedPhone).matches()) {
                errorMsg.append("Số điện thoại không đúng định dạng (VD: 0912345678 hoặc +84912345678).<br>");
            }
        }

        String fileName = null;
        if (filePart != null && filePart.getSize() > 0) {
            String submittedFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String extension = "";
            int dotIndex = submittedFileName.lastIndexOf('.');
            if (dotIndex > 0) {
                extension = submittedFileName.substring(dotIndex).toLowerCase();
            }

            if (!extension.matches("\\.(jpg|jpeg|png|gif|webp)")) {
                errorMsg.append("Ảnh đại diện phải thuộc định dạng JPG, JPEG, PNG, WEBP hoặc GIF.<br>");
            } else if (filePart.getSize() > 5 * 1024 * 1024) {
                errorMsg.append("Kích thước file ảnh không được vượt quá 5MB.<br>");
            } else {
                // Generate unique filename
                fileName = UUID.randomUUID().toString() + extension;
                String applicationPath = request.getServletContext().getRealPath("");
                String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
                File uploadFolder = new File(uploadFilePath);
                if (!uploadFolder.exists()) {
                    uploadFolder.mkdirs();
                }

                // Also save to source directory if running in IDE
                try {
                    filePart.write(uploadFilePath + File.separator + fileName);
                } catch (Exception e) {
                    e.printStackTrace();
                    errorMsg.append("Lỗi khi tải ảnh lên máy chủ.<br>");
                }
            }
        }

        if (errorMsg.length() > 0) {
            request.setAttribute("error", errorMsg.toString());
            request.setAttribute("currentUser", currentUser);
            request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
            return;
        }

        // Apply changes
        String finalImage = (fileName != null) ? fileName : currentUser.getImages();
        String finalPhone = (phone != null) ? phone.trim() : "";
        String finalFullName = fullName.trim();

        boolean updated = userService.updateProfile(currentUser.getId(), finalFullName, finalPhone, finalImage);

        if (updated) {
            currentUser.setFullName(finalFullName);
            currentUser.setPhone(finalPhone);
            if (fileName != null) {
                currentUser.setImages(fileName);
            }
            session.setAttribute("user", currentUser);
            session.setAttribute("fullName", finalFullName);
            session.setAttribute("userAvatar", currentUser.getImages());

            request.setAttribute("success", "Cập nhật thông tin cá nhân thành công!");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi cập nhật thông tin trong cơ sở dữ liệu.");
        }

        request.setAttribute("currentUser", currentUser);
        request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
    }
}
