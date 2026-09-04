<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - WebStore Authentication</title>
    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- Google Font: Plus Jakarta Sans -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <sitemesh:write property='head'/>
</head>
<body class="auth-bg d-flex flex-column min-vh-100 justify-content-center align-items-center py-5">

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-sm-10 col-md-8 col-lg-6 col-xl-5">
                <!-- Branding Header -->
                <div class="text-center mb-4">
                    <a href="${pageContext.request.contextPath}/home" class="text-decoration-none d-inline-flex align-items-center gap-2">
                        <div class="auth-logo-badge bg-primary text-white rounded-3 d-flex align-items-center justify-content-center shadow-sm" style="width: 44px; height: 44px; font-size: 22px;">
                            <i class="bi bi-shield-lock-fill"></i>
                        </div>
                        <span class="fs-3 fw-bold text-dark tracking-tight">WebStore</span>
                    </a>
                </div>

                <!-- Body Content Injected via SiteMesh 3 -->
                <div class="card auth-card border-0 shadow-lg rounded-4 overflow-hidden">
                    <sitemesh:write property='body'/>
                </div>

                <!-- Footer note -->
                <div class="text-center mt-4 text-muted small">
                    &copy; 2026 WebStore System. Bảo mật &amp; An toàn.
                </div>
            </div>
        </div>
    </div>

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
