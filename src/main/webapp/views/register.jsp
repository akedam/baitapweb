<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký Tài Khoản - LoginURL</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="login-page">
    <div class="login-container">
        <div class="login-card">
            <div class="login-header">
                <h1>📝 Đăng Ký</h1>
                <p>Tạo tài khoản mới để trải nghiệm dịch vụ</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    ⚠️ ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="POST" class="login-form">
                <div class="form-group">
                    <label for="username">Tên đăng nhập <span class="required">*</span></label>
                    <input type="text" id="username" name="username" value="${username}"
                           placeholder="Nhập tên đăng nhập" required autofocus>
                </div>

                <div class="form-group">
                    <label for="fullName">Họ và tên <span class="required">*</span></label>
                    <input type="text" id="fullName" name="fullName" value="${fullName}"
                           placeholder="Nhập họ và tên" required>
                </div>

                <div class="form-group">
                    <label for="email">Email <span class="required">*</span></label>
                    <input type="email" id="email" name="email" value="${email}"
                           placeholder="username@example.com" required
                           style="width: 100%; padding: 12px 14px; border: 2px solid #e0e0e0; border-radius: 8px; font-size: 14px; outline: none; transition: border-color 0.3s;">
                </div>

                <div class="form-group">
                    <label for="password">Mật khẩu <span class="required">*</span></label>
                    <input type="password" id="password" name="password"
                           placeholder="Nhập mật khẩu" required>
                </div>

                <button type="submit" class="btn btn-primary btn-block" style="margin-top: 10px;">
                    Đăng Ký Tài Khoản
                </button>
            </form>

            <div class="login-footer">
                <p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" style="color: #667eea; font-weight: 600;">Đăng nhập ngay</a></p>
            </div>
        </div>
    </div>
</body>
</html>
