package com.app.dao;

import com.app.model.Product;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.result.DeleteResult;
import org.bson.Document;
import org.bson.types.ObjectId;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

import static com.mongodb.client.model.Filters.eq;
import static com.mongodb.client.model.Filters.regex;
import static com.mongodb.client.model.Sorts.descending;

public class ProductDAO {
    private MongoCollection<Document> collection;

    public ProductDAO() {
        MongoDatabase db = MongoDBConnection.getInstance().getDatabase();
        collection = db.getCollection("products");
    }

    public List<Product> findAll() {
        List<Product> products = new ArrayList<>();
        for (Document doc : collection.find().sort(descending("createdAt"))) {
            products.add(documentToProduct(doc));
        }
        return products;
    }

    public Product findById(String id) {
        if (id == null || id.trim().isEmpty()) return null;
        try {
            Document doc = collection.find(eq("_id", new ObjectId(id))).first();
            return documentToProduct(doc);
        } catch (IllegalArgumentException e) {
            return null; // Invalid ObjectId
        }
    }

    public List<Product> searchByName(String keyword) {
        List<Product> products = new ArrayList<>();
        if (keyword == null || keyword.trim().isEmpty()) {
            return findAll();
        }
        Pattern pattern = Pattern.compile(Pattern.quote(keyword.trim()), Pattern.CASE_INSENSITIVE);
        for (Document doc : collection.find(regex("name", pattern)).sort(descending("createdAt"))) {
            products.add(documentToProduct(doc));
        }
        return products;
    }

    public List<Product> findByCategory(String categoryId) {
        List<Product> products = new ArrayList<>();
        if (categoryId == null || categoryId.trim().isEmpty()) {
            return findAll();
        }
        for (Document doc : collection.find(eq("categoryId", categoryId.trim())).sort(descending("createdAt"))) {
            products.add(documentToProduct(doc));
        }
        return products;
    }

    public void insert(Product product) {
        Document doc = new Document()
                .append("name", product.getName())
                .append("price", product.getPrice())
                .append("description", product.getDescription())
                .append("imageUrl", product.getImageUrl())
                .append("categoryId", product.getCategoryId())
                .append("createdAt", product.getCreatedAt() != null ? product.getCreatedAt() : new Date());
        collection.insertOne(doc);
    }

    public void update(Product product) {
        Document updateDoc = new Document("$set",
                new Document()
                        .append("name", product.getName())
                        .append("price", product.getPrice())
                        .append("description", product.getDescription())
                        .append("imageUrl", product.getImageUrl())
                        .append("categoryId", product.getCategoryId())
                        .append("createdAt", product.getCreatedAt() != null ? product.getCreatedAt() : new Date())
        );
        collection.updateOne(eq("_id", new ObjectId(product.getId())), updateDoc);
    }

    public boolean delete(String id) {
        if (id == null || id.trim().isEmpty()) return false;
        try {
            DeleteResult result = collection.deleteOne(eq("_id", new ObjectId(id)));
            return result.getDeletedCount() > 0;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    /**
     * Lấy N sản phẩm mới nhất
     */
    public List<Product> findLatestProducts(int limit) {
        List<Product> products = new ArrayList<>();
        for (Document doc : collection.find()
                .sort(descending("createdAt"))
                .limit(limit)) {
            products.add(documentToProduct(doc));
        }
        return products;
    }

    /**
     * Lấy sản phẩm phân trang
     */
    public List<Product> findPaginatedProducts(int page, int size) {
        List<Product> products = new ArrayList<>();
        int skip = (page - 1) * size;
        for (Document doc : collection.find()
                .sort(descending("createdAt"))
                .skip(skip)
                .limit(size)) {
            products.add(documentToProduct(doc));
        }
        return products;
    }

    /**
     * Đếm tổng số sản phẩm
     */
    public long countProducts() {
        return collection.countDocuments();
    }

    private Product documentToProduct(Document doc) {
        if (doc == null) return null;
        Product product = new Product();
        product.setId(doc.getObjectId("_id").toHexString());
        product.setName(doc.getString("name"));
        
        // Handle numeric conversion safely
        Object priceObj = doc.get("price");
        if (priceObj instanceof Number) {
            product.setPrice(((Number) priceObj).doubleValue());
        } else {
            product.setPrice(0.0);
        }

        product.setDescription(doc.getString("description"));
        product.setImageUrl(doc.getString("imageUrl"));
        product.setCategoryId(doc.getString("categoryId"));
        product.setCreatedAt(doc.getDate("createdAt"));
        return product;
    }
}
