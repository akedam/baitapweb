<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - WebStore</title>
    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <!-- Google Font: Plus Jakarta Sans -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <sitemesh:write property='head'/>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">

    <!-- Modern Header / Navbar -->
    <header class="sticky-top">
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary-gradient shadow-sm">
            <div class="container">
                <a class="navbar-brand d-flex align-items-center gap-2 fw-bold" href="${pageContext.request.contextPath}/home">
                    <span class="brand-icon"><i class="bi bi-box-seam-fill"></i></span>
                    <span class="brand-text">WebStore <span class="badge bg-light text-primary fs-xs">PRO</span></span>
                </a>

                <button class="navbar-toggler border-0 shadow-none" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain" aria-controls="navbarMain" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarMain">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link px-3" href="${pageContext.request.contextPath}/home">
                                <i class="bi bi-house-door-fill me-1"></i> Trang Chủ
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link px-3" href="${pageContext.request.contextPath}/product">
                                <i class="bi bi-shop me-1"></i> Cửa Hàng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link px-3" href="${pageContext.request.contextPath}/product?action=manage">
                                <i class="bi bi-grid-3x3-gap-fill me-1"></i> Quản Lý SP
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link px-3" href="${pageContext.request.contextPath}/category">
                                <i class="bi bi-folder-fill me-1"></i> Danh Mục
                            </a>
                        </li>
                    </ul>

                    <!-- User Actions / Profile Dropdown -->
                    <ul class="navbar-nav align-items-center gap-2">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle user-pill d-flex align-items-center gap-2 px-3 py-1 rounded-pill bg-white bg-opacity-10 border border-white border-opacity-20 text-white" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.user.images and sessionScope.user.images != 'default-avatar.png'}">
                                                <img src="${pageContext.request.contextPath}/uploads/users/${sessionScope.user.images}" alt="Avatar" class="rounded-circle border border-2 border-white" style="width: 32px; height: 32px; object-fit: cover;">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="avatar-placeholder rounded-circle bg-white text-primary d-flex align-items-center justify-content-center fw-bold" style="width: 32px; height: 32px; font-size: 14px;">
                                                    <i class="bi bi-person-fill"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <span class="fw-semibold">${sessionScope.fullName != null ? sessionScope.fullName : sessionScope.username}</span>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 rounded-3 mt-2 animate-slide-down" aria-labelledby="userDropdown">
                                        <li class="px-3 py-2 border-bottom">
                                            <div class="text-muted small">Đăng nhập với</div>
                                            <div class="fw-bold text-truncate" style="max-width: 180px;">${sessionScope.user.email != null ? sessionScope.user.email : sessionScope.username}</div>
                                        </li>
                                        <li>
                                            <a class="dropdown-item py-2 d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/profile">
                                                <i class="bi bi-person-gear text-primary"></i> Thông tin cá nhân (Profile)
                                            </a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item py-2 d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/product?action=manage">
                                                <i class="bi bi-boxes text-info"></i> Quản lý sản phẩm
                                            </a>
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li>
                                            <a class="dropdown-item py-2 d-flex align-items-center gap-2 text-danger" href="${pageContext.request.contextPath}/logout">
                                                <i class="bi bi-box-arrow-right"></i> Đăng xuất
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="nav-item">
                                    <a class="btn btn-outline-light btn-sm px-3 rounded-pill" href="${pageContext.request.contextPath}/login">Đăng Nhập</a>
                                </li>
                                <li class="nav-item">
                                    <a class="btn btn-light btn-sm px-3 rounded-pill text-primary fw-bold" href="${pageContext.request.contextPath}/register">Đăng Ký</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <!-- Main Content Area (Injected via SiteMesh 3) -->
    <main class="flex-grow-1">
        <sitemesh:write property='body'/>
    </main>

    <!-- Footer -->
    <footer class="bg-white border-top mt-auto py-4">
        <div class="container text-center">
            <div class="row align-items-center">
                <div class="col-md-6 text-md-start mb-2 mb-md-0">
                    <p class="mb-0 text-muted small">&copy; 2026 <strong>WebStore App</strong> - Hệ thống quản lý bán hàng & bài tập Lập trình Web.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <span class="badge bg-primary-subtle text-primary border border-primary-subtle me-1"><i class="bi bi-shield-check"></i> SiteMesh 3 Decorator</span>
                    <span class="badge bg-success-subtle text-success border border-success-subtle me-1"><i class="bi bi-database"></i> JPA Entity</span>
                    <span class="badge bg-info-subtle text-info border border-info-subtle"><i class="bi bi-bootstrap"></i> Bootstrap 5.3</span>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Global Client Form Validation script -->
    <script>
        (() => {
            'use strict';
            const forms = document.querySelectorAll('.needs-validation');
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        })();
    </script>
</body>
</html>
