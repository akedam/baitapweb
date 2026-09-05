<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Đăng Nhập - Login</title>
</head>
<body>
    <div class="card-body p-4 p-sm-5">
        <div class="text-center mb-4">
            <h3 class="fw-bold text-dark mb-1">Đăng Nhập Hệ Thống</h3>
            <p class="text-muted small">Nhập thông tin tài khoản của bạn để tiếp tục</p>
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

        <form action="${pageContext.request.contextPath}/login" method="post" class="needs-validation" novalidate>
            <div class="mb-3">
                <label for="username" class="form-label fw-semibold text-secondary small">Tên đăng nhập</label>
                <div class="input-group has-validation">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-person text-muted"></i></span>
                    <input type="text" class="form-control" id="username" name="username" value="${param.username}" placeholder="Nhập username" required minlength="3" maxlength="50">
                    <div class="invalid-feedback">Vui lòng nhập tên đăng nhập (tối thiểu 3 ký tự).</div>
                </div>
            </div>

            <div class="mb-3">
                <div class="d-flex justify-content-between align-items-center">
                    <label for="password" class="form-label fw-semibold text-secondary small mb-0">Mật khẩu</label>
                    <a href="${pageContext.request.contextPath}/forgot-password" class="text-decoration-none small text-primary">Quên mật khẩu?</a>
                </div>
                <div class="input-group has-validation mt-1">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-lock text-muted"></i></span>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu" required minlength="6">
                    <div class="invalid-feedback">Vui lòng nhập mật khẩu (tối thiểu 6 ký tự).</div>
                </div>
            </div>

            <div class="mb-4 form-check">
                <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe" value="true">
                <label class="form-check-label text-muted small" for="rememberMe">Ghi nhớ đăng nhập</label>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold rounded-3 shadow-sm mb-3">
                <i class="bi bi-box-arrow-in-right me-1"></i> Đăng Nhập
            </button>
        </form>

        <div class="text-center text-muted small border-top pt-3">
            Chưa có tài khoản? 
            <a href="${pageContext.request.contextPath}/register" class="fw-semibold text-primary text-decoration-none">Đăng ký ngay</a>
        </div>
    </div>
</body>
</html>
