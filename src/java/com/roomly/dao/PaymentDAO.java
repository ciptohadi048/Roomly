package com.roomly.dao;

import com.roomly.model.Payment;
import com.roomly.util.DatabaseUtil;

import java.sql.*;

public class PaymentDAO {
    
    // Create a new payment
    public int createPayment(Payment payment) {
        String sql = "INSERT INTO payments (booking_id, amount, payment_status, payment_method, transaction_id) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, payment.getBookingId());
            stmt.setDouble(2, payment.getAmount());
            stmt.setString(3, payment.getPaymentStatus());
            stmt.setString(4, payment.getPaymentMethod());
            stmt.setString(5, payment.getTransactionId());
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return -1; // Return -1 if payment creation failed
    }
    
    // Get payment by ID
    public Payment getPaymentById(int paymentId) {
        String sql = "SELECT * FROM payments WHERE payment_id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, paymentId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Payment payment = new Payment();
                    payment.setPaymentId(rs.getInt("payment_id"));
                    payment.setBookingId(rs.getInt("booking_id"));
                    payment.setAmount(rs.getDouble("amount"));
                    payment.setPaymentDate(rs.getTimestamp("payment_date"));
                    payment.setPaymentStatus(rs.getString("payment_status"));
                    payment.setPaymentMethod(rs.getString("payment_method"));
                    payment.setTransactionId(rs.getString("transaction_id"));
                    return payment;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Get payment by booking ID
    public Payment getPaymentByBookingId(int bookingId) {
        String sql = "SELECT * FROM payments WHERE booking_id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, bookingId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Payment payment = new Payment();
                    payment.setPaymentId(rs.getInt("payment_id"));
                    payment.setBookingId(rs.getInt("booking_id"));
                    payment.setAmount(rs.getDouble("amount"));
                    payment.setPaymentDate(rs.getTimestamp("payment_date"));
                    payment.setPaymentStatus(rs.getString("payment_status"));
                    payment.setPaymentMethod(rs.getString("payment_method"));
                    payment.setTransactionId(rs.getString("transaction_id"));
                    return payment;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Update payment status
    public boolean updatePaymentStatus(int paymentId, String status) {
        String sql = "UPDATE payments SET payment_status = ? WHERE payment_id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, paymentId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Process payment and update booking status in a transaction
    public boolean processPayment(Payment payment, int bookingId) {
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            conn.setAutoCommit(false);
            
            // Insert payment
            String paymentSql = "INSERT INTO payments (booking_id, amount, payment_status, payment_method, transaction_id) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement paymentStmt = conn.prepareStatement(paymentSql)) {
                paymentStmt.setInt(1, payment.getBookingId());
                paymentStmt.setDouble(2, payment.getAmount());
                paymentStmt.setString(3, "COMPLETED");
                paymentStmt.setString(4, payment.getPaymentMethod());
                paymentStmt.setString(5, payment.getTransactionId());
                paymentStmt.executeUpdate();
            }
            
            // Update booking status
            String bookingSql = "UPDATE bookings SET booking_status = 'CONFIRMED' WHERE booking_id = ?";
            try (PreparedStatement bookingStmt = conn.prepareStatement(bookingSql)) {
                bookingStmt.setInt(1, bookingId);
                bookingStmt.executeUpdate();
            }
            
            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
