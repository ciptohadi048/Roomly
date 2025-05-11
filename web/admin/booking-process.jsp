<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.roomly.dao.BookingDAO" %>
<%@ page import="com.roomly.model.User" %>

<%
    // Check if user is logged in and is admin
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null || !currentUser.isAdmin()) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    // Get action and booking ID
    String action = request.getParameter("action");
    String bookingIdStr = request.getParameter("id");
    
    if (action == null || bookingIdStr == null) {
        response.sendRedirect("bookings.jsp?error=1");
        return;
    }
    
    try {
        int bookingId = Integer.parseInt(bookingIdStr);
        BookingDAO bookingDAO = new BookingDAO();
        
        if (action.equals("cancel")) {
            // Cancel booking
            boolean success = bookingDAO.updateBookingStatus(bookingId, "CANCELLED");
            
            if (success) {
                response.sendRedirect("bookings.jsp?success=cancel");
            } else {
                response.sendRedirect("bookings.jsp?error=1");
            }
        } else if (action.equals("confirm")) {
            // Confirm booking
            boolean success = bookingDAO.updateBookingStatus(bookingId, "CONFIRMED");
            
            if (success) {
                response.sendRedirect("bookings.jsp?success=confirm");
            } else {
                response.sendRedirect("bookings.jsp?error=1");
            }
        } else {
            response.sendRedirect("bookings.jsp?error=1");
        }
    } catch (NumberFormatException e) {
        response.sendRedirect("bookings.jsp?error=1");
    }
%>
