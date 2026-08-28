<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Sản Phẩm - LoginURL</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">📋 LoginURL App</div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home" class="nav-link">🏠 Trang Chủ</a>
            <a href="${pageContext.request.contextPath}/category" class="nav-link">📂 Danh Mục</a>
            <a href="${pageContext.request.contextPath}/product" class="nav-link">🛍️ Sản Phẩm</a>
            <a href="${pageContext.request.contextPath}/product?action=manage" class="nav-link active">⚙️ Quản Lý Sản Phẩm</a>
            <span class="nav-user">👤 ${sessionScope.fullName}</span>
            <a href="${pageContext.request.contextPath}/logout" class="nav-link nav-logout">🚪 Đăng Xuất</a>
        </div>
    </nav>

    <div class="container">
        <div class="form-card">
            <h2>✏️ Chỉnh Sửa Sản Phẩm</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    ⚠️ ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/product?action=update" method="POST" enctype="multipart/form-data" class="crud-form">
                <input type="hidden" name="id" value="${product.id}">

                <div class="form-group">
                    <label for="name">Tên sản phẩm <span class="required">*</span></label>
                    <input type="text" id="name" name="name" value="${product.name}" placeholder="Ví dụ: Tai nghe Sony" required autofocus>
                </div>

                <div class="form-group">
                    <label for="price">Giá bán (VNĐ) <span class="required">*</span></label>
                    <!-- Display price as a raw number for input formatting -->
                    <fmt:formatNumber var="rawPrice" value="${product.price}" pattern="0"/>
                    <input type="number" id="price" name="price" value="${rawPrice}" min="0" required>
                </div>

                <div class="form-group">
                    <label for="categoryId">Danh mục sản phẩm <span class="required">*</span></label>
                    <select id="categoryId" name="categoryId" required 
                            style="width: 100%; padding: 12px 14px; border: 2px solid #e0e0e0; border-radius: 8px; font-size: 14px; outline: none; background-color: #fff;">
                        <option value="" disabled>-- Chọn danh mục --</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.id}" ${product.categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="imageFile">Thay đổi ảnh từ máy tính (Tải ảnh mới)</label>
                    <input type="file" id="imageFile" name="imageFile" accept="image/*"
                           style="width: 100%; padding: 10px; border: 2px solid #e0e0e0; border-radius: 8px; font-size: 14px; outline: none; background-color: #fff;">
                </div>

                <div style="text-align: center; margin: 10px 0; color: #888; font-size: 13px; font-weight: 600;">-- HOẶC --</div>

                <div class="form-group">
                    <label for="imageUrl">Đường dẫn hình ảnh (URL)</label>
                    <input type="text" id="imageUrl" name="imageUrl" value="${product.imageUrl}" placeholder="Nhập link ảnh">
                </div>

                <div class="form-group">
                    <label for="description">Mô tả sản phẩm</label>
                    <textarea id="description" name="description" rows="5" placeholder="Nhập mô tả chi tiết sản phẩm...">${product.description}</textarea>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">💾 Cập Nhật Sản Phẩm</button>
                    <a href="${pageContext.request.contextPath}/product?action=manage" class="btn btn-secondary">Hủy bỏ</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
