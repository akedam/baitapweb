<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Quên Mật Khẩu - Forgot Password</title>
</head>
<body>
    <div class="card-body p-4 p-sm-5">
        <div class="text-center mb-4">
            <h3 class="fw-bold text-dark mb-1">Quên Mật Khẩu</h3>
            <p class="text-muted small">Nhập email đã đăng ký để nhận mã xác thực OTP</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center gap-2 py-2 px-3 rounded-3 mb-3 small" role="alert">
                <i class="bi bi-exclamation-triangle-fill flex-shrink-0"></i>
                <div>${error}</div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show d-flex align-items-center gap-2 py-2 px-3 rounded-3 mb-3 small" role="alert">
                <i class="bi bi-check-circle-fill flex-shrink-0"></i>
                <div>${success}</div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/forgot-password" method="post" class="needs-validation" novalidate>
            <div class="mb-4">
                <label for="email" class="form-label fw-semibold text-secondary small">Địa chỉ Email <span class="text-danger">*</span></label>
                <div class="input-group has-validation">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-envelope text-muted"></i></span>
                    <input type="email" class="form-control" id="email" name="email" value="${param.email}" placeholder="name@example.com" required>
                    <div class="invalid-feedback">Vui lòng nhập địa chỉ email hợp lệ.</div>
                </div>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold rounded-3 shadow-sm mb-3">
                <i class="bi bi-send-fill me-1"></i> Gửi Mã OTP
            </button>
        </form>

        <div class="text-center text-muted small border-top pt-3">
            Nhớ lại mật khẩu? 
            <a href="${pageContext.request.contextPath}/login" class="fw-semibold text-primary text-decoration-none">Đăng nhập</a>
        </div>
    </div>
</body>
</html>
