<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Sản Phẩm - LoginURL</title>
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
        <div class="page-header">
            <h2>🛍️ Tất Cả Sản Phẩm</h2>
            <p style="color: #666; font-size: 14px;">Trang hiển thị đầy đủ sản phẩm (phân trang 6sp/trang)</p>
        </div>

        <c:choose>
            <c:when test="${empty products}">
                <div class="welcome-card" style="padding: 60px;">
                    <p style="font-size: 18px; color: #888; font-style: italic;">Chưa có sản phẩm nào trong hệ thống.</p>
                    <c:if test="${sessionScope.username == 'admin'}">
                        <a href="${pageContext.request.contextPath}/product?action=add" class="btn btn-primary" style="margin-top: 15px;">
                            ➕ Thêm sản phẩm đầu tiên
                        </a>
                    </c:if>
                </div>
            </c:when>
            <c:otherwise>
                <div class="products-grid">
                    <c:forEach var="p" items="${products}">
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

                <!-- Phân trang -->
                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="${pageContext.request.contextPath}/product?page=${currentPage - 1}" class="page-link">&laquo; Trước</a>
                        </c:if>
                        
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <a href="${pageContext.request.contextPath}/product?page=${i}" class="page-link ${currentPage == i ? 'active' : ''}">${i}</a>
                        </c:forEach>
                        
                        <c:if test="${currentPage < totalPages}">
                            <a href="${pageContext.request.contextPath}/product?page=${currentPage + 1}" class="page-link">Sau &raquo;</a>
                        </c:if>
                    </div>
                </c:if>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
