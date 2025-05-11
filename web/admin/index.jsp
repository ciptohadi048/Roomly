<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.roomly.dao.BookingDAO" %>
<%@ page import="com.roomly.dao.RoomDAO" %>
<%@ page import="com.roomly.dao.UserDAO" %>
<%@ page import="com.roomly.dao.PaymentDAO" %>
<%@ page import="com.roomly.model.Booking" %>
<%@ page import="com.roomly.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%
    // Check if user is logged in and is admin
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null || !currentUser.isAdmin()) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    // Get recent bookings
    BookingDAO bookingDAO = new BookingDAO();
    List<Booking> recentBookings = bookingDAO.getAllBookings();
    // Limit to 5 most recent bookings
    if (recentBookings.size() > 5) {
        recentBookings = recentBookings.subList(0, 5);
    }
    
    SimpleDateFormat dateFormat = new SimpleDateFormat("EEE, MMM d, yyyy");
    SimpleDateFormat timeFormat = new SimpleDateFormat("h:mm a");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Roomly</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/index.css">
</head>
<body>
    <jsp:include page="../includes/header.jsp" />
    
    <div class="container mt-5">
        <h2 class="mb-4">Admin Dashboard</h2>
        
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="card admin-stats-card">
                    <div class="stat-value">
                        <%= recentBookings.size() %>
                    </div>
                    <div class="stat-label">Recent Bookings</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card admin-stats-card">
                    <div class="stat-value">
                        <% 
                            int confirmedCount = 0;
                            for (Booking booking : recentBookings) {
                                if (booking.getBookingStatus().equals("CONFIRMED")) {
                                    confirmedCount++;
                                }
                            }
                        %>
                        <%= confirmedCount %>
                    </div>
                    <div class="stat-label">Confirmed Bookings</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card admin-stats-card">
                    <div class="stat-value">
                        <% 
                            int pendingCount = 0;
                            for (Booking booking : recentBookings) {
                                if (booking.getBookingStatus().equals("PENDING")) {
                                    pendingCount++;
                                }
                            }
                        %>
                        <%= pendingCount %>
                    </div>
                    <div class="stat-label">Pending Bookings</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card admin-stats-card">
                    <div class="stat-value">
                        <% 
                            int cancelledCount = 0;
                            for (Booking booking : recentBookings) {
                                if (booking.getBookingStatus().equals("CANCELLED")) {
                                    cancelledCount++;
                                }
                            }
                        %>
                        <%= cancelledCount %>
                    </div>
                    <div class="stat-label">Cancelled Bookings</div>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Recent Bookings</h5>
                        <a href="bookings.jsp" class="btn btn-sm btn-primary">View All</a>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>User</th>
                                        <th>Room</th>
                                        <th>Date</th>
                                        <th>Time</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Booking booking : recentBookings) { %>
                                        <tr>
                                            <td>#<%= booking.getBookingId() %></td>
                                            <td><%= booking.getUserName() %></td>
                                            <td><%= booking.getRoomName() %></td>
                                            <td><%= dateFormat.format(booking.getStartTime()) %></td>
                                            <td><%= timeFormat.format(booking.getStartTime()) %> - <%= timeFormat.format(booking.getEndTime()) %></td>
                                            <td>
                                                <% if (booking.getBookingStatus().equals("CONFIRMED")) { %>
                                                    <span class="badge bg-success">Confirmed</span>
                                                <% } else if (booking.getBookingStatus().equals("PENDING")) { %>
                                                    <span class="badge bg-warning text-dark">Pending</span>
                                                <% } else if (booking.getBookingStatus().equals("CANCELLED")) { %>
                                                    <span class="badge bg-danger">Cancelled</span>
                                                <% } %>
                                            </td>
                                            <td>
                                                <a href="booking-details.jsp?id=<%= booking.getBookingId() %>" class="btn btn-sm btn-primary">View</a>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row mt-4">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Quick Actions</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4">
                                <a href="rooms.jsp" class="btn btn-primary w-100 mb-3">Manage Rooms</a>
                            </div>
                            <div class="col-md-4">
                                <a href="bookings.jsp" class="btn btn-success w-100 mb-3">View All Bookings</a>
                            </div>
                            <div class="col-md-4">
                                <a href="payments.jsp" class="btn btn-info w-100 mb-3 text-white">Payment History</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../includes/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../assets/js/script.js"></script>
</body>
</html>
