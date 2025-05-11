package com.roomly.model;

public class Room {
    private int roomId;
    private String roomName;
    private String roomType;
    private int capacity;
    private double pricePerHour;
    private String description;
    private String imageUrl;
    private boolean isActive;

    // Constructors
    public Room() {}

    public Room(int roomId, String roomName, String roomType, int capacity, double pricePerHour, String description, String imageUrl, boolean isActive) {
        this.roomId = roomId;
        this.roomName = roomName;
        this.roomType = roomType;
        this.capacity = capacity;
        this.pricePerHour = pricePerHour;
        this.description = description;
        this.imageUrl = imageUrl;
        this.isActive = isActive;
    }

    // Getters and Setters
    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public double getPricePerHour() {
        return pricePerHour;
    }

    public void setPricePerHour(double pricePerHour) {
        this.pricePerHour = pricePerHour;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }
}
