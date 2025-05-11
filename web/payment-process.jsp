<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.roomly.dao.PaymentDAO" %>
<%@ page import="com.roomly.dao.BookingDAO" %>
<%@ page import="com.roomly.model.Payment" %>
<%@ page import="com.roomly.model.User" %>
<%@ page import="java.util.UUID" %>

<%
    // Check if user is logged in
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get form data
    String bookingIdStr = request.getParameter("bookingId");
    String amountStr = request.getParameter("amount");
    String paymentMethod = request.getParameter("paymentMethod");
    
    System.out.println("Payment Process - Booking ID: " + bookingIdStr);
    System.out.println("Payment Process - Amount: " + amountStr);
    System.out.println("Payment Process - Payment Method: " + paymentMethod);
    
    // Validate input
    if (bookingIdStr == null || amountStr == null || paymentMethod == null) {
        System.out.println("Payment Process - Missing required parameters");
        response.sendRedirect("rooms.jsp");
        return;
    }
    
    try {
        int bookingId = Integer.parseInt(bookingIdStr);
        double amount = Double.parseDouble(amountStr);
        
        // Generate a transaction ID
        String transactionId = UUID.randomUUID().toString();
        
        // Create payment object
        Payment payment = new Payment();
        payment.setBookingId(bookingId);
        payment.setAmount(amount);
        payment.setPaymentStatus("COMPLETED"); // In a real app, this would depend on payment gateway response
        payment.setPaymentMethod(paymentMethod);
        payment.setTransactionId(transactionId);
        
        System.out.println("Payment Process - Processing payment for booking ID: " + bookingId);
        
        // Process payment and update booking status
        PaymentDAO paymentDAO = new PaymentDAO();
        boolean success = paymentDAO.processPayment(payment, bookingId);
        
        if (success) {
            System.out.println("Payment Process - Payment successful");
            
            // Clear session attributes
            session.removeAttribute("bookingId");
            session.removeAttribute("totalAmount");
            
            // Redirect to confirmation page
            response.sendRedirect("booking-confirmation.jsp?id=" + bookingId);
        } else {
            System.out.println("Payment Process - Payment failed");
            response.sendRedirect("payment.jsp?error=1");
        }
    } catch (Exception e) {
        e.printStackTrace();
        System.out.println("Payment Process - Exception: " + e.getMessage());
        response.sendRedirect("payment.jsp?error=2");
    }
%>
