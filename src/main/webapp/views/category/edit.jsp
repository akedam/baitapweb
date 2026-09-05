<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Chỉnh Sửa Danh Mục - Category</title>
</head>
<body>
    <div class="container py-4">
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/category" class="text-decoration-none">Danh mục</a></li>
                <li class="breadcrumb-item active" aria-current="page">Chỉnh sửa</li>
            </ol>
        </nav>

        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm rounded-4 p-4 p-sm-5">
                    <div class="d-flex align-items-center gap-3 border-bottom pb-3 mb-4">
                        <div class="p-3 bg-primary-subtle text-primary rounded-3 fs-4">
                            <i class="bi bi-pencil-square"></i>
                        </div>
                        <div>
                            <h4 class="fw-bold mb-0 text-dark">Chỉnh Sửa Danh Mục</h4>
                            <p class="text-muted small mb-0">Cập nhật thông tin danh mục #${category.id}</p>
                        </div>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center gap-2 rounded-3 mb-4 small" role="alert">
                            <i class="bi bi-exclamation-triangle-fill flex-shrink-0"></i>
                            <div>${error}</div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/category" method="post" class="needs-validation" novalidate>
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="${category.id}">

                        <div class="mb-3">
                            <label for="name" class="form-label fw-semibold">Tên danh mục <span class="text-danger">*</span></label>
                            <div class="input-group has-validation">
                                <span class="input-group-text bg-light"><i class="bi bi-tag text-muted"></i></span>
                                <input type="text" class="form-control" id="name" name="name" value="${category.name}" required minlength="2" maxlength="100">
                                <div class="invalid-feedback">Vui lòng nhập tên danh mục (từ 2 đến 100 ký tự).</div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="description" class="form-label fw-semibold">Mô tả chi tiết</label>
                            <textarea class="form-control" id="description" name="description" rows="4">${category.description}</textarea>
                        </div>

                        <div class="d-flex align-items-center justify-content-end gap-2 pt-3 border-top">
                            <a href="${pageContext.request.contextPath}/category" class="btn btn-outline-secondary px-4 rounded-pill">
                                <i class="bi bi-x-lg me-1"></i> Hủy bỏ
                            </a>
                            <button type="submit" class="btn btn-primary px-4 rounded-pill shadow-sm fw-semibold">
                                <i class="bi bi-save me-1"></i> Cập Nhật Danh Mục
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
