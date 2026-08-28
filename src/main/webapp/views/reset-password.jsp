<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Lại Mật Khẩu - LoginURL</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="login-page">
    <div class="login-container">
        <div class="login-card">
            <div class="login-header">
                <h1>🔒 Đặt Lại Mật Khẩu</h1>
                <p>Nhập mã OTP được gửi tới email <strong>${email}</strong> và mật khẩu mới</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    ⚠️ ${error}
                </div>
            </c:if>

            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">
                    ✅ ${successMessage}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/reset-password" method="POST" class="login-form">
                <input type="hidden" name="email" value="${email}">

                <div class="form-group">
                    <label for="otp">Mã xác thực OTP (6 chữ số)</label>
                    <input type="text" id="otp" name="otp" maxlength="6" required autofocus
                           placeholder="Nhập mã OTP"
                           style="text-align: center; font-size: 20px; letter-spacing: 5px; font-weight: bold; width: 100%; padding: 10px; border: 2px solid #e0e0e0; border-radius: 8px; outline: none; transition: border-color 0.3s;">
                </div>

                <div class="form-group">
                    <label for="newPassword">Mật khẩu mới</label>
                    <input type="password" id="newPassword" name="newPassword"
                           placeholder="Nhập mật khẩu mới" required>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Xác nhận mật khẩu mới</label>
                    <input type="password" id="confirmPassword" name="confirmPassword"
                           placeholder="Xác nhận mật khẩu mới" required>
                </div>

                <button type="submit" class="btn btn-primary btn-block" style="margin-top: 10px;">
                    Cập Nhật Mật Khẩu
                </button>
            </form>

            <div class="login-footer">
                <p><a href="${pageContext.request.contextPath}/login" style="color: #888;">Quay lại đăng nhập</a></p>
            </div>
        </div>
    </div>
</body>
</html>
