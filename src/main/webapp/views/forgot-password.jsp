<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên Mật Khẩu - LoginURL</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="login-page">
    <div class="login-container">
        <div class="login-card">
            <div class="login-header">
                <h1>🔑 Quên Mật Khẩu</h1>
                <p>Nhập email đã đăng ký để nhận mã OTP đặt lại mật khẩu</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    ⚠️ ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/forgot-password" method="POST" class="login-form">
                <div class="form-group">
                    <label for="email">Địa chỉ Email</label>
                    <input type="email" id="email" name="email" value="${email}"
                           placeholder="Nhập email của bạn" required autofocus
                           style="width: 100%; padding: 12px 14px; border: 2px solid #e0e0e0; border-radius: 8px; font-size: 14px; outline: none; transition: border-color 0.3s;">
                </div>

                <button type="submit" class="btn btn-primary btn-block" style="margin-top: 10px;">
                    Gửi Mã OTP
                </button>
            </form>

            <div class="login-footer">
                <p><a href="${pageContext.request.contextPath}/login" style="color: #667eea; font-weight: 600;">Quay lại đăng nhập</a></p>
            </div>
        </div>
    </div>
</body>
</html>
