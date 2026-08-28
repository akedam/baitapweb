package com.app.model;

import java.util.Date;

public class User {
    private String id;
    private String username;
    private String password;
    private String fullName;
    private String email;
    
    // OTP & Activation Fields
    private boolean isActive;
    private String otp;
    private Date otpExpiry;

    public User() {}

    public User(String username, String password, String fullName, String email) {
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.isActive = false; // Default inactive until OTP verified
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public String getOtp() { return otp; }
    public void setOtp(String otp) { this.otp = otp; }

    public Date getOtpExpiry() { return otpExpiry; }
    public void setOtpExpiry(Date otpExpiry) { this.otpExpiry = otpExpiry; }
}
