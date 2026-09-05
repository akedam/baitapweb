package com.app.controller;

import com.app.model.Category;
import com.app.model.Product;
import com.app.service.CategoryService;
import com.app.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@WebServlet(name = "ProductServlet", urlPatterns = {"/product"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1MB
    maxFileSize = 1024 * 1024 * 5,         // 5MB
    maxRequestSize = 1024 * 1024 * 5 * 5   // 25MB
)
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductService productService;
    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        productService = new ProductService();
        categoryService = new CategoryService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Check authentication
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "detail":
                showProductDetail(request, response);
                break;
            case "manage":
                showManageProducts(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
                break;
            case "list":
            default:
                showProductList(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Check authentication
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addProduct(request, response);
        } else if ("update".equals(action) || "edit".equals(action)) {
            updateProduct(request, response);
        }
    }

    private void showProductList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1;
        String pageStr = request.getParameter("page");
        if (pageStr != null) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        int pageSize = 8;

        String keyword = request.getParameter("keyword");
        String categoryId = request.getParameter("categoryId");

        List<Product> products;
        int totalProducts;

        if (keyword != null && !keyword.trim().isEmpty()) {
            products = productService.searchProductsByName(keyword.trim());
            totalProducts = products.size();
        } else if (categoryId != null && !categoryId.trim().isEmpty()) {
            products = productService.getProductsByCategory(categoryId.trim());
            totalProducts = products.size();
        } else {
            products = productService.getPaginatedProducts(page, pageSize);
            totalProducts = productService.getAllProducts().size();
        }

        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        if (totalPages == 0) totalPages = 1;

        // Map Category Name
        List<Category> categories = categoryService.getAllCategories();
        Map<String, String> categoriesMap = new HashMap<>();
        for (Category cat : categories) {
            categoriesMap.put(cat.getId(), cat.getName());
        }
        for (Product p : products) {
            if (p.getCategoryId() != null && categoriesMap.containsKey(p.getCategoryId())) {
                p.setCategoryName(categoriesMap.get(p.getCategoryId()));
            }
        }

        request.setAttribute("categories", categories);
        request.setAttribute("categoriesMap", categoriesMap);
        request.setAttribute("products", products);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword != null ? keyword : "");
        request.setAttribute("categoryId", categoryId != null ? categoryId : "");

        request.getRequestDispatcher("/views/product/list.jsp").forward(request, response);
    }

    private void showProductDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        Product product = productService.getProductById(id);
        if (product != null) {
            Category category = categoryService.getCategoryById(product.getCategoryId());
            if (category != null) {
                product.setCategoryName(category.getName());
            }
            request.setAttribute("product", product);
            request.setAttribute("category", category);
            request.getRequestDispatcher("/views/product/detail.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/product?error=notfound");
        }
    }

    private void showManageProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> products = productService.getAllProducts();
        List<Category> categories = categoryService.getAllCategories();
        Map<String, String> categoriesMap = new HashMap<>();
        for (Category cat : categories) {
            categoriesMap.put(cat.getId(), cat.getName());
        }
        for (Product p : products) {
            if (p.getCategoryId() != null && categoriesMap.containsKey(p.getCategoryId())) {
                p.setCategoryName(categoriesMap.get(p.getCategoryId()));
            }
        }

        request.setAttribute("products", products);
        request.setAttribute("categoriesMap", categoriesMap);

        String success = request.getParameter("success");
        String error = request.getParameter("error");
        if (success != null) {
            switch (success) {
                case "added": request.setAttribute("message", "Thêm sản phẩm thành công!"); break;
                case "updated": request.setAttribute("message", "Cập nhật sản phẩm thành công!"); break;
                case "deleted": request.setAttribute("message", "Xóa sản phẩm thành công!"); break;
            }
        }
        if (error != null) {
            request.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại!");
        }

        request.getRequestDispatcher("/views/product/manage.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> categories = categoryService.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/views/product/add.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        Product product = productService.getProductById(id);
        if (product != null) {
            List<Category> categories = categoryService.getAllCategories();
            request.setAttribute("product", product);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/views/product/edit.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/product?action=manage&error=notfound");
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String quantityStr = request.getParameter("quantity");
        String description = request.getParameter("description");
        String categoryId = request.getParameter("categoryId");

        // Validation
        StringBuilder errorMsg = new StringBuilder();
        if (name == null || name.trim().length() < 2) {
            errorMsg.append("Tên sản phẩm phải có tối thiểu 2 ký tự.<br>");
        }
        if (categoryId == null || categoryId.trim().isEmpty()) {
            errorMsg.append("Vui lòng chọn danh mục cho sản phẩm.<br>");
        }

        double price = 0;
        try {
            price = Double.parseDouble(priceStr);
            if (price < 1000) {
                errorMsg.append("Đơn giá phải từ 1,000 VNĐ trở lên.<br>");
            }
        } catch (Exception e) {
            errorMsg.append("Đơn giá không hợp lệ.<br>");
        }

        int quantity = 10;
        if (quantityStr != null && !quantityStr.trim().isEmpty()) {
            try {
                quantity = Integer.parseInt(quantityStr);
                if (quantity < 0) {
                    errorMsg.append("Số lượng không được âm.<br>");
                }
            } catch (Exception e) {
                errorMsg.append("Số lượng không hợp lệ.<br>");
            }
        }

        // Upload image
        String uploadedUrl = uploadFile(request, "image");
        if (uploadedUrl == null) {
            uploadedUrl = uploadFile(request, "imageFile");
        }
        String imageUrl = (uploadedUrl != null) ? uploadedUrl : "default.jpg";

        if (errorMsg.length() > 0) {
            request.setAttribute("error", errorMsg.toString());
            showAddForm(request, response);
            return;
        }

        boolean success = productService.addProduct(name.trim(), price, description != null ? description.trim() : "", imageUrl, categoryId.trim());
        if (success) {
            response.sendRedirect(request.getContextPath() + "/product?action=manage&success=added");
        } else {
            request.setAttribute("error", "Không thể thêm sản phẩm, vui lòng thử lại!");
            showAddForm(request, response);
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String quantityStr = request.getParameter("quantity");
        String description = request.getParameter("description");
        String categoryId = request.getParameter("categoryId");

        // Validation
        StringBuilder errorMsg = new StringBuilder();
        if (name == null || name.trim().length() < 2) {
            errorMsg.append("Tên sản phẩm phải có tối thiểu 2 ký tự.<br>");
        }
        if (categoryId == null || categoryId.trim().isEmpty()) {
            errorMsg.append("Vui lòng chọn danh mục cho sản phẩm.<br>");
        }

        double price = 0;
        try {
            price = Double.parseDouble(priceStr);
            if (price < 1000) {
                errorMsg.append("Đơn giá phải từ 1,000 VNĐ trở lên.<br>");
            }
        } catch (Exception e) {
            errorMsg.append("Đơn giá không hợp lệ.<br>");
        }

        Product oldProduct = productService.getProductById(id);
        if (oldProduct == null) {
            response.sendRedirect(request.getContextPath() + "/product?action=manage&error=notfound");
            return;
        }

        String uploadedUrl = uploadFile(request, "image");
        if (uploadedUrl == null) {
            uploadedUrl = uploadFile(request, "imageFile");
        }
        String imageUrl = (uploadedUrl != null) ? uploadedUrl : oldProduct.getImageUrl();

        if (errorMsg.length() > 0) {
            request.setAttribute("error", errorMsg.toString());
            List<Category> categories = categoryService.getAllCategories();
            request.setAttribute("product", oldProduct);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/views/product/edit.jsp").forward(request, response);
            return;
        }

        boolean success = productService.updateProduct(id, name.trim(), price, description != null ? description.trim() : "", imageUrl, categoryId.trim());
        if (success) {
            response.sendRedirect(request.getContextPath() + "/product?action=manage&success=updated");
        } else {
            request.setAttribute("error", "Cập nhật sản phẩm thất bại!");
            List<Category> categories = categoryService.getAllCategories();
            request.setAttribute("product", oldProduct);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/views/product/edit.jsp").forward(request, response);
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        boolean success = productService.deleteProduct(id);
        if (success) {
            response.sendRedirect(request.getContextPath() + "/product?action=manage&success=deleted");
        } else {
            response.sendRedirect(request.getContextPath() + "/product?action=manage&error=deletefailed");
        }
    }

    private String uploadFile(HttpServletRequest request, String inputName) {
        try {
            Part part = request.getPart(inputName);
            if (part != null && part.getSize() > 0) {
                String submittedFileName = part.getSubmittedFileName();
                if (submittedFileName != null && !submittedFileName.isEmpty()) {
                    String ext = "";
                    int dotIndex = submittedFileName.lastIndexOf('.');
                    if (dotIndex >= 0) {
                        ext = submittedFileName.substring(dotIndex).toLowerCase();
                    }
                    if (!ext.matches("\\.(jpg|jpeg|png|webp|gif)")) {
                        return null;
                    }
                    
                    String newFileName = System.currentTimeMillis() + "_" + java.util.UUID.randomUUID().toString().substring(0, 8) + ext;
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    
                    String filePath = uploadPath + File.separator + newFileName;
                    part.write(filePath);
                    return newFileName;
                }
            }
        } catch (Exception e) {
            System.err.println("File upload error: " + e.getMessage());
        }
        return null;
    }
}
