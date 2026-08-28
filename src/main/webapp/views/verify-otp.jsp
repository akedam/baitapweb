<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Thực OTP - LoginURL</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="login-page">
    <div class="login-container">
        <div class="login-card">
            <div class="login-header">
                <h1>🔑 Xác Thực OTP</h1>
                <p>Nhập mã OTP được gửi tới email để kích hoạt tài khoản <strong>${username}</strong></p>
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

            <!-- Form Xác thực OTP -->
            <form action="${pageContext.request.contextPath}/verify-otp" method="POST" class="login-form">
                <input type="hidden" name="username" value="${username}">
                <input type="hidden" name="action" value="verify">

                <div class="form-group">
                    <label for="otp" style="text-align: center; display: block; font-size: 16px; margin-bottom: 12px; letter-spacing: 0.5px;">Mã xác thực OTP (6 chữ số)</label>
                    <input type="text" id="otp" name="otp" maxlength="6" required autofocus
                           placeholder="------"
                           style="text-align: center; font-size: 24px; letter-spacing: 10px; font-weight: bold; width: 100%; padding: 12px; border: 2px solid #e0e0e0; border-radius: 8px; outline: none; transition: border-color 0.3s;">
                </div>

                <button type="submit" class="btn btn-primary btn-block" style="margin-top: 10px;">
                    Kích Hoạt Tài Khoản
                </button>
            </form>

            <!-- Form Gửi lại mã OTP -->
            <form action="${pageContext.request.contextPath}/verify-otp" method="POST" style="margin-top: 15px; text-align: center;">
                <input type="hidden" name="username" value="${username}">
                <input type="hidden" name="action" value="resend">
                <p style="font-size: 13px; color: #666;">
                    Chưa nhận được mã? 
                    <button type="submit" style="background: none; border: none; color: #667eea; font-weight: 600; cursor: pointer; text-decoration: underline; font-family: inherit;">
                        Gửi lại mã OTP
                    </button>
                </p>
            </form>

            <div class="login-footer">
                <p><a href="${pageContext.request.contextPath}/login" style="color: #888;">Quay lại đăng nhập</a></p>
            </div>
        </div>
    </div>
</body>
</html>
