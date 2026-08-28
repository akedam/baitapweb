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

@WebServlet(name = "ProductServlet", urlPatterns = {"/product"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1MB
    maxFileSize = 1024 * 1024 * 5,         // 5MB
    maxRequestSize = 1024 * 1024 * 5 * 5   // 25MB
)
public class ProductServlet extends HttpServlet {
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

        // Check authentication
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addProduct(request, response);
        } else if ("update".equals(action)) {
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
        int pageSize = 6;
        List<Product> products = productService.getPaginatedProducts(page, pageSize);
        int totalPages = productService.getTotalPages(pageSize);

        // Đưa Map danh mục vào request để JSP tra cứu tên danh mục bằng ID
        List<Category> categories = categoryService.getAllCategories();
        java.util.Map<String, String> categoriesMap = new java.util.HashMap<>();
        for (Category cat : categories) {
            categoriesMap.put(cat.getId(), cat.getName());
        }
        request.setAttribute("categoriesMap", categoriesMap);

        request.setAttribute("products", products);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/views/product/list.jsp").forward(request, response);
    }

    private void showProductDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        Product product = productService.getProductById(id);
        if (product != null) {
            Category category = categoryService.getCategoryById(product.getCategoryId());
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
        request.setAttribute("products", products);

        // Đưa Map danh mục vào request để JSP tra cứu tên danh mục bằng ID
        List<Category> categories = categoryService.getAllCategories();
        java.util.Map<String, String> categoriesMap = new java.util.HashMap<>();
        for (Category cat : categories) {
            categoriesMap.put(cat.getId(), cat.getName());
        }
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
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");
        String categoryId = request.getParameter("categoryId");

        // Xử lý upload file hình ảnh bằng Multipart
        String uploadedUrl = uploadFile(request, "imageFile");
        if (uploadedUrl != null) {
            imageUrl = uploadedUrl;
        }

        double price = 0;
        try {
            price = Double.parseDouble(priceStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Giá sản phẩm không hợp lệ!");
            showAddForm(request, response);
            return;
        }

        boolean success = productService.addProduct(name, price, description, imageUrl, categoryId);
        if (success) {
            response.sendRedirect(request.getContextPath() + "/product?action=manage&success=added");
        } else {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            showAddForm(request, response);
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");
        String categoryId = request.getParameter("categoryId");

        // Xử lý upload file hình ảnh mới nếu có
        String uploadedUrl = uploadFile(request, "imageFile");
        if (uploadedUrl != null) {
            imageUrl = uploadedUrl;
        } else {
            // Nếu không upload file mới, xem người dùng có truyền url text không, nếu không giữ ảnh cũ
            if (imageUrl == null || imageUrl.trim().isEmpty()) {
                Product oldProduct = productService.getProductById(id);
                if (oldProduct != null) {
                    imageUrl = oldProduct.getImageUrl();
                }
            }
        }

        double price = 0;
        try {
            price = Double.parseDouble(priceStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Giá sản phẩm không hợp lệ!");
            Product product = productService.getProductById(id);
            List<Category> categories = categoryService.getAllCategories();
            request.setAttribute("product", product);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/views/product/edit.jsp").forward(request, response);
            return;
        }

        boolean success = productService.updateProduct(id, name, price, description, imageUrl, categoryId);
        if (success) {
            response.sendRedirect(request.getContextPath() + "/product?action=manage&success=updated");
        } else {
            request.setAttribute("error", "Cập nhật sản phẩm thất bại!");
            Product product = productService.getProductById(id);
            List<Category> categories = categoryService.getAllCategories();
            request.setAttribute("product", product);
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

    /**
     * Phương thức tiện ích để xử lý việc upload hình ảnh sản phẩm.
     * Lưu file vào thư mục '/uploads' của webapp để có thể truy cập qua URL tương đối.
     */
    private String uploadFile(HttpServletRequest request, String inputName) throws IOException, ServletException {
        try {
            Part part = request.getPart(inputName);
            if (part != null && part.getSize() > 0) {
                String submittedFileName = part.getSubmittedFileName();
                if (submittedFileName != null && !submittedFileName.isEmpty()) {
                    // Trích xuất phần đuôi mở rộng file (.jpg, .png...)
                    String ext = "";
                    int dotIndex = submittedFileName.lastIndexOf('.');
                    if (dotIndex >= 0) {
                        ext = submittedFileName.substring(dotIndex);
                    }
                    
                    // Sinh tên tệp tin ngẫu nhiên tránh trùng lặp
                    String newFileName = System.currentTimeMillis() + "_" + java.util.UUID.randomUUID().toString().substring(0, 8) + ext;
                    
                    // Lưu vào thư mục của Project khi được deploy
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdir();
                    }
                    
                    String filePath = uploadPath + File.separator + newFileName;
                    part.write(filePath);
                    
                    // Trả về đường dẫn tương đối để hiển thị trên trình duyệt
                    return request.getContextPath() + "/uploads/" + newFileName;
                  }
              }
          } catch (Exception e) {
              System.err.println("File upload error: " + e.getMessage());
          }
          return null;
      }
  }
