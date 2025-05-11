<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.roomly.dao.BookingDAO" %>
<%@ page import="com.roomly.dao.RoomDAO" %>
<%@ page import="com.roomly.model.Booking" %>
<%@ page import="com.roomly.model.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %>

<%
    // Check if user is logged in
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get form data
    String bookingIdStr = request.getParameter("bookingId");
    String roomIdStr = request.getParameter("roomId");
    String newDateStr = request.getParameter("newBookingDate");
    String newStartTimeStr = request.getParameter("newStartTime");
    String newEndTimeStr = request.getParameter("newEndTime");
    String reason = request.getParameter("reason");
    
    // Validate input
    if (bookingIdStr == null || roomIdStr == null || newDateStr == null || 
        newStartTimeStr == null || newEndTimeStr == null || reason == null) {
        response.sendRedirect("my-bookings.jsp?error=invalid_input");
        return;
    }
    
    try {
        int bookingId = Integer.parseInt(bookingIdStr);
        int roomId = Integer.parseInt(roomIdStr);
        
        // Get booking details
        BookingDAO bookingDAO = new BookingDAO();
        Booking booking = bookingDAO.getBookingById(bookingId);
        
        // Check if booking exists and belongs to the current user
        if (booking == null || booking.getUserId() != currentUser.getUserId()) {
            response.sendRedirect("my-bookings.jsp?error=unauthorized");
            return;
        }
        
        // Parse new date and times
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        Date newStartDateTime = dateTimeFormat.parse(newDateStr + " " + newStartTimeStr);
        Date newEndDateTime = dateTimeFormat.parse(newDateStr + " " + newEndTimeStr);
        
        // Convert to Timestamp for database
        Timestamp newStartTimestamp = new Timestamp(newStartDateTime.getTime());
        Timestamp newEndTimestamp = new Timestamp(newEndDateTime.getTime());
        
        // Check if new time is in the future
        Date now = new Date();
        if (newStartDateTime.before(now)) {
            response.sendRedirect("reschedule-booking.jsp?id=" + bookingId + "&error=past_date");
            return;
        }
        
        // Check if end time is after start time
        if (newEndDateTime.before(newStartDateTime) || newEndDateTime.equals(newStartDateTime)) {
            response.sendRedirect("reschedule-booking.jsp?id=" + bookingId + "&error=invalid_time");
            return;
        }
        
        // Check if room is available for the new time
        RoomDAO roomDAO = new RoomDAO();
        boolean isAvailable = roomDAO.isRoomAvailableForReschedule(roomId, newStartTimestamp, newEndTimestamp, bookingId);
        
        if (!isAvailable) {
            response.sendRedirect("reschedule-booking.jsp?id=" + bookingId + "&error=unavailable");
            return;
        }
        
        // Reschedule the booking
        boolean success = bookingDAO.rescheduleBooking(bookingId, newStartTimestamp, newEndTimestamp);
        
        if (success) {
            response.sendRedirect("my-bookings.jsp?success=reschedule");
        } else {
            response.sendRedirect("reschedule-booking.jsp?id=" + bookingId + "&error=system");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("my-bookings.jsp?error=system");
    }
%>
