<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.roomly.dao.BookingDAO" %>
<%@ page import="com.roomly.dao.RoomDAO" %>
<%@ page import="com.roomly.model.Booking" %>
<%@ page import="com.roomly.model.Room" %>
<%@ page import="com.roomly.model.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%
    // Check if user is logged in
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get booking ID from request
    String bookingIdStr = request.getParameter("id");
    int bookingId = 0;
    
    try {
        bookingId = Integer.parseInt(bookingIdStr);
    } catch (NumberFormatException e) {
        response.sendRedirect("my-bookings.jsp");
        return;
    }
    
    // Get booking details
    BookingDAO bookingDAO = new BookingDAO();
    Booking booking = bookingDAO.getBookingById(bookingId);
    
    if (booking == null || booking.getUserId() != currentUser.getUserId()) {
        response.sendRedirect("my-bookings.jsp");
        return;
    }
    
    // Get room details
    RoomDAO roomDAO = new RoomDAO();
    Room room = roomDAO.getRoomById(booking.getRoomId());
    
    if (room == null) {
        response.sendRedirect("my-bookings.jsp");
        return;
    }
    
    // Format dates
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMMM d, yyyy");
    SimpleDateFormat timeFormat = new SimpleDateFormat("h:mm a");
    
    // Check if booking can be cancelled (not in the past and not already cancelled)
    boolean canCancel = !booking.getBookingStatus().equals("CANCELLED") && 
                        booking.getStartTime().after(new Date());
                        
    // Check if booking can be rescheduled (not in the past, not cancelled, and not already rescheduled)
    boolean canReschedule = !booking.getBookingStatus().equals("CANCELLED") && 
                           !booking.getBookingStatus().equals("RESCHEDULED") &&
                           booking.getStartTime().after(new Date());
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Details - Roomly</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        .booking-details-container {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            color: white;
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .booking-status {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 2rem;
            font-weight: bold;
            margin-bottom: 1rem;
        }
        
        .status-confirmed {
            background-color: #2ecc71;
        }
        
        .status-pending {
            background-color: #f39c12;
        }
        
        .status-cancelled {
            background-color: #e74c3c;
        }
        
        .status-rescheduled {
            background-color: #3498db;
        }
        
        .booking-info {
            background-color: white;
            color: #333;
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .booking-info p {
            font-size: 1.1rem;
            margin-bottom: 1rem;
        }
        
        .booking-actions {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
        }
        
        .btn-cancel {
            background-color: #e74c3c;
            border: none;
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: bold;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .btn-cancel:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(231, 76, 60, 0.3);
            background-color: #c0392b;
        }
        
        .btn-reschedule {
            background-color: #3498db;
            border: none;
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: bold;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .btn-reschedule:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(52, 152, 219, 0.3);
            background-color: #2980b9;
        }
        
        .btn-back {
            background-color: #7f8c8d;
            border: none;
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: bold;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .btn-back:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(127, 140, 141, 0.3);
            background-color: #95a5a6;
        }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <div class="container mt-5">
        <div class="booking-details-container">
            <h2>Booking Details</h2>
            <div class="booking-status status-<%= booking.getBookingStatus().toLowerCase() %>">
                <%= booking.getBookingStatus() %>
            </div>
            
            <div class="booking-info">
                <p><strong>Room:</strong> <%= room.getRoomName() %></p>
                <p><strong>Check-in:</strong> <%= dateFormat.format(booking.getStartTime()) %> at <%= timeFormat.format(booking.getStartTime()) %></p>
                <p><strong>Check-out:</strong> <%= dateFormat.format(booking.getEndTime()) %> at <%= timeFormat.format(booking.getEndTime()) %></p>
                <p><strong>Total Price:</strong> $<%= booking.getTotalPrice() %></p>
                
                <div class="booking-actions">
                    <% if (canCancel) { %>
                        <a href="cancel-booking.jsp?id=<%= booking.getBookingId() %>" class="btn btn-cancel" onclick="return confirm('Are you sure you want to cancel this booking?')">
                            <i class="fas fa-times-circle me-2"></i>Cancel Booking
                        </a>
                    <% } %>
                    
                    <% if (canReschedule) { %>
                        <a href="reschedule-booking.jsp?id=<%= booking.getBookingId() %>" class="btn btn-reschedule">
                            <i class="fas fa-calendar-alt me-2"></i>Reschedule
                        </a>
                    <% } %>
                    
                    <a href="my-bookings.jsp" class="btn btn-back">
                        <i class="fas fa-arrow-left me-2"></i>Back to My Bookings
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="includes/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
