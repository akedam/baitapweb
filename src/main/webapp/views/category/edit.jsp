<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa Danh Mục - LoginURL</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">📋 LoginURL App</div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home" class="nav-link">🏠 Trang Chủ</a>
            <a href="${pageContext.request.contextPath}/category" class="nav-link active">📂 Danh Mục</a>
            <a href="${pageContext.request.contextPath}/product" class="nav-link">🛍️ Sản Phẩm</a>
            <a href="${pageContext.request.contextPath}/product?action=manage" class="nav-link">⚙️ Quản Lý Sản Phẩm</a>
            <span class="nav-user">👤 ${sessionScope.fullName}</span>
            <a href="${pageContext.request.contextPath}/logout" class="nav-link nav-logout">🚪 Đăng Xuất</a>
        </div>
    </nav>

    <div class="container">
        <div class="form-card">
            <h2>✏️ Sửa Danh Mục</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-error">⚠️ ${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/category" method="POST" class="crud-form">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="${category.id}">

                <div class="form-group">
                    <label for="name">Tên danh mục <span class="required">*</span></label>
                    <input type="text" id="name" name="name"
                           value="${category.name}"
                           placeholder="Nhập tên danh mục" required autofocus>
                </div>

                <div class="form-group">
                    <label for="description">Mô tả</label>
                    <textarea id="description" name="description" rows="4"
                              placeholder="Nhập mô tả danh mục">${category.description}</textarea>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">💾 Cập Nhật</button>
                    <a href="${pageContext.request.contextPath}/category" class="btn btn-secondary">↩️ Quay Lại</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
