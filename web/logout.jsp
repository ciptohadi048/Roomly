<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Invalidate the session
    session.invalidate();
    
    // Clear any cookies
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("username")) {
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }
        }
    }
    
    // Redirect to home page
    response.sendRedirect("index.jsp");
%>
