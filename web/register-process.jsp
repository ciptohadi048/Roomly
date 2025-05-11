<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.roomly.dao.UserDAO" %>
<%@ page import="com.roomly.model.User" %>

<%
    // Get form data
    String username = request.getParameter("username");
    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String password = request.getParameter("password");
    
    // Check if username already exists
    UserDAO userDAO = new UserDAO();
    User existingUser = userDAO.getUserByUsername(username);
    
    if (existingUser != null) {
        // Username already exists, redirect back to register page with error
        response.sendRedirect("register.jsp?error=1");
        return;
    }
    
    // Create new user
    User newUser = new User();
    newUser.setUsername(username);
    newUser.setPassword(password); // In a real app, this should be hashed
    newUser.setFullName(fullName);
    newUser.setEmail(email);
    newUser.setPhone(phone);
    newUser.setRole("CUSTOMER"); // Default role
    
    boolean success = userDAO.registerUser(newUser);
    
    if (success) {
        // Registration successful, redirect to login page
        response.sendRedirect("login.jsp?registered=1");
    } else {
        // Registration failed, redirect back to register page with error
        response.sendRedirect("register.jsp?error=3");
    }
%>
