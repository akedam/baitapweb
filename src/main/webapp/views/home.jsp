<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ - LoginURL</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">📋 LoginURL App</div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home" class="nav-link active">🏠 Trang Chủ</a>
            <a href="${pageContext.request.contextPath}/category" class="nav-link">📂 Danh Mục</a>
            <a href="${pageContext.request.contextPath}/product" class="nav-link">🛍️ Sản Phẩm</a>
            <a href="${pageContext.request.contextPath}/product?action=manage" class="nav-link">⚙️ Quản Lý Sản Phẩm</a>
            <span class="nav-user">👤 ${sessionScope.fullName}</span>
            <a href="${pageContext.request.contextPath}/logout" class="nav-link nav-logout">🚪 Đăng Xuất</a>
        </div>
    </nav>

    <div class="container">
        <div class="welcome-card">
            <h2>Chào mừng, ${sessionScope.fullName}!</h2>
            <p>Bạn đã đăng nhập thành công vào hệ thống.</p>

            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">Tên đăng nhập:</span>
                    <span class="info-value">${sessionScope.username}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Họ tên:</span>
                    <span class="info-value">${sessionScope.fullName}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Session ID:</span>
                    <span class="info-value session-id">${pageContext.session.id}</span>
                </div>
            </div>

            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/product" class="btn btn-primary" style="background: linear-gradient(135deg, #11998e, #38ef7d);">
                    🛍️ Xem Cửa Hàng
                </a>
                <a href="${pageContext.request.contextPath}/product?action=manage" class="btn btn-primary">
                    ⚙️ Quản Lý Sản Phẩm
                </a>
                <a href="${pageContext.request.contextPath}/category" class="btn btn-secondary">
                    📂 Quản Lý Danh Mục
                </a>
            </div>
        </div>

        <!-- Section: 10 sản phẩm mới nhất -->
        <div style="margin-top: 40px; margin-bottom: 40px; text-align: left;">
            <h3 style="font-size: 22px; color: #333; margin-bottom: 20px; border-bottom: 2px solid #e2e8f0; padding-bottom: 10px; display: flex; align-items: center; gap: 8px; font-weight: 700;">
                🛍️ 10 Sản Phẩm Mới Nhất
            </h3>
            
            <c:choose>
                <c:when test="${empty latestProducts}">
                    <p style="color: #888; font-style: italic; text-align: center; padding: 30px;">Chưa có sản phẩm nào mới đăng.</p>
                </c:when>
                <c:otherwise>
                    <div class="products-grid">
                        <c:forEach var="p" items="${latestProducts}">
                            <div class="product-card">
                                <a href="${pageContext.request.contextPath}/product?action=detail&id=${p.id}" class="product-card-link">
                                    <div class="product-image-wrapper">
                                        <img src="${p.imageUrl}" alt="${p.name}" class="product-image">
                                    </div>
                                    <div class="product-info">
                                        <h3 class="product-title">${p.name}</h3>
                                        <p class="product-price">
                                            <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                        </p>
                                        <p class="product-desc-short">${p.description}</p>
                                        <span class="view-detail-link">Xem chi tiết &rarr;</span>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
