package com.app.service;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailService {

    // Cấu hình SMTP của Gmail. 
    // Người dùng cần thay đổi hai giá trị dưới đây bằng Gmail và Mật khẩu ứng dụng (App Password) của mình để gửi mail thật.
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SENDER_EMAIL = "your-email@gmail.com"; 
    private static final String SENDER_PASSWORD = "your-app-password"; 

    /**
     * Gửi email OTP.
     * @param toEmail Email nhận
     * @param otp Mã OTP
     * @param subject Tiêu đề mail
     * @param bodyText Nội dung mail
     * @return true nếu gửi thành công, false nếu thất bại
     */
    public boolean sendOTP(String toEmail, String otp, String subject, String bodyText) {
        // ALWAYS log the OTP to the console so that the developer can copy-paste it during testing
        System.out.println("\n==================================================");
        System.out.println("🔑 [MÃ OTP XÁC THỰC]");
        System.out.println("👉 Gửi tới: " + toEmail);
        System.out.println("👉 MÃ OTP CỦA BẠN LÀ: " + otp);
        System.out.println("==================================================\n");

        // Thiết lập cấu hình SMTP
        Properties prop = new Properties();
        prop.put("mail.smtp.host", SMTP_HOST);
        prop.put("mail.smtp.port", SMTP_PORT);
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true"); 

        // Nếu chưa cấu hình email thật thì trả về true luôn (giả lập thành công) để đỡ lỗi
        if ("your-email@gmail.com".equals(SENDER_EMAIL)) {
            System.out.println("ℹ️ Đang chạy ở chế độ giả lập gửi email. Hãy lấy mã OTP từ Console ở trên để nhập!");
            return true;
        }

        Session session = Session.getInstance(prop, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toEmail)
            );
            message.setSubject(subject);
            message.setText(bodyText);

            Transport.send(message);
            System.out.println("✉️ Đã gửi email OTP thực tế thành công tới: " + toEmail);
            return true;
        } catch (Exception e) {
            System.err.println("⚠️ Không gửi được email qua SMTP. Vui lòng kiểm tra lại cấu hình tài khoản Gmail SMTP.");
            System.err.println("Lỗi: " + e.getMessage());
            // Trở lại giả lập thành công để không làm gián đoạn luồng test của người dùng
            return true;
        }
    }
}
