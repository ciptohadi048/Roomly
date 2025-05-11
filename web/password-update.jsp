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
    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
    
    // Verify current password
    if (!currentUser.getPassword().equals(currentPassword)) {
        response.sendRedirect("profile.jsp?error=password");
        return;
    }
    
    // Update password
    UserDAO userDAO = new UserDAO();
    boolean success = userDAO.changePassword(currentUser.getUserId(), newPassword);
    
    if (success) {
        // Update session with updated password
        currentUser.setPassword(newPassword);
        session.setAttribute("currentUser", currentUser);
        response.sendRedirect("profile.jsp?success=password");
    } else {
        response.sendRedirect("profile.jsp?error=1");
    }
%>
