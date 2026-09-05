<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Thêm Sản Phẩm Mới - Add Product</title>
</head>
<body>
    <div class="container py-4">
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" class="text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/product?action=manage" class="text-decoration-none">Quản lý sản phẩm</a></li>
                <li class="breadcrumb-item active" aria-current="page">Thêm mới</li>
            </ol>
        </nav>

        <div class="row justify-content-center">
            <div class="col-lg-9">
                <div class="card border-0 shadow-sm rounded-4 p-4 p-sm-5">
                    <div class="d-flex align-items-center gap-3 border-bottom pb-3 mb-4">
                        <div class="p-3 bg-primary-subtle text-primary rounded-3 fs-4">
                            <i class="bi bi-bag-plus-fill"></i>
                        </div>
                        <div>
                            <h4 class="fw-bold mb-0 text-dark">Thêm Sản Phẩm Mới</h4>
                            <p class="text-muted small mb-0">Điền thông tin chi tiết và tải ảnh sản phẩm</p>
                        </div>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center gap-2 rounded-3 mb-4 small" role="alert">
                            <i class="bi bi-exclamation-triangle-fill flex-shrink-0"></i>
                            <div>${error}</div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/product" method="post" enctype="multipart/form-data" class="needs-validation" novalidate id="addProductForm">
                        <input type="hidden" name="action" value="add">

                        <div class="row g-3">
                            <!-- Product Name -->
                            <div class="col-md-8">
                                <label for="name" class="form-label fw-semibold">Tên sản phẩm <span class="text-danger">*</span></label>
                                <div class="input-group has-validation">
                                    <span class="input-group-text bg-light"><i class="bi bi-box-seam text-muted"></i></span>
                                    <input type="text" class="form-control" id="name" name="name" value="${param.name}" placeholder="VD: iPhone 15 Pro Max 256GB" required minlength="2" maxlength="150">
                                    <div class="invalid-feedback">Vui lòng nhập tên sản phẩm (từ 2 đến 150 ký tự).</div>
                                </div>
                            </div>

                            <!-- Category -->
                            <div class="col-md-4">
                                <label for="categoryId" class="form-label fw-semibold">Danh mục <span class="text-danger">*</span></label>
                                <div class="input-group has-validation">
                                    <span class="input-group-text bg-light"><i class="bi bi-folder text-muted"></i></span>
                                    <select class="form-select" id="categoryId" name="categoryId" required>
                                        <option value="">-- Chọn danh mục --</option>
                                        <c:forEach var="cat" items="${categories}">
                                            <option value="${cat.id}" ${param.categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                                        </c:forEach>
                                    </select>
                                    <div class="invalid-feedback">Vui lòng chọn danh mục cho sản phẩm.</div>
                                </div>
                            </div>

                            <!-- Price -->
                            <div class="col-md-6">
                                <label for="price" class="form-label fw-semibold">Đơn giá (VNĐ) <span class="text-danger">*</span></label>
                                <div class="input-group has-validation">
                                    <span class="input-group-text bg-light"><i class="bi bi-currency-dollar text-muted"></i></span>
                                    <input type="number" class="form-control" id="price" name="price" value="${param.price}" placeholder="VD: 25000000" required min="1000" step="1000">
                                    <div class="invalid-feedback">Đơn giá phải là số nguyên dương tối thiểu 1,000 VNĐ.</div>
                                </div>
                            </div>

                            <!-- Quantity -->
                            <div class="col-md-6">
                                <label for="quantity" class="form-label fw-semibold">Số lượng tồn kho <span class="text-danger">*</span></label>
                                <div class="input-group has-validation">
                                    <span class="input-group-text bg-light"><i class="bi bi-stack text-muted"></i></span>
                                    <input type="number" class="form-control" id="quantity" name="quantity" value="${param.quantity != null ? param.quantity : '10'}" placeholder="VD: 50" required min="0" step="1">
                                    <div class="invalid-feedback">Số lượng tồn kho không được âm.</div>
                                </div>
                            </div>

                            <!-- Image Upload with Live Preview -->
                            <div class="col-12">
                                <label for="image" class="form-label fw-semibold">Hình ảnh sản phẩm</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-image text-muted"></i></span>
                                    <input type="file" class="form-control" id="image" name="image" accept="image/png, image/jpeg, image/jpg, image/webp">
                                </div>
                                <div class="form-text">Định dạng hỗ trợ: JPG, PNG, WEBP. Tối đa 5MB.</div>
                                <div class="mt-2 text-center d-none" id="previewContainer">
                                    <img id="imagePreview" src="" alt="Preview" class="rounded-3 border shadow-xs object-fit-cover" style="max-height: 180px;">
                                </div>
                            </div>

                            <!-- Description -->
                            <div class="col-12">
                                <label for="description" class="form-label fw-semibold">Mô tả sản phẩm</label>
                                <textarea class="form-control" id="description" name="description" rows="4" placeholder="Nhập thông số, tính năng nổi bật của sản phẩm...">${param.description}</textarea>
                            </div>
                        </div>

                        <div class="d-flex align-items-center justify-content-end gap-2 pt-4 mt-3 border-top">
                            <a href="${pageContext.request.contextPath}/product?action=manage" class="btn btn-outline-secondary px-4 rounded-pill">
                                <i class="bi bi-x-lg me-1"></i> Hủy bỏ
                            </a>
                            <button type="submit" class="btn btn-primary px-4 rounded-pill shadow-sm fw-semibold">
                                <i class="bi bi-check-lg me-1"></i> Lưu Sản Phẩm
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        const imageInput = document.getElementById('image');
        const previewContainer = document.getElementById('previewContainer');
        const imagePreview = document.getElementById('imagePreview');

        if (imageInput) {
            imageInput.addEventListener('change', function(e) {
                const file = e.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function(event) {
                        imagePreview.src = event.target.result;
                        previewContainer.classList.remove('d-none');
                    };
                    reader.readAsDataURL(file);
                }
            });
        }
    </script>
</body>
</html>
