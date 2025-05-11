<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.roomly.dao.RoomDAO" %>
<%@ page import="com.roomly.dao.BookingDAO" %>
<%@ page import="com.roomly.model.Room" %>
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
    
    try {
        // Get form data
        String roomIdStr = request.getParameter("roomId");
        String bookingDate = request.getParameter("bookingDate");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String pricePerHourStr = request.getParameter("pricePerHour");
        
        // Validate input
        if (roomIdStr == null || bookingDate == null || startTime == null || endTime == null || pricePerHourStr == null) {
            response.sendRedirect("rooms.jsp");
            return;
        }
        
        // Parse roomId and pricePerHour
        int roomId = Integer.parseInt(roomIdStr);
        double pricePerHour = Double.parseDouble(pricePerHourStr);
        
        // Parse date and times
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        Date startDateTime = dateFormat.parse(bookingDate + " " + startTime);
        Date endDateTime = dateFormat.parse(bookingDate + " " + endTime);
        
        // Convert to Timestamp for database
        Timestamp startTimestamp = new Timestamp(startDateTime.getTime());
        Timestamp endTimestamp = new Timestamp(endDateTime.getTime());
        
        // Calculate duration and cost
        long durationMillis = endDateTime.getTime() - startDateTime.getTime();
        double durationHours = durationMillis / (1000.0 * 60 * 60);
        double totalCost = durationHours * pricePerHour;
        
        // Check if room is available
        RoomDAO roomDAO = new RoomDAO();
        boolean isAvailable = roomDAO.isRoomAvailable(roomId, startTimestamp, endTimestamp);
        
        if (!isAvailable) {
            response.sendRedirect("room-details.jsp?id=" + roomId + "&error=unavailable");
            return;
        }
        
        // Create booking (initially with PENDING status)
        Booking booking = new Booking();
        booking.setUserId(currentUser.getUserId());
        booking.setRoomId(roomId);
        booking.setStartTime(startTimestamp);
        booking.setEndTime(endTimestamp);
        booking.setBookingStatus("PENDING");
        booking.setTotalPrice(totalCost);
        
        BookingDAO bookingDAO = new BookingDAO();
        int bookingId = bookingDAO.createBooking(booking);
        
        if (bookingId > 0) {
            // Store booking info in session for payment
            session.setAttribute("bookingId", bookingId);
            session.setAttribute("totalAmount", totalCost);
            
            // Redirect to payment page
            response.sendRedirect("payment.jsp");
        } else {
            response.sendRedirect("room-details.jsp?id=" + roomId + "&error=booking");
        }
    } catch (Exception e) {
        e.printStackTrace();
        // Add the error message to the session for debugging
        session.setAttribute("errorMessage", e.getMessage());
        response.sendRedirect("error.jsp");
    }
%>
