package com.roomly.dao;

import com.roomly.model.Booking;
import com.roomly.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
   
   // Create a new booking
   public int createBooking(Booking booking) {
       String sql = "INSERT INTO bookings (user_id, room_id, start_time, end_time, booking_status, total_price) VALUES (?, ?, ?, ?, ?, ?)";
       Connection conn = null;
       PreparedStatement stmt = null;
       ResultSet rs = null;
       
       try {
           conn = DatabaseUtil.getConnection();
           stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
           
           stmt.setInt(1, booking.getUserId());
           stmt.setInt(2, booking.getRoomId());
           stmt.setTimestamp(3, booking.getStartTime());
           stmt.setTimestamp(4, booking.getEndTime());
           stmt.setString(5, booking.getBookingStatus());
           stmt.setDouble(6, booking.getTotalPrice());
           
           int rowsAffected = stmt.executeUpdate();
           
           if (rowsAffected > 0) {
               rs = stmt.getGeneratedKeys();
               if (rs.next()) {
                   return rs.getInt(1);
               }
           }
       } catch (SQLException e) {
           e.printStackTrace();
       } finally {
           try {
               if (rs != null) rs.close();
               if (stmt != null) stmt.close();
               if (conn != null) conn.close();
           } catch (SQLException e) {
               e.printStackTrace();
           }
       }
       
       return -1; // Return -1 if booking creation failed
   }
   
   // Get booking by ID
   public Booking getBookingById(int bookingId) {
       String sql = "SELECT b.*, r.room_name FROM bookings b " +
                    "JOIN rooms r ON b.room_id = r.room_id " +
                    "WHERE b.booking_id = ?";
       
       Connection conn = null;
       PreparedStatement stmt = null;
       ResultSet rs = null;
       
       try {
           conn = DatabaseUtil.getConnection();
           stmt = conn.prepareStatement(sql);
           
           stmt.setInt(1, bookingId);
           
           rs = stmt.executeQuery();
           if (rs.next()) {
               return extractBookingFromResultSet(rs);
           }
       } catch (SQLException e) {
           e.printStackTrace();
       } finally {
           try {
               if (rs != null) rs.close();
               if (stmt != null) stmt.close();
               if (conn != null) conn.close();
           } catch (SQLException e) {
               e.printStackTrace();
           }
       }
       
       return null;
   }
   
   // Get all bookings for a user
   public List<Booking> getBookingsByUserId(int userId) {
       List<Booking> bookings = new ArrayList<>();
       String sql = "SELECT b.*, r.room_name FROM bookings b " +
                    "JOIN rooms r ON b.room_id = r.room_id " +
                    "WHERE b.user_id = ? ORDER BY b.start_time DESC";
       
       Connection conn = null;
       PreparedStatement stmt = null;
       ResultSet rs = null;
       
       try {
           conn = DatabaseUtil.getConnection();
           stmt = conn.prepareStatement(sql);
           
           stmt.setInt(1, userId);
           
           rs = stmt.executeQuery();
           while (rs.next()) {
               Booking booking = extractBookingFromResultSet(rs);
               bookings.add(booking);
           }
       } catch (SQLException e) {
           e.printStackTrace();
       } finally {
           try {
               if (rs != null) rs.close();
               if (stmt != null) stmt.close();
               if (conn != null) conn.close();
           } catch (SQLException e) {
               e.printStackTrace();
           }
       }
       
       return bookings;
   }
   
   // Get all bookings for a room
   public List<Booking> getBookingsByRoomId(int roomId) {
       List<Booking> bookings = new ArrayList<>();
       String sql = "SELECT b.*, u.username FROM bookings b " +
                    "JOIN users u ON b.user_id = u.user_id " +
                    "WHERE b.room_id = ? ORDER BY b.start_time";
       
       Connection conn = null;
       PreparedStatement stmt = null;
       ResultSet rs = null;
       
       try {
           conn = DatabaseUtil.getConnection();
           stmt = conn.prepareStatement(sql);
           
           stmt.setInt(1, roomId);
           
           rs = stmt.executeQuery();
           while (rs.next()) {
               Booking booking = extractBookingFromResultSet(rs);
               bookings.add(booking);
           }
       } catch (SQLException e) {
           e.printStackTrace();
       } finally {
           try {
               if (rs != null) rs.close();
               if (stmt != null) stmt.close();
               if (conn != null) conn.close();
           } catch (SQLException e) {
               e.printStackTrace();
           }
       }
       
       return bookings;
   }
   
   // Update booking status
   public boolean updateBookingStatus(int bookingId, String status) {
       String sql = "UPDATE bookings SET booking_status = ? WHERE booking_id = ?";
       
       Connection conn = null;
       PreparedStatement stmt = null;
       
       try {
           conn = DatabaseUtil.getConnection();
           stmt = conn.prepareStatement(sql);
           
           stmt.setString(1, status);
           stmt.setInt(2, bookingId);
           
           int rowsAffected = stmt.executeUpdate();
           return rowsAffected > 0;
       } catch (SQLException e) {
           e.printStackTrace();
           return false;
       } finally {
           try {
               if (stmt != null) stmt.close();
               if (conn != null) conn.close();
           } catch (SQLException e) {
               e.printStackTrace();
           }
       }
   }
   
   // Get all bookings (for admin)
   public List<Booking> getAllBookings() {
       List<Booking> bookings = new ArrayList<>();
       String sql = "SELECT b.*, r.room_name, u.username FROM bookings b " +
                    "JOIN rooms r ON b.room_id = r.room_id " +
                    "JOIN users u ON b.user_id = u.user_id " +
                    "ORDER BY b.start_time DESC";
       
       Connection conn = null;
       PreparedStatement stmt = null;
       ResultSet rs = null;
       
       try {
           conn = DatabaseUtil.getConnection();
           stmt = conn.prepareStatement(sql);
           
           rs = stmt.executeQuery();
           while (rs.next()) {
               Booking booking = extractBookingFromResultSet(rs);
               bookings.add(booking);
           }
       } catch (SQLException e) {
           e.printStackTrace();
       } finally {
           try {
               if (rs != null) rs.close();
               if (stmt != null) stmt.close();
               if (conn != null) conn.close();
           } catch (SQLException e) {
               e.printStackTrace();
           }
       }
       
       return bookings;
   }
   
   // Reschedule a booking (update start and end times)
   public boolean rescheduleBooking(int bookingId, Timestamp newStartTime, Timestamp newEndTime) {
       String sql = "UPDATE bookings SET start_time = ?, end_time = ?, booking_status = 'RESCHEDULED', updated_at = CURRENT_TIMESTAMP WHERE booking_id = ?";
       
       Connection conn = null;
       PreparedStatement stmt = null;
       
       try {
           conn = DatabaseUtil.getConnection();
           stmt = conn.prepareStatement(sql);
           
           stmt.setTimestamp(1, newStartTime);
           stmt.setTimestamp(2, newEndTime);
           stmt.setInt(3, bookingId);
           
           int rowsAffected = stmt.executeUpdate();
           return rowsAffected > 0;
       } catch (SQLException e) {
           e.printStackTrace();
           return false;
       } finally {
           try {
               if (stmt != null) stmt.close();
               if (conn != null) conn.close();
           } catch (SQLException e) {
               e.printStackTrace();
           }
       }
   }
   
   // Helper method to extract booking from ResultSet
   private Booking extractBookingFromResultSet(ResultSet rs) throws SQLException {
       Booking booking = new Booking();
       booking.setBookingId(rs.getInt("booking_id"));
       booking.setUserId(rs.getInt("user_id"));
       booking.setRoomId(rs.getInt("room_id"));
       booking.setStartTime(rs.getTimestamp("start_time"));
       booking.setEndTime(rs.getTimestamp("end_time"));
       booking.setBookingStatus(rs.getString("booking_status"));
       
       try {
           booking.setTotalPrice(rs.getDouble("total_price"));
       } catch (SQLException e) {
           // If total_price column doesn't exist or is null
           booking.setTotalPrice(0.0);
       }
       
       try {
           booking.setCreatedAt(rs.getTimestamp("created_at"));
       } catch (SQLException e) {
           // Ignore if column doesn't exist
       }
       
       try {
           booking.setUpdatedAt(rs.getTimestamp("updated_at"));
       } catch (SQLException e) {
           // Ignore if column doesn't exist
       }
       
       try {
           booking.setRoomName(rs.getString("room_name"));
       } catch (SQLException e) {
           // Ignore if column doesn't exist
       }
       
       try {
           booking.setUserName(rs.getString("username"));
       } catch (SQLException e) {
           // Ignore if column doesn't exist
       }
       
       return booking;
   }
}
