<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>${product.name} - Chi Tiết Sản Phẩm</title>
</head>
<body>
    <div class="container py-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/product" class="text-decoration-none">Sản phẩm</a></li>
                <li class="breadcrumb-item active" aria-current="page">${product.name}</li>
            </ol>
        </nav>

        <div class="card border-0 shadow-sm rounded-4 overflow-hidden p-4 p-md-5">
            <div class="row g-4 align-items-center">
                <div class="col-md-5 text-center">
                    <div class="bg-light rounded-4 p-3 d-flex align-items-center justify-content-center" style="min-height: 320px;">
                        <c:choose>
                            <c:when test="${not empty product.imageUrl and (product.imageUrl.startsWith('http://') or product.imageUrl.startsWith('https://'))}">
                                <img src="${product.imageUrl}" alt="${product.name}" class="img-fluid rounded-3 shadow-xs object-fit-contain" style="max-height: 300px;">
                            </c:when>
                            <c:when test="${not empty product.imageUrl and product.imageUrl.startsWith('/')}">
                                <img src="${product.imageUrl.startsWith(pageContext.request.contextPath) ? product.imageUrl : pageContext.request.contextPath.concat(product.imageUrl)}" alt="${product.name}" class="img-fluid rounded-3 shadow-xs object-fit-contain" style="max-height: 300px;">
                            </c:when>
                            <c:when test="${not empty product.imageUrl and product.imageUrl != 'default.jpg'}">
                                <img src="${pageContext.request.contextPath}/uploads/${product.imageUrl}" alt="${product.name}" class="img-fluid rounded-3 shadow-xs object-fit-contain" style="max-height: 300px;">
                            </c:when>
                            <c:otherwise>
                                <div class="text-muted text-center">
                                    <i class="bi bi-box-seam fs-1 opacity-25 d-block mb-2"></i>
                                    <span>Chưa có hình ảnh</span>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="col-md-7">
                    <div class="d-flex align-items-center gap-2 mb-2">
                        <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-1 rounded-pill">
                            <i class="bi bi-folder me-1"></i> ${product.categoryName != null ? product.categoryName : 'Danh mục chung'}
                        </span>
                        <c:choose>
                            <c:when test="${product.quantity > 0}">
                                <span class="badge bg-success-subtle text-success border border-success-subtle px-3 py-1 rounded-pill">
                                    <i class="bi bi-check-circle me-1"></i> Còn hàng (${product.quantity})
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-3 py-1 rounded-pill">
                                    <i class="bi bi-x-circle me-1"></i> Hết hàng
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <h2 class="fw-bold text-dark mb-3">${product.name}</h2>
                    
                    <div class="fs-2 fw-bold text-danger mb-4">
                        <fmt:formatNumber value="${product.price}" pattern="#,###"/> <small class="fs-6 text-muted">VNĐ</small>
                    </div>

                    <div class="mb-4">
                        <h6 class="fw-bold text-dark mb-2">Mô tả sản phẩm:</h6>
                        <p class="text-muted leading-relaxed">${not empty product.description ? product.description : 'Chưa có mô tả chi tiết cho sản phẩm này.'}</p>
                    </div>

                    <hr class="my-4">

                    <div class="d-flex flex-wrap gap-2">
                        <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-secondary px-4 rounded-pill">
                            <i class="bi bi-arrow-left me-1"></i> Quay lại
                        </a>
                        <a href="${pageContext.request.contextPath}/product?action=edit&id=${product.id}" class="btn btn-primary px-4 rounded-pill shadow-sm">
                            <i class="bi bi-pencil-square me-1"></i> Chỉnh sửa
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
