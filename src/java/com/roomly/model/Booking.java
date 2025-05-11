package com.roomly.model;

import java.sql.Timestamp;
import java.util.Date;

public class Booking {
    private int bookingId;
    private int userId;
    private int roomId;
    private Timestamp startTime;
    private Timestamp endTime;
    private String bookingStatus;
    private double totalPrice;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Additional fields for joins
    private String roomName;
    private String userName;
    
    // Default constructor
    public Booking() {
    }
    
    // Getters and Setters
    public int getBookingId() {
        return bookingId;
    }
    
    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public int getRoomId() {
        return roomId;
    }
    
    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }
    
    public Timestamp getStartTime() {
        return startTime;
    }
    
    // Overloaded method to accept java.sql.Timestamp
    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }
    
    // Overloaded method to accept java.util.Date
    public void setStartTime(Date startTime) {
        if (startTime != null) {
            this.startTime = new Timestamp(startTime.getTime());
        } else {
            this.startTime = null;
        }
    }
    
    public Timestamp getEndTime() {
        return endTime;
    }
    
    // Overloaded method to accept java.sql.Timestamp
    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }
    
    // Overloaded method to accept java.util.Date
    public void setEndTime(Date endTime) {
        if (endTime != null) {
            this.endTime = new Timestamp(endTime.getTime());
        } else {
            this.endTime = null;
        }
    }
    
    public String getBookingStatus() {
        return bookingStatus;
    }
    
    public void setBookingStatus(String bookingStatus) {
        this.bookingStatus = bookingStatus;
    }
    
    public double getTotalPrice() {
        return totalPrice;
    }
    
    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public String getRoomName() {
        return roomName;
    }
    
    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }
    
    public String getUserName() {
        return userName;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    // Helper method to calculate duration in hours
    public double getDurationHours() {
        if (startTime == null || endTime == null) {
            return 0.0;
        }
        
        long durationMillis = endTime.getTime() - startTime.getTime();
        return durationMillis / (1000.0 * 60 * 60);
    }
}
