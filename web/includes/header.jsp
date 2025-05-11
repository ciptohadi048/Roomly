<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.roomly.model.User" %>

<%
    User currentUser = (User) session.getAttribute("currentUser");
    boolean isLoggedIn = currentUser != null;
    boolean isAdmin = isLoggedIn && currentUser.isAdmin();
    
    // Get the current page path to highlight active nav item
    String currentPath = request.getRequestURI();
    String contextPath = request.getContextPath();
    String relativePath = currentPath.substring(contextPath.length());
    
    // Fix admin path references
    String adminPrefix = "";
    if (relativePath.startsWith("/admin/")) {
        adminPrefix = "../";
    }
%>

<link rel="stylesheet" href="<%= adminPrefix %>assets/css/navbar.css">

<header>
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
        <div class="container">
            <a class="navbar-brand navbar-brand-custom" href="<%= adminPrefix %>index.jsp">Roomly</a>
            <button class="navbar-toggler navbar-toggler-custom" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon navbar-toggler-icon-custom"></span>
            </button>
            <div class="collapse navbar-collapse navbar-collapse-custom" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom <%= relativePath.equals("/index.jsp") ? "active" : "" %>" href="<%= adminPrefix %>index.jsp">
                            <i class="fas fa-home"></i> Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom <%= relativePath.equals("/rooms.jsp") ? "active" : "" %>" href="<%= adminPrefix %>rooms.jsp">
                            <i class="fas fa-door-open"></i> Rooms
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom <%= relativePath.equals("/about.jsp") ? "active" : "" %>" href="<%= adminPrefix %>about.jsp">
                            <i class="fas fa-info-circle"></i> About Us
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-custom <%= relativePath.equals("/contact.jsp") ? "active" : "" %>" href="<%= adminPrefix %>contact.jsp">
                            <i class="fas fa-envelope"></i> Contact
                        </a>
                    </li>
                    <% if (isLoggedIn) { %>
                        <li class="nav-item">
                            <a class="nav-link nav-link-custom <%= relativePath.equals("/my-bookings.jsp") ? "active" : "" %>" href="<%= adminPrefix %>my-bookings.jsp">
                                <i class="fas fa-calendar-alt"></i> My Bookings
                            </a>
                        </li>
                    <% } %>
                    <% if (isAdmin) { %>
                        <li class="nav-item dropdown">
                            <a class="nav-link nav-link-custom dropdown-toggle <%= relativePath.startsWith("/admin/") ? "active" : "" %>" href="#" id="adminDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-user-shield"></i> Admin
                            </a>
                            <ul class="dropdown-menu dropdown-menu-custom" aria-labelledby="adminDropdown">
                                <li><a class="dropdown-item dropdown-item-custom" href="<%= relativePath.startsWith("/admin/") ? "" : "admin/" %>rooms.jsp">
                                    <i class="fas fa-door-open"></i> Manage Rooms
                                </a></li>
                                <li><a class="dropdown-item dropdown-item-custom" href="<%= relativePath.startsWith("/admin/") ? "" : "admin/" %>bookings.jsp">
                                    <i class="fas fa-calendar-check"></i> All Bookings
                                </a></li>
                                <li><a class="dropdown-item dropdown-item-custom" href="<%= relativePath.startsWith("/admin/") ? "" : "admin/" %>payments.jsp">
                                    <i class="fas fa-credit-card"></i> Payment History
                                </a></li>
                            </ul>
                        </li>
                    <% } %>
                </ul>
                <div class="d-flex">
                    <% if (isLoggedIn) { %>
                        <div class="dropdown">
                            <button class="user-dropdown-toggle dropdown-toggle" type="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-user-circle"></i> <%= currentUser.getUsername() %>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-custom dropdown-menu-end" aria-labelledby="userDropdown">
                                <li><a class="dropdown-item dropdown-item-custom" href="<%= adminPrefix %>profile.jsp">
                                    <i class="fas fa-user"></i> My Profile
                                </a></li>
                                <li><hr class="dropdown-divider dropdown-divider-custom"></li>
                                <li><a class="dropdown-item dropdown-item-custom" href="<%= adminPrefix %>logout.jsp">
                                    <i class="fas fa-sign-out-alt"></i> Logout
                                </a></li>
                            </ul>
                        </div>
                    <% } else { %>
                        <div class="auth-buttons">
                            <a href="<%= adminPrefix %>login.jsp" class="btn-login">
                                <i class="fas fa-sign-in-alt"></i> Login
                            </a>
                            <a href="<%= adminPrefix %>register.jsp" class="btn-register">
                                <i class="fas fa-user-plus"></i> Register
                            </a>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </nav>
</header>
