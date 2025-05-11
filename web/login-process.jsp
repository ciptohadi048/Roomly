<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.roomly.dao.UserDAO" %>
<%@ page import="com.roomly.model.User" %>

<%
    // Get form data
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String rememberMe = request.getParameter("rememberMe");
    
    // Authenticate user
    UserDAO userDAO = new UserDAO();
    User user = userDAO.authenticateUser(username, password);
    
    if (user != null) {
        // Set session attributes
        session.setAttribute("currentUser", user);
        
        // If remember me is checked, set a cookie
        if (rememberMe != null) {
            Cookie usernameCookie = new Cookie("username", username);
            usernameCookie.setMaxAge(60 * 60 * 24 * 30); // 30 days
            response.addCookie(usernameCookie);
        }
        
        // Redirect based on user role
        if (user.isAdmin()) {
            response.sendRedirect("admin/bookings.jsp");
        } else {
            response.sendRedirect("index.jsp");
        }
    } else {
        // Authentication failed, redirect back to login page with error
        response.sendRedirect("login.jsp?error=1");
    }
%>
