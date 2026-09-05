<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Đặt Lại Mật Khẩu - Reset Password</title>
</head>
<body>
    <div class="card-body p-4 p-sm-5">
        <div class="text-center mb-4">
            <h3 class="fw-bold text-dark mb-1">Đặt Lại Mật Khẩu</h3>
            <p class="text-muted small">Nhập mã OTP và mật khẩu mới cho tài khoản</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center gap-2 py-2 px-3 rounded-3 mb-3 small" role="alert">
                <i class="bi bi-exclamation-triangle-fill flex-shrink-0"></i>
                <div>${error}</div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/reset-password" method="post" class="needs-validation" novalidate id="resetForm">
            <input type="hidden" name="email" value="${email != null ? email : param.email}">

            <!-- OTP Input -->
            <div class="mb-3">
                <label for="otp" class="form-label fw-semibold text-secondary small">Mã OTP (6 chữ số) <span class="text-danger">*</span></label>
                <div class="input-group has-validation">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-key text-muted"></i></span>
                    <input type="text" class="form-control" id="otp" name="otp" placeholder="123456" required pattern="^[0-9]{6}$" maxlength="6">
                    <div class="invalid-feedback">Vui lòng nhập mã OTP 6 chữ số.</div>
                </div>
            </div>

            <!-- New Password -->
            <div class="mb-3">
                <label for="newPassword" class="form-label fw-semibold text-secondary small">Mật khẩu mới <span class="text-danger">*</span></label>
                <div class="input-group has-validation">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-lock text-muted"></i></span>
                    <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Tối thiểu 6 ký tự" required minlength="6">
                    <div class="invalid-feedback">Mật khẩu mới phải có tối thiểu 6 ký tự.</div>
                </div>
            </div>

            <!-- Confirm New Password -->
            <div class="mb-4">
                <label for="confirmPassword" class="form-label fw-semibold text-secondary small">Xác nhận mật khẩu mới <span class="text-danger">*</span></label>
                <div class="input-group has-validation">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-shield-lock text-muted"></i></span>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu mới" required minlength="6">
                    <div class="invalid-feedback">Mật khẩu xác nhận không khớp.</div>
                </div>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold rounded-3 shadow-sm mb-3">
                <i class="bi bi-arrow-repeat me-1"></i> Lưu Mật Khẩu Mới
            </button>
        </form>

        <div class="text-center text-muted small border-top pt-3">
            Quay lại 
            <a href="${pageContext.request.contextPath}/login" class="fw-semibold text-primary text-decoration-none">Đăng nhập</a>
        </div>
    </div>

    <script>
        const resetForm = document.getElementById('resetForm');
        const newPass = document.getElementById('newPassword');
        const confirmPass = document.getElementById('confirmPassword');

        function validateMatch() {
            if (newPass.value !== confirmPass.value) {
                confirmPass.setCustomValidity('Mật khẩu xác nhận không khớp');
            } else {
                confirmPass.setCustomValidity('');
            }
        }
        newPass.addEventListener('input', validateMatch);
        confirmPass.addEventListener('input', validateMatch);
    </script>
</body>
</html>
