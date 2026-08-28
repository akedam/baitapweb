package com.app.service;

import com.app.dao.CategoryDAO;
import com.app.model.Category;

import java.util.List;

public class CategoryService {
    private CategoryDAO categoryDAO;

    public CategoryService() {
        this.categoryDAO = new CategoryDAO();
    }

    public List<Category> getAllCategories() {
        return categoryDAO.findAll();
    }

    public Category getCategoryById(String id) {
        return categoryDAO.findById(id);
    }

    public boolean addCategory(String name, String description) {
        if (name == null || name.trim().isEmpty()) {
            return false;
        }
        Category category = new Category(name.trim(),
                description != null ? description.trim() : "");
        categoryDAO.insert(category);
        return true;
    }

    public boolean updateCategory(String id, String name, String description) {
        if (id == null || id.trim().isEmpty()
                || name == null || name.trim().isEmpty()) {
            return false;
        }
        Category category = new Category(name.trim(),
                description != null ? description.trim() : "");
        category.setId(id);
        categoryDAO.update(category);
        return true;
    }

    public boolean deleteCategory(String id) {
        if (id == null || id.trim().isEmpty()) {
            return false;
        }
        return categoryDAO.delete(id);
    }
}
