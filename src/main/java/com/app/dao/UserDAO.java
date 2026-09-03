package com.app.dao;

import com.app.model.User;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.bson.types.ObjectId;

import static com.mongodb.client.model.Filters.and;
import static com.mongodb.client.model.Filters.eq;

public class UserDAO {
    private MongoCollection<Document> collection;

    public UserDAO() {
        MongoDatabase db = MongoDBConnection.getInstance().getDatabase();
        collection = db.getCollection("users");
        seedData();
    }

    /**
     * Seed default admin user if collection is empty
     */
    private void seedData() {
        if (collection.countDocuments() == 0) {
            Document admin = new Document()
                    .append("username", "admin")
                    .append("password", "admin123")
                    .append("fullName", "Administrator")
                    .append("email", "admin@example.com")
                    .append("phone", "0901234567")
                    .append("images", "default-avatar.png")
                    .append("isActive", true);
            collection.insertOne(admin);
        }
    }

    public User findById(String id) {
        if (id == null || id.trim().isEmpty()) return null;
        try {
            Document doc = collection.find(eq("_id", new ObjectId(id))).first();
            return documentToUser(doc);
        } catch (Exception e) {
            return null;
        }
    }

    public User findByUsernameAndPassword(String username, String password) {
        Document doc = collection.find(
                and(eq("username", username), eq("password", password))
        ).first();
        return documentToUser(doc);
    }

    public User findByUsername(String username) {
        Document doc = collection.find(eq("username", username)).first();
        return documentToUser(doc);
    }

    public User findByEmail(String email) {
        Document doc = collection.find(eq("email", email)).first();
        return documentToUser(doc);
    }

    public void insert(User user) {
        Document doc = new Document()
                .append("username", user.getUsername())
                .append("password", user.getPassword())
                .append("fullName", user.getFullName())
                .append("email", user.getEmail())
                .append("phone", user.getPhone() != null ? user.getPhone() : "")
                .append("images", user.getImages() != null ? user.getImages() : "")
                .append("isActive", user.isActive())
                .append("otp", user.getOtp())
                .append("otpExpiry", user.getOtpExpiry());
        collection.insertOne(doc);
    }

    public void update(User user) {
        Document updateDoc = new Document("$set",
                new Document()
                        .append("username", user.getUsername())
                        .append("password", user.getPassword())
                        .append("fullName", user.getFullName())
                        .append("email", user.getEmail())
                        .append("phone", user.getPhone() != null ? user.getPhone() : "")
                        .append("images", user.getImages() != null ? user.getImages() : "")
                        .append("isActive", user.isActive())
                        .append("otp", user.getOtp())
                        .append("otpExpiry", user.getOtpExpiry())
        );
        collection.updateOne(eq("_id", new ObjectId(user.getId())), updateDoc);
    }

    public void updateProfile(String id, String fullName, String phone, String images) {
        Document fieldsToSet = new Document()
                .append("fullName", fullName)
                .append("phone", phone);
        if (images != null && !images.trim().isEmpty()) {
            fieldsToSet.append("images", images);
        }
        Document updateDoc = new Document("$set", fieldsToSet);
        collection.updateOne(eq("_id", new ObjectId(id)), updateDoc);
    }

    private User documentToUser(Document doc) {
        if (doc == null) return null;
        User user = new User();
        user.setId(doc.getObjectId("_id").toHexString());
        user.setUsername(doc.getString("username"));
        user.setPassword(doc.getString("password"));
        user.setFullName(doc.getString("fullName"));
        user.setEmail(doc.getString("email"));
        user.setPhone(doc.containsKey("phone") ? doc.getString("phone") : "");
        user.setImages(doc.containsKey("images") ? doc.getString("images") : "");
        user.setActive(doc.containsKey("isActive") ? doc.getBoolean("isActive") : true);
        user.setOtp(doc.getString("otp"));
        user.setOtpExpiry(doc.getDate("otpExpiry"));
        return user;
    }
}
