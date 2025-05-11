<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.roomly.dao.UserDAO" %>
<%@ page import="com.roomly.model.User" %>

<%
    // Check if user is logged in
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get form data
    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    
    // Update user profile
    currentUser.setFullName(fullName);
    currentUser.setEmail(email);
    currentUser.setPhone(phone);
    
    UserDAO userDAO = new UserDAO();
    boolean success = userDAO.updateUser(currentUser);
    
    if (success) {
        // Update session with updated user
        session.setAttribute("currentUser", currentUser);
        response.sendRedirect("profile.jsp?success=profile");
    } else {
        response.sendRedirect("profile.jsp?error=1");
    }
%>
