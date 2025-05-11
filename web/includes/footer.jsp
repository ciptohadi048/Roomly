<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Get the current page path to handle admin paths
    String currentPath = request.getRequestURI();
    String contextPath = request.getContextPath();
    String relativePath = currentPath.substring(contextPath.length());
    
    // Fix admin path references
    String adminPrefix = "";
    if (relativePath.startsWith("/admin/")) {
        adminPrefix = "../";
    }
%>

<footer class="bg-dark text-white py-4 mt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <h5>Roomly</h5>
                <p>The easiest way to book rooms for your meetings, events, and study sessions.</p>
            </div>
            <div class="col-md-4">
                <h5>Quick Links</h5>
                <ul class="list-unstyled">
                    <li><a href="<%= adminPrefix %>index.jsp" class="text-white">Home</a></li>
                    <li><a href="<%= adminPrefix %>rooms.jsp" class="text-white">Rooms</a></li>
                    <li><a href="<%= adminPrefix %>about.jsp" class="text-white">About Us</a></li>
                    <li><a href="<%= adminPrefix %>contact.jsp" class="text-white">Contact</a></li>
                </ul>
            </div>
            <div class="col-md-4">
                <h5>Contact Us</h5>
                <address>
                    <p>123 Booking Street<br>
                    Room City, RC 12345</p>
                    <p>Email: info@roomly.com<br>
                    Phone: (123) 456-7890</p>
                </address>
            </div>
        </div>
        <hr>
        <div class="text-center">
            <p>&copy; <%= new java.util.Date().getYear() + 1900 %> Roomly. All rights reserved.</p>
        </div>
    </div>
</footer>
