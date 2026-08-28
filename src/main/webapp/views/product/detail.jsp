<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.name} - Chi Tiết Sản Phẩm</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">📋 LoginURL App</div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home" class="nav-link">🏠 Trang Chủ</a>
            <a href="${pageContext.request.contextPath}/category" class="nav-link">📂 Danh Mục</a>
            <a href="${pageContext.request.contextPath}/product" class="nav-link active">🛍️ Sản Phẩm</a>
            <a href="${pageContext.request.contextPath}/product?action=manage" class="nav-link">⚙️ Quản Lý Sản Phẩm</a>
            <span class="nav-user">👤 ${sessionScope.fullName}</span>
            <a href="${pageContext.request.contextPath}/logout" class="nav-link nav-logout">🚪 Đăng Xuất</a>
        </div>
    </nav>

    <div class="container">
        <div style="margin-bottom: 20px;">
            <a href="javascript:history.back()" class="btn btn-secondary" style="display: inline-flex; align-items: center; gap: 6px;">
                &larr; Quay lại
            </a>
        </div>

        <div class="product-detail-card">
            <div class="product-detail-layout">
                <!-- Cột Trái: Ảnh sản phẩm -->
                <div class="product-detail-image-sec">
                    <img src="${product.imageUrl}" alt="${product.name}" class="product-detail-img">
                </div>

                <!-- Cột Phải: Thông tin sản phẩm -->
                <div class="product-detail-info-sec">
                    <span class="product-detail-category-badge">
                        📁 Danh mục: ${not empty category ? category.name : 'Không có'}
                    </span>
                    
                    <h2 class="product-detail-title">${product.name}</h2>
                    
                    <div class="product-detail-price">
                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                    </div>

                    <div class="product-detail-divider"></div>

                    <div class="product-detail-desc-box">
                        <h4>Mô tả sản phẩm:</h4>
                        <p>${product.description}</p>
                    </div>

                    <div class="product-detail-actions" style="margin-top: 30px;">
                        <button class="btn btn-primary" onclick="alert('Đã thêm sản phẩm vào giỏ hàng giả định!')" style="padding: 14px 28px; font-size: 16px; display: inline-flex; align-items: center; gap: 8px; border-radius: 30px; box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);">
                            🛒 Thêm Vào Giỏ Hàng
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
