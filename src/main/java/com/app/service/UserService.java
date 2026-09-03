package com.app.service;

import com.app.dao.UserDAO;
import com.app.dao.UserJpaDAO;
import com.app.model.User;

import java.util.Date;

public class UserService {
    private UserDAO userDAO;
    private UserJpaDAO userJpaDAO;
    private EmailService emailService;

    public UserService() {
        this.userDAO = new UserDAO();
        this.userJpaDAO = new UserJpaDAO();
        this.emailService = new EmailService();
    }

    public User login(String username, String password) {
        if (username == null || username.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            return null;
        }
        return userDAO.findByUsernameAndPassword(username.trim(), password.trim());
    }

    public User findByUsername(String username) {
        return userDAO.findByUsername(username);
    }

    public User findByEmail(String email) {
        return userDAO.findByEmail(email);
    }

    public User getUserById(String id) {
        return userDAO.findById(id);
    }

    /**
     * Cập nhật thông tin profile: fullName, phone, images
     */
    public boolean updateProfile(String id, String fullName, String phone, String images) {
        if (id == null || id.trim().isEmpty()) {
            return false;
        }
        try {
            // Cập nhật qua DAO
            userDAO.updateProfile(id, fullName, phone, images);
            // Đồng bộ qua JPA DAO nếu cần
            try {
                userJpaDAO.updateProfile(id, fullName, phone, images);
            } catch (Exception ignored) {}
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Đăng ký tài khoản mới và gửi mã OTP kích hoạt qua email.
     */
    public String register(User user) {
        if (userDAO.findByUsername(user.getUsername()) != null) {
            return "Tên đăng nhập đã tồn tại!";
        }
        if (userDAO.findByEmail(user.getEmail()) != null) {
            return "Email đã được đăng ký bởi tài khoản khác!";
        }

        // Sinh mã OTP
        String otp = generateOTP();
        user.setOtp(otp);
        user.setOtpExpiry(getExpiryDate(5)); // Hết hạn sau 5 phút
        user.setActive(false); // Chưa kích hoạt
        if (user.getImages() == null || user.getImages().isEmpty()) {
            user.setImages("default-avatar.png");
        }

        userDAO.insert(user);
        try {
            userJpaDAO.insert(user);
        } catch (Exception ignored) {}

        // Gửi OTP qua email
        String subject = "Kích hoạt tài khoản - LoginURL";
        String body = "Xin chào " + user.getFullName() + ",\n\n"
                + "Cảm ơn bạn đã đăng ký tài khoản tại hệ thống của chúng tôi.\n"
                + "Mã OTP kích hoạt tài khoản của bạn là: " + otp + "\n"
                + "Mã này có hiệu lực trong vòng 5 phút.\n\n"
                + "Trân trọng,\nBan quản trị.";
        
        emailService.sendOTP(user.getEmail(), otp, subject, body);

        return "SUCCESS";
    }

    /**
     * Xác thực OTP kích hoạt tài khoản.
     */
    public boolean verifyOTP(String username, String otp) {
        User user = userDAO.findByUsername(username);
        if (user == null || user.getOtp() == null || user.getOtpExpiry() == null) {
            return false;
        }

        // Kiểm tra OTP khớp và chưa hết hạn
        if (user.getOtp().equals(otp) && user.getOtpExpiry().after(new Date())) {
            user.setActive(true);
            user.setOtp(null);
            user.setOtpExpiry(null);
            userDAO.update(user);
            try {
                userJpaDAO.update(user);
            } catch (Exception ignored) {}
            return true;
        }
        return false;
    }

    /**
     * Gửi lại mã OTP kích hoạt tài khoản.
     */
    public boolean resendOTP(String username) {
        User user = userDAO.findByUsername(username);
        if (user == null || user.isActive()) {
            return false;
        }

        String otp = generateOTP();
        user.setOtp(otp);
        user.setOtpExpiry(getExpiryDate(5));
        userDAO.update(user);

        String subject = "Gửi lại mã kích hoạt tài khoản - LoginURL";
        String body = "Xin chào " + user.getFullName() + ",\n\n"
                + "Mã OTP kích hoạt tài khoản mới của bạn là: " + otp + "\n"
                + "Mã này có hiệu lực trong vòng 5 phút.\n\n"
                + "Trân trọng,\nBan quản trị.";
        
        return emailService.sendOTP(user.getEmail(), otp, subject, body);
    }

    /**
     * Gửi OTP khi quên mật khẩu.
     */
    public boolean sendForgotPasswordOTP(String email) {
        User user = userDAO.findByEmail(email);
        if (user == null) {
            return false;
        }

        String otp = generateOTP();
        user.setOtp(otp);
        user.setOtpExpiry(getExpiryDate(5));
        userDAO.update(user);

        String subject = "Mã OTP đặt lại mật khẩu - LoginURL";
        String body = "Xin chào " + user.getFullName() + ",\n\n"
                + "Bạn đã yêu cầu đặt lại mật khẩu.\n"
                + "Mã OTP của bạn là: " + otp + "\n"
                + "Mã này có hiệu lực trong vòng 5 phút.\n\n"
                + "Nếu bạn không thực hiện yêu cầu này, vui lòng bỏ qua email.\n\n"
                + "Trân trọng,\nBan quản trị.";
        
        return emailService.sendOTP(user.getEmail(), otp, subject, body);
    }

    /**
     * Đặt lại mật khẩu mới bằng OTP.
     */
    public boolean resetPassword(String email, String otp, String newPassword) {
        User user = userDAO.findByEmail(email);
        if (user == null || user.getOtp() == null || user.getOtpExpiry() == null) {
            return false;
        }

        if (user.getOtp().equals(otp) && user.getOtpExpiry().after(new Date())) {
            user.setPassword(newPassword);
            user.setOtp(null);
            user.setOtpExpiry(null);
            userDAO.update(user);
            try {
                userJpaDAO.update(user);
            } catch (Exception ignored) {}
            return true;
        }
        return false;
    }

    private String generateOTP() {
        int randomPin = (int) (Math.random() * 900000) + 100000;
        return String.valueOf(randomPin);
    }

    private Date getExpiryDate(int minutes) {
        return new Date(System.currentTimeMillis() + minutes * 60 * 1000);
    }
}
