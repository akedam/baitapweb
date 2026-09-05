package com.app.controller;

import com.app.model.Category;
import com.app.service.CategoryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CategoryServlet", urlPatterns = {"/category"})
public class CategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        categoryService = new CategoryService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Check session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                request.getRequestDispatcher("/views/category/add.jsp").forward(request, response);
                break;

            case "edit":
                String editId = request.getParameter("id");
                Category category = categoryService.getCategoryById(editId);
                if (category != null) {
                    request.setAttribute("category", category);
                    request.getRequestDispatcher("/views/category/edit.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/category?error=notfound");
                }
                break;

            case "delete":
                String deleteId = request.getParameter("id");
                categoryService.deleteCategory(deleteId);
                response.sendRedirect(request.getContextPath() + "/category?success=deleted");
                break;

            case "list":
            default:
                List<Category> categories = categoryService.getAllCategories();
                request.setAttribute("categories", categories);

                String success = request.getParameter("success");
                String error = request.getParameter("error");
                if (success != null) {
                    switch (success) {
                        case "added": request.setAttribute("message", "Thêm danh mục thành công!"); break;
                        case "updated": request.setAttribute("message", "Cập nhật danh mục thành công!"); break;
                        case "deleted": request.setAttribute("message", "Xóa danh mục thành công!"); break;
                    }
                }
                if (error != null) {
                    request.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại!");
                }

                request.getRequestDispatcher("/views/category/list.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Check session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String name = request.getParameter("name");
            String description = request.getParameter("description");

            if (name == null || name.trim().length() < 2) {
                request.setAttribute("error", "Tên danh mục phải có từ 2 đến 100 ký tự!");
                request.setAttribute("param_name", name);
                request.setAttribute("param_description", description);
                request.getRequestDispatcher("/views/category/add.jsp").forward(request, response);
                return;
            }

            if (categoryService.addCategory(name.trim(), description != null ? description.trim() : "")) {
                response.sendRedirect(request.getContextPath() + "/category?success=added");
            } else {
                request.setAttribute("error", "Không thể thêm danh mục, vui lòng kiểm tra lại!");
                request.getRequestDispatcher("/views/category/add.jsp").forward(request, response);
            }

        } else if ("edit".equals(action) || "update".equals(action)) {
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String description = request.getParameter("description");

            if (name == null || name.trim().length() < 2) {
                request.setAttribute("error", "Tên danh mục phải có từ 2 đến 100 ký tự!");
                Category category = new Category();
                category.setId(id);
                category.setName(name);
                category.setDescription(description);
                request.setAttribute("category", category);
                request.getRequestDispatcher("/views/category/edit.jsp").forward(request, response);
                return;
            }

            if (categoryService.updateCategory(id, name.trim(), description != null ? description.trim() : "")) {
                response.sendRedirect(request.getContextPath() + "/category?success=updated");
            } else {
                request.setAttribute("error", "Cập nhật thất bại! Kiểm tra lại thông tin.");
                Category category = categoryService.getCategoryById(id);
                request.setAttribute("category", category);
                request.getRequestDispatcher("/views/category/edit.jsp").forward(request, response);
            }
        }
    }
}
