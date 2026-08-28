package com.app.service;

import com.app.dao.ProductDAO;
import com.app.model.Product;

import java.util.List;

public class ProductService {
    private ProductDAO productDAO;

    public ProductService() {
        this.productDAO = new ProductDAO();
    }

    public List<Product> getAllProducts() {
        return productDAO.findAll();
    }

    public Product getProductById(String id) {
        if (id == null || id.trim().isEmpty()) {
            return null;
        }
        return productDAO.findById(id);
    }

    public boolean addProduct(String name, double price, String description, String imageUrl, String categoryId) {
        if (name == null || name.trim().isEmpty() || price < 0 || categoryId == null || categoryId.trim().isEmpty()) {
            return false;
        }
        
        // Default placeholder image if none provided
        String img = (imageUrl == null || imageUrl.trim().isEmpty()) 
                     ? "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&auto=format&fit=crop&q=60"
                     : imageUrl.trim();

        Product product = new Product(
                name.trim(),
                price,
                description != null ? description.trim() : "",
                img,
                categoryId.trim()
        );
        productDAO.insert(product);
        return true;
    }

    public boolean updateProduct(String id, String name, double price, String description, String imageUrl, String categoryId) {
        if (id == null || id.trim().isEmpty() || name == null || name.trim().isEmpty() || price < 0 || categoryId == null || categoryId.trim().isEmpty()) {
            return false;
        }

        Product product = productDAO.findById(id);
        if (product == null) {
            return false;
        }

        String img = (imageUrl == null || imageUrl.trim().isEmpty()) 
                     ? "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&auto=format&fit=crop&q=60"
                     : imageUrl.trim();

        product.setName(name.trim());
        product.setPrice(price);
        product.setDescription(description != null ? description.trim() : "");
        product.setImageUrl(img);
        product.setCategoryId(categoryId.trim());

        productDAO.update(product);
        return true;
    }

    public boolean deleteProduct(String id) {
        if (id == null || id.trim().isEmpty()) {
            return false;
        }
        return productDAO.delete(id);
    }

    public List<Product> getLatestProducts(int limit) {
        return productDAO.findLatestProducts(limit);
    }

    public List<Product> getPaginatedProducts(int page, int size) {
        if (page < 1) page = 1;
        return productDAO.findPaginatedProducts(page, size);
    }

    public int getTotalPages(int size) {
        long totalProducts = productDAO.countProducts();
        if (totalProducts == 0) return 1;
        return (int) Math.ceil((double) totalProducts / size);
    }

    public long getTotalProducts() {
        return productDAO.countProducts();
    }
}
