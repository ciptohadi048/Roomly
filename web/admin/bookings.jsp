<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.roomly.dao.BookingDAO" %>
<%@ page import="com.roomly.model.Booking" %>
<%@ page import="com.roomly.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    // Check if user is logged in and is admin
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null || !currentUser.isAdmin()) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    // Get all bookings
    BookingDAO bookingDAO = new BookingDAO();
    List<Booking> bookings = bookingDAO.getAllBookings();
    
    SimpleDateFormat dateFormat = new SimpleDateFormat("EEE, MMM d, yyyy");
    SimpleDateFormat timeFormat = new SimpleDateFormat("h:mm a");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Bookings - Roomly Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/style.css">
</head>
<body>
    <jsp:include page="../includes/header.jsp" />
    
    <div class="container mt-5">
        <h2 class="mb-4">All Bookings</h2>
        
        <div class="card">
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
                                <th>Created</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Booking booking : bookings) { %>
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
                                    <td><%= booking.getCreatedAt() %></td>
                                    <td>
                                        <a href="booking-details.jsp?id=<%= booking.getBookingId() %>" class="btn btn-sm btn-primary">View</a>
                                        
                                        <% if (!booking.getBookingStatus().equals("CANCELLED")) { %>
                                            <button type="button" class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#cancelModal<%= booking.getBookingId() %>">
                                                Cancel
                                            </button>
                                            
                                            <!-- Cancel Booking Modal -->
                                            <div class="modal fade" id="cancelModal<%= booking.getBookingId() %>" tabindex="-1" aria-labelledby="cancelModalLabel<%= booking.getBookingId() %>" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="cancelModalLabel<%= booking.getBookingId() %>">Confirm Cancellation</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            Are you sure you want to cancel this booking? This action cannot be undone.
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            <a href="booking-process.jsp?action=cancel&id=<%= booking.getBookingId() %>" class="btn btn-danger">Cancel Booking</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        <% } %>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../includes/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../assets/js/script.js"></script>
</body>
</html>
