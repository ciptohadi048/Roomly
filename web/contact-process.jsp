<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.roomly.util.DatabaseUtil" %>

<%
    // Get form data
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String subject = request.getParameter("subject");
    String message = request.getParameter("message");
    
    // Validate input
    if (name == null || email == null || subject == null || message == null ||
        name.trim().isEmpty() || email.trim().isEmpty() || subject.trim().isEmpty() || message.trim().isEmpty()) {
        response.sendRedirect("contact.jsp");
        return;
    }
    
    // In a real application, you would:
    // 1. Store the message in the database
    // 2. Send an email notification
    // 3. Process the contact request
    
    // For demonstration, we'll just redirect with a success parameter
    response.sendRedirect("contact.jsp?success=1");
%>
