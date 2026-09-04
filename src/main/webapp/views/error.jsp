<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Thông Báo Lỗi - Error</title>
</head>
<body>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-7 col-lg-6 text-center">
                <div class="card border-0 shadow-sm rounded-4 p-5">
                    <div class="mb-4">
                        <div class="d-inline-flex align-items-center justify-content-center rounded-circle bg-danger-subtle text-danger" style="width: 90px; height: 90px; font-size: 42px;">
                            <i class="bi bi-exclamation-octagon"></i>
                        </div>
                    </div>
                    <h3 class="fw-bold text-dark mb-2">Đã Xảy Ra Lỗi</h3>
                    <p class="text-muted mb-4">${not empty errorMessage ? errorMessage : 'Yêu cầu không thể thực hiện hoặc trang không tồn tại.'}</p>
                    
                    <div>
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-primary px-4 rounded-pill shadow-sm">
                            <i class="bi bi-house-door me-1"></i> Quay về Trang Chủ
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>