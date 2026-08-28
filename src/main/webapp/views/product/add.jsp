<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Sản Phẩm Mới - LoginURL</title>
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
            <h2>➕ Thêm Sản Phẩm Mới</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    ⚠️ ${error}
                </div>
            </c:if>

            <c:choose>
                <c:when test="${empty categories}">
                    <div class="alert alert-error" style="margin-bottom: 20px;">
                        ⚠️ Hệ thống chưa có danh mục sản phẩm nào! Vui lòng 
                        <a href="${pageContext.request.contextPath}/category?action=add" style="font-weight: bold; text-decoration: underline; color: inherit;">
                            thêm danh mục sản phẩm trước
                        </a>.
                    </div>
                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/product?action=manage" class="btn btn-secondary">&larr; Quay lại</a>
                        <a href="${pageContext.request.contextPath}/category?action=add" class="btn btn-primary">➕ Tạo danh mục</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <form action="${pageContext.request.contextPath}/product?action=add" method="POST" enctype="multipart/form-data" class="crud-form">
                        <div class="form-group">
                            <label for="name">Tên sản phẩm <span class="required">*</span></label>
                            <input type="text" id="name" name="name" placeholder="Ví dụ: Tai nghe chống ồn Sony WH-1000XM4" required autofocus>
                        </div>

                        <div class="form-group">
                            <label for="price">Giá bán (VNĐ) <span class="required">*</span></label>
                            <input type="number" id="price" name="price" min="0" placeholder="Ví dụ: 4500000" required>
                        </div>

                        <div class="form-group">
                            <label for="categoryId">Danh mục sản phẩm <span class="required">*</span></label>
                            <select id="categoryId" name="categoryId" required 
                                    style="width: 100%; padding: 12px 14px; border: 2px solid #e0e0e0; border-radius: 8px; font-size: 14px; outline: none; background-color: #fff;">
                                <option value="" disabled selected>-- Chọn danh mục --</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}">${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="imageFile">Tải ảnh lên từ máy tính</label>
                            <input type="file" id="imageFile" name="imageFile" accept="image/*"
                                   style="width: 100%; padding: 10px; border: 2px solid #e0e0e0; border-radius: 8px; font-size: 14px; outline: none; background-color: #fff;">
                        </div>

                        <div style="text-align: center; margin: 10px 0; color: #888; font-size: 13px; font-weight: 600;">-- HOẶC --</div>

                        <div class="form-group">
                            <label for="imageUrl">Đường dẫn hình ảnh (URL)</label>
                            <input type="text" id="imageUrl" name="imageUrl" placeholder="Nhập link ảnh (ví dụ từ Unsplash, Pinterest...)">
                        </div>

                        <div class="form-group">
                            <label for="description">Mô tả sản phẩm</label>
                            <textarea id="description" name="description" rows="5" placeholder="Nhập mô tả chi tiết sản phẩm..."></textarea>
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">💾 Lưu Sản Phẩm</button>
                            <a href="${pageContext.request.contextPath}/product?action=manage" class="btn btn-secondary">Hủy bỏ</a>
                        </div>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
