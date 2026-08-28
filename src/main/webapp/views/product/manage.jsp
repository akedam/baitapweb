<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Sản Phẩm - LoginURL</title>
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
        <div class="page-header">
            <h2>⚙️ Quản Lý Sản Phẩm</h2>
            <a href="${pageContext.request.contextPath}/product?action=add" class="btn btn-primary">
                ➕ Thêm Sản Phẩm Mới
            </a>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-success">
                ✅ ${message}
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                ⚠️ ${error}
            </div>
        </c:if>

        <div class="table-wrapper">
            <table class="data-table">
                <thead>
                    <tr>
                        <th style="width: 60px; text-align: center;">STT</th>
                        <th style="width: 100px;">Hình Ảnh</th>
                        <th>Tên Sản Phẩm</th>
                        <th style="width: 140px;">Giá Bán</th>
                        <th style="width: 160px;">Danh Mục</th>
                        <th style="width: 150px; text-align: center;">Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty products}">
                            <tr>
                                <td colspan="6" class="empty-message">Chưa có sản phẩm nào. Hãy bấm "Thêm Sản Phẩm Mới" để bắt đầu!</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="p" items="${products}" varStatus="status">
                                <tr>
                                    <td style="text-align: center; font-weight: 600;">${status.index + 1}</td>
                                    <td>
                                        <img src="${p.imageUrl}" alt="${p.name}" 
                                             style="width: 60px; height: 60px; object-fit: cover; border-radius: 6px; border: 1px solid #ddd; display: block;">
                                    </td>
                                    <td style="font-weight: 600; color: #333;">${p.name}</td>
                                    <td style="font-weight: bold; color: #e74c3c;">
                                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                    </td>
                                    <td>
                                        <span class="category-badge" style="background-color: #eef2f7; color: #555; padding: 4px 8px; border-radius: 4px; font-size: 13px; font-weight: 500; border: 1px solid #e2e8f0;">
                                            ${not empty categoriesMap[p.categoryId] ? categoriesMap[p.categoryId] : 'Không xác định'}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="action-cell" style="justify-content: center;">
                                            <a href="${pageContext.request.contextPath}/product?action=edit&id=${p.id}" class="btn btn-sm btn-edit">
                                                ✏️ Sửa
                                            </a>
                                            <a href="${pageContext.request.contextPath}/product?action=delete&id=${p.id}" 
                                               class="btn btn-sm btn-delete" 
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này không?');">
                                                🗑️ Xóa
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
