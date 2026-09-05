<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Trang Chủ - Dashboard</title>
</head>
<body>
    <div class="container py-4">
        <!-- Hero Welcome Banner -->
        <div class="card border-0 shadow-sm rounded-4 overflow-hidden mb-4 bg-primary text-white bg-gradient-hero">
            <div class="card-body p-4 p-md-5">
                <div class="row align-items-center">
                    <div class="col-lg-8">
                        <div class="d-inline-flex align-items-center gap-2 px-3 py-1 rounded-pill bg-white bg-opacity-20 backdrop-blur mb-3 small fw-semibold">
                            <i class="bi bi-stars text-warning"></i> Bài tập 03 - SiteMesh 3 &amp; JPA &amp; Form Validation
                        </div>
                        <h2 class="display-6 fw-bold mb-2">Xin chào, ${sessionScope.fullName != null ? sessionScope.fullName : sessionScope.username}! 👋</h2>
                        <p class="lead fs-6 text-white-50 mb-4">Chào mừng bạn quay trở lại với hệ thống quản lý bán hàng và dịch vụ WebStore.</p>
                        
                        <div class="d-flex flex-wrap gap-2">
                            <a href="${pageContext.request.contextPath}/profile" class="btn btn-light text-primary fw-semibold px-3 py-2 rounded-pill shadow-sm">
                                <i class="bi bi-person-circle me-1"></i> Hồ sơ cá nhân (Profile)
                            </a>
                            <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-light px-3 py-2 rounded-pill">
                                <i class="bi bi-shop me-1"></i> Xem cửa hàng
                            </a>
                            <a href="${pageContext.request.contextPath}/product?action=manage" class="btn btn-outline-light px-3 py-2 rounded-pill">
                                <i class="bi bi-boxes me-1"></i> Quản lý sản phẩm
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-4 text-center d-none d-lg-block">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user.images and sessionScope.user.images != 'default-avatar.png'}">
                                <img src="${pageContext.request.contextPath}/uploads/users/${sessionScope.user.images}" alt="Avatar" class="rounded-circle border border-4 border-white shadow-lg object-fit-cover" style="width: 130px; height: 130px;">
                            </c:when>
                            <c:otherwise>
                                <div class="rounded-circle bg-white text-primary border border-4 border-white shadow-lg d-inline-flex align-items-center justify-content-center" style="width: 130px; height: 130px; font-size: 50px;">
                                    <i class="bi bi-person-fill"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div class="mt-2 fw-semibold text-white">${sessionScope.fullName}</div>
                        <div class="small text-white-50">@${sessionScope.username}</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Metric Cards -->
        <div class="row g-3 mb-4">
            <div class="col-sm-6 col-xl-3">
                <div class="card border-0 shadow-sm rounded-4 p-3 h-100 hover-elevate transition">
                    <div class="d-flex align-items-center gap-3">
                        <div class="rounded-3 bg-primary-subtle text-primary p-3 fs-4 d-flex align-items-center justify-content-center" style="width: 54px; height: 54px;">
                            <i class="bi bi-box-seam"></i>
                        </div>
                        <div>
                            <div class="text-muted small">Tổng sản phẩm</div>
                            <div class="fs-4 fw-bold text-dark">${totalProducts != null ? totalProducts : '10+'}</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="card border-0 shadow-sm rounded-4 p-3 h-100 hover-elevate transition">
                    <div class="d-flex align-items-center gap-3">
                        <div class="rounded-3 bg-success-subtle text-success p-3 fs-4 d-flex align-items-center justify-content-center" style="width: 54px; height: 54px;">
                            <i class="bi bi-folder-check"></i>
                        </div>
                        <div>
                            <div class="text-muted small">Danh mục</div>
                            <div class="fs-4 fw-bold text-dark">${totalCategories != null ? totalCategories : 'Đang hoạt động'}</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="card border-0 shadow-sm rounded-4 p-3 h-100 hover-elevate transition">
                    <div class="d-flex align-items-center gap-3">
                        <div class="rounded-3 bg-info-subtle text-info p-3 fs-4 d-flex align-items-center justify-content-center" style="width: 54px; height: 54px;">
                            <i class="bi bi-shield-check"></i>
                        </div>
                        <div>
                            <div class="text-muted small">SiteMesh 3</div>
                            <div class="fs-6 fw-bold text-dark">Decorator Ready</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="card border-0 shadow-sm rounded-4 p-3 h-100 hover-elevate transition">
                    <div class="d-flex align-items-center gap-3">
                        <div class="rounded-3 bg-warning-subtle text-warning p-3 fs-4 d-flex align-items-center justify-content-center" style="width: 54px; height: 54px;">
                            <i class="bi bi-database-check"></i>
                        </div>
                        <div>
                            <div class="text-muted small">Quản lý CSDL</div>
                            <div class="fs-6 fw-bold text-dark">JPA &amp; Multipart</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Latest Products Section -->
        <div class="card border-0 shadow-sm rounded-4 p-4 mb-4">
            <div class="d-flex align-items-center justify-content-between mb-4 flex-wrap gap-2">
                <div>
                    <h4 class="fw-bold mb-1 text-dark"><i class="bi bi-fire text-danger me-2"></i>10 Sản Phẩm Mới Nhất</h4>
                    <p class="text-muted small mb-0">Các mặt hàng mới cập nhật trong hệ thống</p>
                </div>
                <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-primary btn-sm px-3 rounded-pill">
                    Xem tất cả <i class="bi bi-arrow-right ms-1"></i>
                </a>
            </div>

            <c:choose>
                <c:when test="${not empty latestProducts}">
                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5 g-3">
                        <c:forEach var="p" items="${latestProducts}">
                            <div class="col">
                                <div class="card h-100 border-0 shadow-sm rounded-3 overflow-hidden product-card transition">
                                    <div class="position-relative bg-light text-center d-flex align-items-center justify-content-center overflow-hidden" style="height: 160px;">
                                        <c:choose>
                                            <c:when test="${not empty p.imageUrl and (p.imageUrl.startsWith('http://') or p.imageUrl.startsWith('https://'))}">
                                                <img src="${p.imageUrl}" class="w-100 h-100 object-fit-cover" alt="${p.name}">
                                            </c:when>
                                            <c:when test="${not empty p.imageUrl and p.imageUrl.startsWith('/')}">
                                                <img src="${p.imageUrl.startsWith(pageContext.request.contextPath) ? p.imageUrl : pageContext.request.contextPath.concat(p.imageUrl)}" class="w-100 h-100 object-fit-cover" alt="${p.name}">
                                            </c:when>
                                            <c:when test="${not empty p.imageUrl and p.imageUrl != 'default.jpg'}">
                                                <img src="${pageContext.request.contextPath}/uploads/${p.imageUrl}" class="w-100 h-100 object-fit-cover" alt="${p.name}">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="w-100 h-100 d-flex align-items-center justify-content-center text-muted">
                                                    <i class="bi bi-box-seam fs-1 opacity-25"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="card-body p-3 d-flex flex-column">
                                        <h6 class="card-title fw-bold text-truncate mb-1" title="${p.name}">${p.name}</h6>
                                        <div class="text-danger fw-bold fs-6 mb-2">
                                            <fmt:formatNumber value="${p.price}" pattern="#,###"/> VNĐ
                                        </div>
                                        <div class="mt-auto pt-2">
                                            <a href="${pageContext.request.contextPath}/product?action=detail&id=${p.id}" class="btn btn-primary btn-sm w-100 rounded-pill">
                                                Chi tiết
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5 text-muted">
                        <i class="bi bi-inbox fs-1 d-block mb-2 opacity-50"></i>
                        Chưa có sản phẩm nào. Hãy <a href="${pageContext.request.contextPath}/product?action=add" class="fw-semibold text-primary">thêm sản phẩm mới</a>!
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
