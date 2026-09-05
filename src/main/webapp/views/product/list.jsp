<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Cửa Hàng Sản Phẩm - Products</title>
</head>
<body>
    <div class="container py-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb" class="mb-3">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item active" aria-current="page">Cửa hàng sản phẩm</li>
            </ol>
        </nav>

        <!-- Search & Filter Bar -->
        <div class="card border-0 shadow-sm rounded-4 p-4 mb-4">
            <form action="${pageContext.request.contextPath}/product" method="get" class="row g-3 align-items-center">
                <div class="col-md-5">
                    <div class="input-group">
                        <span class="input-group-text bg-white"><i class="bi bi-search text-muted"></i></span>
                        <input type="text" class="form-control" name="keyword" value="${keyword}" placeholder="Tìm kiếm theo tên sản phẩm...">
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="input-group">
                        <span class="input-group-text bg-white"><i class="bi bi-filter text-muted"></i></span>
                        <select class="form-select" name="categoryId" onchange="this.form.submit()">
                            <option value="">-- Tất cả danh mục --</option>
                            <c:forEach var="c" items="${categories}">
                                <option value="${c.id}" ${categoryId == c.id ? 'selected' : ''}>${c.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="col-md-3 d-flex gap-2">
                    <button type="submit" class="btn btn-primary px-4 rounded-pill w-100 fw-semibold">
                        <i class="bi bi-search me-1"></i> Tìm kiếm
                    </button>
                    <c:if test="${not empty keyword or not empty categoryId}">
                        <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-secondary rounded-pill px-3" title="Đặt lại bộ lọc">
                            <i class="bi bi-arrow-counterclockwise"></i>
                        </a>
                    </c:if>
                </div>
            </form>
        </div>

        <!-- Product Grid -->
        <c:choose>
            <c:when test="${not empty products}">
                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4 mb-4">
                    <c:forEach var="p" items="${products}">
                        <div class="col">
                            <div class="card h-100 border-0 shadow-sm rounded-4 overflow-hidden product-card transition">
                                <div class="position-relative bg-light text-center" style="height: 200px;">
                                    <c:choose>
                                        <c:when test="${not empty p.image and p.image != 'default.jpg'}">
                                            <img src="${pageContext.request.contextPath}/uploads/${p.image}" class="w-100 h-100 object-fit-cover" alt="${p.name}">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="w-100 h-100 d-flex align-items-center justify-content-center text-muted">
                                                <i class="bi bi-image fs-1 opacity-25"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:if test="${p.quantity <= 0}">
                                        <span class="badge bg-danger position-absolute top-0 end-0 m-3 px-3 py-2 rounded-pill shadow-sm">Hết hàng</span>
                                    </c:if>
                                </div>
                                <div class="card-body p-4 d-flex flex-column">
                                    <div class="text-muted small mb-1">${p.categoryName != null ? p.categoryName : 'Danh mục chung'}</div>
                                    <h5 class="card-title fw-bold text-dark text-truncate mb-2" title="${p.name}">${p.name}</h5>
                                    <div class="text-danger fw-bold fs-5 mb-3">
                                        <fmt:formatNumber value="${p.price}" pattern="#,###"/> VNĐ
                                    </div>
                                    <div class="mt-auto d-flex gap-2">
                                        <a href="${pageContext.request.contextPath}/product?action=detail&id=${p.id}" class="btn btn-outline-primary btn-sm rounded-pill flex-grow-1">
                                            <i class="bi bi-eye me-1"></i> Chi tiết
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Page navigation" class="mt-4">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link rounded-circle mx-1" href="${pageContext.request.contextPath}/product?page=${currentPage - 1}&keyword=${keyword}&categoryId=${categoryId}" aria-label="Previous">
                                    <i class="bi bi-chevron-left"></i>
                                </a>
                            </li>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link rounded-circle mx-1" href="${pageContext.request.contextPath}/product?page=${i}&keyword=${keyword}&categoryId=${categoryId}">${i}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link rounded-circle mx-1" href="${pageContext.request.contextPath}/product?page=${currentPage + 1}&keyword=${keyword}&categoryId=${categoryId}" aria-label="Next">
                                    <i class="bi bi-chevron-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </c:when>
            <c:otherwise>
                <div class="card border-0 shadow-sm rounded-4 p-5 text-center text-muted">
                    <i class="bi bi-search fs-1 d-block mb-3 opacity-25"></i>
                    <h5>Không tìm thấy sản phẩm nào phù hợp!</h5>
                    <p class="small text-muted mb-3">Vui lòng thử từ khóa khác hoặc xóa bộ lọc để xem toàn bộ sản phẩm.</p>
                    <div>
                        <a href="${pageContext.request.contextPath}/product" class="btn btn-primary btn-sm px-4 rounded-pill">Xem tất cả sản phẩm</a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
