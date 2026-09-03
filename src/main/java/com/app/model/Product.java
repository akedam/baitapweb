package com.app.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "products")
public class Product implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id", length = 50)
    private String id;

    @Column(name = "name", nullable = false, length = 150)
    private String name;

    @Column(name = "price", nullable = false)
    private double price;

    @Column(name = "quantity")
    private int quantity = 10;

    @Column(name = "description", length = 1000)
    private String description;

    @Column(name = "image_url", length = 255)
    private String imageUrl;

    @Column(name = "category_id", length = 50)
    private String categoryId;

    @Column(name = "created_at")
    private Date createdAt;

    @Transient
    private String categoryName;

    public Product() {
        this.createdAt = new Date();
    }

    public Product(String name, double price, String description, String imageUrl, String categoryId) {
        this.name = name;
        this.price = price;
        this.quantity = 10;
        this.description = description;
        this.imageUrl = imageUrl;
        this.categoryId = categoryId;
        this.createdAt = new Date();
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    // Alias for JSTL convenience
    public String getImage() {
        if (imageUrl == null || imageUrl.isEmpty()) return "";
        if (imageUrl.startsWith("/")) {
            int lastSlash = imageUrl.lastIndexOf('/');
            return imageUrl.substring(lastSlash + 1);
        }
        return imageUrl;
    }

    public String getCategoryId() { return categoryId; }
    public void setCategoryId(String categoryId) { this.categoryId = categoryId; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
}
