<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.roomly.dao.BookingDAO" %>
<%@ page import="com.roomly.model.Booking" %>
<%@ page import="com.roomly.model.User" %>

<%
    // Check if user is logged in
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get booking ID from request
    String bookingIdStr = request.getParameter("id");
    if (bookingIdStr == null) {
        response.sendRedirect("my-bookings.jsp");
        return;
    }
    
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
    
    // Check if booking exists and belongs to the current user
    if (booking == null || booking.getUserId() != currentUser.getUserId()) {
        response.sendRedirect("my-bookings.jsp");
        return;
    }
    
    // Cancel booking
    boolean success = bookingDAO.updateBookingStatus(bookingId, "CANCELLED");
    
    if (success) {
        response.sendRedirect("my-bookings.jsp?success=cancel");
    } else {
        response.sendRedirect("my-bookings.jsp?error=1");
    }
%>
