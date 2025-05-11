package com.roomly.dao;

import com.roomly.model.Room;
import com.roomly.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {
    private Connection connection;

    

   // Get all rooms
   public List<Room> getAllRooms() {
       List<Room> rooms = new ArrayList<>();
       String sql = "SELECT * FROM rooms WHERE is_active = true";
       
       try (Connection conn = DatabaseUtil.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery()) {
           
           while (rs.next()) {
               Room room = new Room();
               room.setRoomId(rs.getInt("room_id"));
               room.setRoomName(rs.getString("room_name"));
               room.setRoomType(rs.getString("room_type"));
               room.setCapacity(rs.getInt("capacity"));
               room.setPricePerHour(rs.getDouble("price_per_hour"));
               room.setDescription(rs.getString("description"));
               room.setImageUrl(rs.getString("image_url"));
               room.setActive(rs.getBoolean("is_active"));
               rooms.add(room);
           }
       } catch (SQLException e) {
           e.printStackTrace();
       }
       
       return rooms;
   }
   
   // Get room by ID
   public Room getRoomById(int roomId) {
       Room room = null;
       String sql = "SELECT * FROM rooms WHERE room_id = ?";
       
       try (Connection conn = DatabaseUtil.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)) {
           
           stmt.setInt(1, roomId);
           
           try (ResultSet rs = stmt.executeQuery()) {
               if (rs.next()) {
                   room = new Room();
                   room.setRoomId(rs.getInt("room_id"));
                   room.setRoomName(rs.getString("room_name"));
                   room.setRoomType(rs.getString("room_type"));
                   room.setCapacity(rs.getInt("capacity"));
                   room.setPricePerHour(rs.getDouble("price_per_hour"));
                   room.setDescription(rs.getString("description"));
                   room.setImageUrl(rs.getString("image_url"));
                   room.setActive(rs.getBoolean("is_active"));
               }
           }
       } catch (SQLException e) {
           e.printStackTrace();
       }
       
       return room;
   }
   
   // Add a new room
   public boolean addRoom(Room room) {
       String sql = "INSERT INTO rooms (room_name, room_type, capacity, price_per_hour, description, image_url) VALUES (?, ?, ?, ?, ?, ?)";
       
       try (Connection conn = DatabaseUtil.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)) {
           
           stmt.setString(1, room.getRoomName());
           stmt.setString(2, room.getRoomType());
           stmt.setInt(3, room.getCapacity());
           stmt.setDouble(4, room.getPricePerHour());
           stmt.setString(5, room.getDescription());
           stmt.setString(6, room.getImageUrl());
           
           int rowsAffected = stmt.executeUpdate();
           return rowsAffected > 0;
       } catch (SQLException e) {
           e.printStackTrace();
           return false;
       }
   }
   
   // Update an existing room
   public boolean updateRoom(Room room) {
       String sql = "UPDATE rooms SET room_name = ?, room_type = ?, capacity = ?, price_per_hour = ?, description = ?, image_url = ?, is_active = ? WHERE room_id = ?";
       
       try (Connection conn = DatabaseUtil.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)) {
           
           stmt.setString(1, room.getRoomName());
           stmt.setString(2, room.getRoomType());
           stmt.setInt(3, room.getCapacity());
           stmt.setDouble(4, room.getPricePerHour());
           stmt.setString(5, room.getDescription());
           stmt.setString(6, room.getImageUrl());
           stmt.setBoolean(7, room.isActive());
           stmt.setInt(8, room.getRoomId());
           
           int rowsAffected = stmt.executeUpdate();
           return rowsAffected > 0;
       } catch (SQLException e) {
           e.printStackTrace();
           return false;
       }
   }
   
   // Delete a room (soft delete by setting is_active to false)
   public boolean deleteRoom(int roomId) {
       String sql = "UPDATE rooms SET is_active = false WHERE room_id = ?";
       
       try (Connection conn = DatabaseUtil.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)) {
           
           stmt.setInt(1, roomId);
           
           int rowsAffected = stmt.executeUpdate();
           return rowsAffected > 0;
       } catch (SQLException e) {
           e.printStackTrace();
           return false;
       }
   }
   
   // Search rooms by criteria
   public List<Room> searchRooms(String keyword, String roomType, Integer minCapacity) {
       List<Room> rooms = new ArrayList<>();
       StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM rooms WHERE is_active = true");
       
       if (keyword != null && !keyword.trim().isEmpty()) {
           sqlBuilder.append(" AND (room_name LIKE ? OR description LIKE ?)");
       }
       
       if (roomType != null && !roomType.trim().isEmpty()) {
           sqlBuilder.append(" AND room_type = ?");
       }
       
       if (minCapacity != null && minCapacity > 0) {
           sqlBuilder.append(" AND capacity >= ?");
       }
       
       try (Connection conn = DatabaseUtil.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sqlBuilder.toString())) {
           
           int paramIndex = 1;
           
           if (keyword != null && !keyword.trim().isEmpty()) {
               String searchPattern = "%" + keyword + "%";
               stmt.setString(paramIndex++, searchPattern);
               stmt.setString(paramIndex++, searchPattern);
           }
           
           if (roomType != null && !roomType.trim().isEmpty()) {
               stmt.setString(paramIndex++, roomType);
           }
           
           if (minCapacity != null && minCapacity > 0) {
               stmt.setInt(paramIndex, minCapacity);
           }
           
           try (ResultSet rs = stmt.executeQuery()) {
               while (rs.next()) {
                   Room room = new Room();
                   room.setRoomId(rs.getInt("room_id"));
                   room.setRoomName(rs.getString("room_name"));
                   room.setRoomType(rs.getString("room_type"));
                   room.setCapacity(rs.getInt("capacity"));
                   room.setPricePerHour(rs.getDouble("price_per_hour"));
                   room.setDescription(rs.getString("description"));
                   room.setImageUrl(rs.getString("image_url"));
                   room.setActive(rs.getBoolean("is_active"));
                   rooms.add(room);
               }
           }
       } catch (SQLException e) {
           e.printStackTrace();
       }
       
       return rooms;
   }
   
   // Check if room is available for a specific time slot
   public boolean isRoomAvailable(int roomId, Timestamp startTime, Timestamp endTime) {
       String sql = "SELECT COUNT(*) FROM bookings WHERE room_id = ? AND booking_status = 'CONFIRMED' " +
                    "AND ((start_time <= ? AND end_time > ?) OR (start_time < ? AND end_time >= ?) OR (start_time >= ? AND end_time <= ?))";
       
       try (Connection conn = DatabaseUtil.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)) {
           
           stmt.setInt(1, roomId);
           stmt.setTimestamp(2, endTime);
           stmt.setTimestamp(3, startTime);
           stmt.setTimestamp(4, endTime);
           stmt.setTimestamp(5, startTime);
           stmt.setTimestamp(6, startTime);
           stmt.setTimestamp(7, endTime);
           
           try (ResultSet rs = stmt.executeQuery()) {
               if (rs.next()) {
                   int count = rs.getInt(1);
                   return count == 0; // Room is available if no overlapping bookings
               }
           }
       } catch (SQLException e) {
           e.printStackTrace();
       }
       
       return false; // Default to unavailable if there's an error
   }
   
   // Check if room is available for rescheduling (excluding the current booking)
   public boolean isRoomAvailableForReschedule(int roomId, Timestamp startTime, Timestamp endTime, int currentBookingId) {
        String sql = "SELECT COUNT(*) FROM bookings " +
                     "WHERE room_id = ? AND booking_id != ? AND booking_status != 'CANCELLED' " +
                     "AND ((start_time <= ? AND end_time > ?) OR (start_time < ? AND end_time >= ?) OR (start_time >= ? AND end_time <= ?))";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, roomId);
            stmt.setInt(2, currentBookingId);
            stmt.setTimestamp(3, endTime);
            stmt.setTimestamp(4, startTime);
            stmt.setTimestamp(5, endTime);
            stmt.setTimestamp(6, startTime);
            stmt.setTimestamp(7, startTime);
            stmt.setTimestamp(8, endTime);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    return count == 0; // Room is available if no overlapping bookings
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false; // Default to not available if there's an error
    }
}
