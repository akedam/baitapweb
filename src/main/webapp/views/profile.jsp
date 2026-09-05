<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="userObj" value="${not empty currentUser ? currentUser : sessionScope.user}" />
<c:if test="${empty userObj}">
    <c:redirect url="/login" />
</c:if>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Hồ Sơ Cá Nhân - User Profile</title>
</head>
<body>
    <div class="container py-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item active" aria-current="page">Hồ sơ cá nhân</li>
            </ol>
        </nav>

        <!-- Alert Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show d-flex align-items-center gap-2 shadow-sm rounded-3 mb-4" role="alert">
                <i class="bi bi-check-circle-fill fs-5"></i>
                <div>${success}</div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center gap-2 shadow-sm rounded-3 mb-4" role="alert">
                <i class="bi bi-exclamation-triangle-fill fs-5"></i>
                <div>${error}</div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <div class="row g-4">
            <!-- Left Column: User Summary Card -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm rounded-4 text-center p-4 h-100">
                    <div class="position-relative d-inline-block mx-auto mb-3">
                        <c:choose>
                            <c:when test="${not empty userObj.images and userObj.images != 'default-avatar.png'}">
                                <img id="avatarPreview" src="${pageContext.request.contextPath}/uploads/users/${userObj.images}" alt="Avatar" class="rounded-circle border border-4 border-primary-subtle shadow-sm object-fit-cover" style="width: 140px; height: 140px;">
                            </c:when>
                            <c:otherwise>
                                <div id="avatarPlaceholder" class="rounded-circle bg-primary-subtle text-primary border border-4 border-white shadow-sm d-flex align-items-center justify-content-center mx-auto" style="width: 140px; height: 140px; font-size: 54px;">
                                    <i class="bi bi-person-fill"></i>
                                </div>
                                <img id="avatarPreview" src="" alt="Avatar" class="rounded-circle border border-4 border-primary-subtle shadow-sm object-fit-cover d-none" style="width: 140px; height: 140px;">
                            </c:otherwise>
                        </c:choose>
                        <span class="position-absolute bottom-0 end-0 bg-success border border-white border-2 rounded-circle p-2" title="Tài khoản đã kích hoạt">
                            <span class="visually-hidden">Active</span>
                        </span>
                    </div>

                    <h4 class="fw-bold mb-1">${userObj.fullName != null ? userObj.fullName : userObj.username}</h4>
                    <p class="text-muted small mb-3">@${userObj.username}</p>

                    <div class="d-flex justify-content-center gap-2 mb-4">
                        <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-2 rounded-pill">
                            <i class="bi bi-shield-check me-1"></i> Thành viên chính thức
                        </span>
                        <c:if test="${userObj.active}">
                            <span class="badge bg-success-subtle text-success border border-success-subtle px-3 py-2 rounded-pill">
                                <i class="bi bi-patch-check-fill me-1"></i> Đã xác thực
                            </span>
                        </c:if>
                    </div>

                    <ul class="list-group list-group-flush text-start small border-top pt-3">
                        <li class="list-group-item d-flex justify-content-between px-0 py-2 border-0">
                            <span class="text-muted"><i class="bi bi-envelope me-2 text-primary"></i>Email:</span>
                            <span class="fw-semibold text-truncate ms-2" style="max-width: 180px;">${userObj.email}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between px-0 py-2 border-0">
                            <span class="text-muted"><i class="bi bi-telephone me-2 text-primary"></i>Điện thoại:</span>
                            <span class="fw-semibold">${not empty userObj.phone ? userObj.phone : 'Chưa cập nhật'}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between px-0 py-2 border-0">
                            <span class="text-muted"><i class="bi bi-key me-2 text-primary"></i>Mã User ID:</span>
                            <span class="fw-semibold font-monospace text-truncate ms-2" style="max-width: 150px;">${userObj.id}</span>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Right Column: Edit Profile Form -->
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm rounded-4 p-4">
                    <div class="d-flex align-items-center justify-content-between border-bottom pb-3 mb-4">
                        <div>
                            <h4 class="fw-bold mb-1 text-dark"><i class="bi bi-person-gear text-primary me-2"></i>Cập Nhật Thông Tin</h4>
                            <p class="text-muted small mb-0">Quản lý và cập nhật thông tin cá nhân của bạn (JPA &amp; Multipart Upload)</p>
                        </div>
                        <span class="badge bg-light text-dark border"><i class="bi bi-lock-fill me-1 text-secondary"></i>Bảo mật</span>
                    </div>

                    <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data" class="needs-validation" novalidate id="profileForm">
                        <div class="row g-3">
                            <!-- Username (Readonly) -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold text-secondary">Tên đăng nhập</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-person text-muted"></i></span>
                                    <input type="text" class="form-control bg-light" value="${userObj.username}" disabled readonly>
                                </div>
                                <div class="form-text">Tên đăng nhập không thể thay đổi.</div>
                            </div>

                            <!-- Email (Readonly) -->
                            <div class="col-md-6">
                                <label class="form-label fw-semibold text-secondary">Địa chỉ Email</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-envelope text-muted"></i></span>
                                    <input type="email" class="form-control bg-light" value="${userObj.email}" disabled readonly>
                                </div>
                                <div class="form-text">Email dùng để nhận OTP và thông báo.</div>
                            </div>

                            <!-- Full Name -->
                            <div class="col-md-6">
                                <label for="fullName" class="form-label fw-semibold">Họ và tên <span class="text-danger">*</span></label>
                                <div class="input-group has-validation">
                                    <span class="input-group-text bg-white"><i class="bi bi-person-badge text-primary"></i></span>
                                    <input type="text" class="form-control" id="fullName" name="fullName" value="${userObj.fullName}" required minlength="2" maxlength="100" placeholder="Nguyễn Văn A">
                                    <div class="invalid-feedback">Vui lòng nhập họ và tên (tối thiểu 2 ký tự).</div>
                                </div>
                            </div>

                            <!-- Phone Number -->
                            <div class="col-md-6">
                                <label for="phone" class="form-label fw-semibold">Số điện thoại</label>
                                <div class="input-group has-validation">
                                    <span class="input-group-text bg-white"><i class="bi bi-telephone text-primary"></i></span>
                                    <input type="tel" class="form-control" id="phone" name="phone" value="${userObj.phone}" pattern="^(0|\+84)(3|5|7|8|9)[0-9]{8}$" placeholder="0912345678">
                                    <div class="invalid-feedback">Số điện thoại phải hợp lệ (VD: 0912345678 hoặc +84912345678).</div>
                                </div>
                                <div class="form-text">Định dạng 10 số di động tại Việt Nam.</div>
                            </div>

                            <!-- Avatar Image Upload (Multipart) -->
                            <div class="col-12">
                                <label for="image" class="form-label fw-semibold">Thay đổi ảnh đại diện (Avatar)</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-white"><i class="bi bi-image text-primary"></i></span>
                                    <input type="file" class="form-control" id="image" name="image" accept="image/png, image/jpeg, image/jpg, image/webp, image/gif">
                                </div>
                                <div class="form-text">Hỗ trợ: JPG, PNG, WEBP, GIF. Kích thước tối đa: 5MB.</div>
                            </div>
                        </div>

                        <hr class="my-4">

                        <div class="d-flex align-items-center justify-content-end gap-3">
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary px-4 rounded-pill">
                                <i class="bi bi-arrow-left me-1"></i> Quay lại
                            </a>
                            <button type="submit" class="btn btn-primary px-4 rounded-pill shadow-sm fw-semibold">
                                <i class="bi bi-save me-1"></i> Lưu thay đổi
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Avatar Live Preview Script -->
    <script>
        const imageInput = document.getElementById('image');
        const avatarPreview = document.getElementById('avatarPreview');
        const avatarPlaceholder = document.getElementById('avatarPlaceholder');

        if (imageInput) {
            imageInput.addEventListener('change', function (e) {
                const file = e.target.files[0];
                if (file) {
                    if (file.size > 5 * 1024 * 1024) {
                        alert('Kích thước ảnh vượt quá 5MB! Vui lòng chọn ảnh khác.');
                        imageInput.value = '';
                        return;
                    }
                    const reader = new FileReader();
                    reader.onload = function (event) {
                        avatarPreview.src = event.target.result;
                        avatarPreview.classList.remove('d-none');
                        if (avatarPlaceholder) {
                            avatarPlaceholder.classList.add('d-none');
                        }
                    };
                    reader.readAsDataURL(file);
                }
            });
        }
    </script>
</body>
</html>
