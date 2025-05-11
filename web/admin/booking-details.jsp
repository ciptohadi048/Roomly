<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.roomly.util.DatabaseUtil" %>
<%@ page import="com.roomly.dao.BookingDAO" %>
<%@ page import="com.roomly.dao.RoomDAO" %>
<%@ page import="com.roomly.dao.UserDAO" %>
<%@ page import="com.roomly.model.Booking" %>
<%@ page import="com.roomly.model.Room" %>
<%@ page import="com.roomly.model.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%
    // Check if admin is logged in
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null || !currentUser.isAdmin()) {
        response.sendRedirect("../login.jsp");
        return;
    }

    String bookingIdStr = request.getParameter("id");
    
    if (bookingIdStr == null || bookingIdStr.isEmpty()) {
        response.sendRedirect("bookings.jsp");
        return;
    }
    
    int bookingId = Integer.parseInt(bookingIdStr);
    
    // Get booking details
    BookingDAO bookingDAO = new BookingDAO();
    Booking booking = bookingDAO.getBookingById(bookingId);
    
    if (booking == null) {
        response.sendRedirect("bookings.jsp");
        return;
    }
    
    // Get room details
    RoomDAO roomDAO = new RoomDAO();
    Room room = roomDAO.getRoomById(booking.getRoomId());
    
    // Get user details
    UserDAO userDAO = new UserDAO();
    User user = userDAO.getUserById(booking.getUserId());
    
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
    SimpleDateFormat fullDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Details - Roomly Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="../assets/css/admin-booking-details.css">
</head>
<body>
    <jsp:include page="../includes/header.jsp" />
    
    <div class="container mt-5">
        <div class="admin-booking-container">
            <div class="admin-booking-header">
                <h1>Booking Details</h1>
                <a href="bookings.jsp" class="btn-back">
                    <i class="fas fa-arrow-left"></i> Back to Bookings
                </a>
            </div>
            
            <div class="booking-status-banner <%= booking.getBookingStatus().toLowerCase() %>">
                <div class="status-icon">
                    <% if (booking.getBookingStatus().equals("CONFIRMED")) { %>
                        <i class="fas fa-check-circle"></i>
                    <% } else if (booking.getBookingStatus().equals("PENDING")) { %>
                        <i class="fas fa-clock"></i>
                    <% } else if (booking.getBookingStatus().equals("CANCELLED")) { %>
                        <i class="fas fa-times-circle"></i>
                    <% } else if (booking.getBookingStatus().equals("COMPLETED")) { %>
                        <i class="fas fa-flag-checkered"></i>
                    <% } else if (booking.getBookingStatus().equals("RESCHEDULED")) { %>
                        <i class="fas fa-calendar-alt"></i>
                    <% } %>
                </div>
                <div class="status-text">
                    <h3>Booking #<%= booking.getBookingId() %></h3>
                    <p><%= booking.getBookingStatus() %></p>
                </div>
            </div>
            
            <div class="booking-details-grid">
                <div class="booking-info-card">
                    <div class="card-header">
                        <i class="fas fa-info-circle"></i> Booking Information
                    </div>
                    <div class="card-body">
                        <div class="info-item">
                            <span class="info-label">Check-in:</span>
                            <span class="info-value"><%= dateFormat.format(booking.getStartTime()) %> at <%= timeFormat.format(booking.getStartTime()) %></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Check-out:</span>
                            <span class="info-value"><%= dateFormat.format(booking.getEndTime()) %> at <%= timeFormat.format(booking.getEndTime()) %></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Total Price:</span>
                            <span class="info-value price">$<%= booking.getTotalPrice() %></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Created:</span>
                            <span class="info-value"><%= fullDateFormat.format(booking.getCreatedAt()) %></span>
                        </div>
                        <% if (booking.getUpdatedAt() != null) { %>
                            <div class="info-item">
                                <span class="info-label">Last Updated:</span>
                                <span class="info-value"><%= fullDateFormat.format(booking.getUpdatedAt()) %></span>
                            </div>
                        <% } %>
                    </div>
                </div>
                
                <div class="booking-info-card">
                    <div class="card-header">
                        <i class="fas fa-door-open"></i> Room Information
                    </div>
                    <div class="card-body">
                        <div class="info-item">
                            <span class="info-label">Room:</span>
                            <span class="info-value"><%= room.getRoomName() %></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Type:</span>
                            <span class="info-value"><%= room.getRoomType() %></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Capacity:</span>
                            <span class="info-value"><%= room.getCapacity() %> persons</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Price:</span>
                            <span class="info-value price">$<%= room.getPricePerHour() %> per hour</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Room ID:</span>
                            <span class="info-value">#<%= room.getRoomId() %></span>
                        </div>
                        <div class="info-item">
                            <a href="rooms.jsp?id=<%= room.getRoomId() %>" class="btn-view-room">
                                <i class="fas fa-external-link-alt"></i> View Room
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="booking-info-card user-info">
                <div class="card-header">
                    <i class="fas fa-user"></i> Guest Information
                </div>
                <div class="card-body">
                    <div class="user-info-grid">
                        <div class="info-item">
                            <span class="info-label">Name:</span>
                            <span class="info-value"><%= user.getFullName() %></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Email:</span>
                            <span class="info-value"><%= user.getEmail() %></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Phone:</span>
                            <span class="info-value"><%= user.getPhone() != null ? user.getPhone() : "Not provided" %></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Username:</span>
                            <span class="info-value"><%= user.getUsername() %></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">User ID:</span>
                            <span class="info-value">#<%= user.getUserId() %></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Member Since:</span>
                            <span class="info-value"><%= user.getCreatedAt() != null ? dateFormat.format(user.getCreatedAt()) : "Unknown" %></span>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="admin-actions">
                <% if (!booking.getBookingStatus().equals("CANCELLED") && !booking.getBookingStatus().equals("COMPLETED")) { %>
                    <form action="booking-process.jsp" method="post" class="status-update-form">
                        <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                        <input type="hidden" name="action" value="updateStatus">
                        <div class="form-group">
                            <label for="status">Update Status:</label>
                            <select name="status" id="status" class="form-control">
                                <option value="CONFIRMED" <%= booking.getBookingStatus().equals("CONFIRMED") ? "selected" : "" %>>Confirmed</option>
                                <option value="CANCELLED" <%= booking.getBookingStatus().equals("CANCELLED") ? "selected" : "" %>>Cancelled</option>
                                <option value="COMPLETED" <%= booking.getBookingStatus().equals("COMPLETED") ? "selected" : "" %>>Completed</option>
                                <option value="RESCHEDULED" <%= booking.getBookingStatus().equals("RESCHEDULED") ? "selected" : "" %>>Rescheduled</option>
                            </select>
                        </div>
                        <button type="submit" class="btn-update-status">Update Status</button>
                    </form>
                <% } %>
            </div>
        </div>
    </div>
    
    <jsp:include page="../includes/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
