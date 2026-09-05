<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Quản Lý Danh Mục - Category</title>
</head>
<body>
    <div class="container py-4">
        <!-- Breadcrumb & Header -->
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
            <div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-1">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang chủ</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Danh mục sản phẩm</li>
                    </ol>
                </nav>
                <h3 class="fw-bold mb-0 text-dark"><i class="bi bi-folder-fill text-primary me-2"></i>Quản Lý Danh Mục</h3>
            </div>
            <a href="${pageContext.request.contextPath}/category?action=add" class="btn btn-primary px-4 rounded-pill shadow-sm fw-semibold">
                <i class="bi bi-plus-lg me-1"></i> Thêm Danh Mục
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

        <!-- Category Table Card -->
        <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4 py-3" style="width: 80px;">STT</th>
                            <th class="py-3">Tên Danh Mục</th>
                            <th class="py-3">Mô Tả</th>
                            <th class="pe-4 py-3 text-end" style="width: 180px;">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty categories}">
                                <c:forEach var="cat" items="${categories}" varStatus="status">
                                    <tr>
                                        <td class="ps-4 fw-semibold text-muted">${status.index + 1}</td>
                                        <td>
                                            <div class="d-flex align-items-center gap-2">
                                                <div class="p-2 rounded-3 bg-primary-subtle text-primary d-inline-flex">
                                                    <i class="bi bi-folder"></i>
                                                </div>
                                                <span class="fw-bold text-dark">${cat.name}</span>
                                            </div>
                                        </td>
                                        <td class="text-muted small">${not empty cat.description ? cat.description : '<span class="fst-italic opacity-50">Không có mô tả</span>'}</td>
                                        <td class="pe-4 text-end">
                                            <a href="${pageContext.request.contextPath}/category?action=edit&id=${cat.id}" class="btn btn-outline-primary btn-sm rounded-pill px-3 me-1" title="Chỉnh sửa">
                                                <i class="bi bi-pencil-square me-1"></i> Sửa
                                            </a>
                                            <a href="${pageContext.request.contextPath}/category?action=delete&id=${cat.id}" class="btn btn-outline-danger btn-sm rounded-pill px-3" onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');" title="Xóa">
                                                <i class="bi bi-trash me-1"></i> Xóa
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="4" class="text-center py-5 text-muted">
                                        <i class="bi bi-inbox fs-1 d-block mb-2 opacity-50"></i>
                                        Chưa có danh mục nào. Hãy bấm <strong>Thêm Danh Mục</strong> để tạo mới!
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