<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Quản Lý Sản Phẩm - Manage Products</title>
</head>
<body>
    <div class="container py-4">
        <!-- Breadcrumb & Header -->
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
            <div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-1">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang chủ</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Quản lý sản phẩm</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0 text-dark"><i class="bi bi-boxes text-primary me-2"></i>Quản Lý Danh Sách Sản Phẩm</h3>
            </div>
            <a href="${pageContext.request.contextPath}/product?action=add" class="btn btn-primary px-4 rounded-pill shadow-sm fw-semibold">
                <i class="bi bi-plus-lg me-1"></i> Thêm Sản Phẩm Mới
            </a>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show d-flex align-items-center gap-2 rounded-3 shadow-sm mb-4" role="alert">
                <i class="bi bi-check-circle-fill fs-5"></i>
                <div>${message}</div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center gap-2 rounded-3 shadow-sm mb-4" role="alert">
                <i class="bi bi-exclamation-triangle-fill fs-5"></i>
                <div>${error}</div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <!-- Product Table Card -->
        <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4 py-3" style="width: 70px;">STT</th>
                            <th class="py-3" style="width: 100px;">Hình ảnh</th>
                            <th class="py-3">Tên sản phẩm</th>
                            <th class="py-3">Danh mục</th>
                            <th class="py-3">Giá bán</th>
                            <th class="py-3 text-center">Số lượng</th>
                            <th class="pe-4 py-3 text-end" style="width: 180px;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty products}">
                                <c:forEach var="p" items="${products}" varStatus="status">
                                    <tr>
                                        <td class="ps-4 fw-semibold text-muted">${status.index + 1}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty p.image and p.image != 'default.jpg'}">
                                                    <img src="${pageContext.request.contextPath}/uploads/${p.image}" alt="${p.name}" class="rounded-3 border object-fit-cover shadow-xs" style="width: 54px; height: 54px;">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="rounded-3 bg-light border d-flex align-items-center justify-content-center text-muted" style="width: 54px; height: 54px;">
                                                        <i class="bi bi-image fs-5 opacity-50"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="fw-bold text-dark mb-0">${p.name}</div>
                                            <div class="text-muted small text-truncate" style="max-width: 250px;">${p.description}</div>
                                        </td>
                                        <td>
                                            <span class="badge bg-light text-dark border px-3 py-1 rounded-pill">${p.categoryName != null ? p.categoryName : 'Chưa phân loại'}</span>
                                        </td>
                                        <td class="fw-bold text-danger">
                                            <fmt:formatNumber value="${p.price}" pattern="#,###"/> VNĐ
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${p.quantity > 0}">
                                                    <span class="badge bg-success-subtle text-success border border-success-subtle px-3 py-1 rounded-pill">${p.quantity} cái</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-3 py-1 rounded-pill">Hết hàng</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="pe-4 text-end">
                                            <a href="${pageContext.request.contextPath}/product?action=edit&id=${p.id}" class="btn btn-outline-primary btn-sm rounded-pill px-3 me-1" title="Sửa">
                                                <i class="bi bi-pencil-square me-1"></i> Sửa
                                            </a>
                                            <a href="${pageContext.request.contextPath}/product?action=delete&id=${p.id}" class="btn btn-outline-danger btn-sm rounded-pill px-3" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');" title="Xóa">
                                                <i class="bi bi-trash me-1"></i> Xóa
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7" class="text-center py-5 text-muted">
                                        <i class="bi bi-inbox fs-1 d-block mb-2 opacity-50"></i>
                                        Chưa có sản phẩm nào. Hãy bấm <strong>Thêm Sản Phẩm Mới</strong> để tạo sản phẩm!
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
