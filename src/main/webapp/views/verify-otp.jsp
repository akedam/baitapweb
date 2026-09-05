<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Xác Thực OTP - Verify OTP</title>
</head>
<body>
    <div class="card-body p-4 p-sm-5">
        <div class="text-center mb-4">
            <h3 class="fw-bold text-dark mb-1">Xác Thực Mã OTP</h3>
            <p class="text-muted small">Nhập mã OTP 6 chữ số được gửi đến email của bạn</p>
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

        <form action="${pageContext.request.contextPath}/verify-otp" method="post" class="needs-validation" novalidate>
            <input type="hidden" name="username" value="${username != null ? username : param.username}">

            <div class="mb-4">
                <label for="otp" class="form-label fw-semibold text-secondary small">Mã OTP (6 chữ số) <span class="text-danger">*</span></label>
                <div class="input-group has-validation">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-key text-muted"></i></span>
                    <input type="text" class="form-control text-center fs-4 font-monospace fw-bold tracking-widest" id="otp" name="otp" placeholder="••••••" required pattern="^[0-9]{6}$" maxlength="6" autofocus>
                    <div class="invalid-feedback">Mã OTP phải gồm chính xác 6 chữ số.</div>
                </div>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold rounded-3 shadow-sm mb-3">
                <i class="bi bi-check2-circle me-1"></i> Xác Nhận OTP
            </button>
        </form>

        <div class="text-center text-muted small border-top pt-3">
            Chưa nhận được mã? 
            <a href="${pageContext.request.contextPath}/verify-otp?action=resend&username=${username != null ? username : param.username}" class="fw-semibold text-primary text-decoration-none">Gửi lại mã</a>
        </div>
    </div>
</body>
</html>
