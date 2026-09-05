<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Đăng Ký Tài Khoản - Register</title>
</head>
<body>
    <div class="card-body p-4 p-sm-5">
        <div class="text-center mb-4">
            <h3 class="fw-bold text-dark mb-1">Tạo Tài Khoản Mới</h3>
            <p class="text-muted small">Điền thông tin để đăng ký tài khoản thành viên</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center gap-2 py-2 px-3 rounded-3 mb-3 small" role="alert">
                <i class="bi bi-exclamation-triangle-fill flex-shrink-0"></i>
                <div>${error}</div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post" class="needs-validation" novalidate id="registerForm">
            <!-- Full Name -->
            <div class="mb-3">
                <label for="fullName" class="form-label fw-semibold text-secondary small">Họ và tên <span class="text-danger">*</span></label>
                <div class="input-group has-validation">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-person-badge text-muted"></i></span>
                    <input type="text" class="form-control" id="fullName" name="fullName" value="${param.fullName}" placeholder="Nguyễn Văn A" required minlength="2" maxlength="100">
                    <div class="invalid-feedback">Vui lòng nhập họ và tên (tối thiểu 2 ký tự).</div>
                </div>
            </div>

            <!-- Username -->
            <div class="mb-3">
                <label for="username" class="form-label fw-semibold text-secondary small">Tên đăng nhập <span class="text-danger">*</span></label>
                <div class="input-group has-validation">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-person text-muted"></i></span>
                    <input type="text" class="form-control" id="username" name="username" value="${param.username}" placeholder="username123" required pattern="^[a-zA-Z0-9_]{3,30}$">
                    <div class="invalid-feedback">Tên đăng nhập phải từ 3-30 ký tự (chữ, số, gạch dưới).</div>
                </div>
            </div>

            <!-- Email -->
            <div class="mb-3">
                <label for="email" class="form-label fw-semibold text-secondary small">Email <span class="text-danger">*</span></label>
                <div class="input-group has-validation">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-envelope text-muted"></i></span>
                    <input type="email" class="form-control" id="email" name="email" value="${param.email}" placeholder="name@example.com" required>
                    <div class="invalid-feedback">Vui lòng nhập địa chỉ email hợp lệ.</div>
                </div>
            </div>

            <!-- Password -->
            <div class="mb-3">
                <label for="password" class="form-label fw-semibold text-secondary small">Mật khẩu <span class="text-danger">*</span></label>
                <div class="input-group has-validation">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-lock text-muted"></i></span>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Tối thiểu 6 ký tự" required minlength="6">
                    <div class="invalid-feedback">Mật khẩu phải có ít nhất 6 ký tự.</div>
                </div>
            </div>

            <!-- Confirm Password -->
            <div class="mb-4">
                <label for="confirmPassword" class="form-label fw-semibold text-secondary small">Xác nhận mật khẩu <span class="text-danger">*</span></label>
                <div class="input-group has-validation">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-shield-lock text-muted"></i></span>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu" required minlength="6">
                    <div class="invalid-feedback" id="confirmFeedback">Mật khẩu xác nhận không khớp.</div>
                </div>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold rounded-3 shadow-sm mb-3">
                <i class="bi bi-person-plus-fill me-1"></i> Đăng Ký Tài Khoản
            </button>
        </form>

        <div class="text-center text-muted small border-top pt-3">
            Đã có tài khoản? 
            <a href="${pageContext.request.contextPath}/login" class="fw-semibold text-primary text-decoration-none">Đăng nhập</a>
        </div>
    </div>

    <!-- Password Match Verification Script -->
    <script>
        const regForm = document.getElementById('registerForm');
        const passInput = document.getElementById('password');
        const confirmPassInput = document.getElementById('confirmPassword');

        function validatePasswordMatch() {
            if (passInput.value !== confirmPassInput.value) {
                confirmPassInput.setCustomValidity('Mật khẩu xác nhận không khớp');
            } else {
                confirmPassInput.setCustomValidity('');
            }
        }

        passInput.addEventListener('input', validatePasswordMatch);
        confirmPassInput.addEventListener('input', validatePasswordMatch);
    </script>
</body>
</html>
