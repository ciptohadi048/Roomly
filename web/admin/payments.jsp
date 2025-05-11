<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.roomly.dao.PaymentDAO" %>
<%@ page import="com.roomly.dao.BookingDAO" %>
<%@ page import="com.roomly.model.Payment" %>
<%@ page import="com.roomly.model.Booking" %>
<%@ page import="com.roomly.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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
    
    // Get payments for each booking
    PaymentDAO paymentDAO = new PaymentDAO();
    List<Payment> payments = new ArrayList<>();
    
    for (Booking booking : bookings) {
        Payment payment = paymentDAO.getPaymentByBookingId(booking.getBookingId());
        if (payment != null) {
            payments.add(payment);
        }
    }
    
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d, yyyy h:mm a");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment History - Roomly Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/style.css">
</head>
<body>
    <jsp:include page="../includes/header.jsp" />
    
    <div class="container mt-5">
        <h2 class="mb-4">Payment History</h2>
        
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Payment ID</th>
                                <th>Booking ID</th>
                                <th>Amount</th>
                                <th>Payment Date</th>
                                <th>Status</th>
                                <th>Method</th>
                                <th>Transaction ID</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Payment payment : payments) { %>
                                <tr>
                                    <td>#<%= payment.getPaymentId() %></td>
                                    <td><a href="booking-details.jsp?id=<%= payment.getBookingId() %>">#<%= payment.getBookingId() %></a></td>
                                    <td>$<%= String.format("%.2f", payment.getAmount()) %></td>
                                    <td><%= dateFormat.format(payment.getPaymentDate()) %></td>
                                    <td>
                                        <% if (payment.getPaymentStatus().equals("COMPLETED")) { %>
                                            <span class="badge bg-success">Completed</span>
                                        <% } else if (payment.getPaymentStatus().equals("PENDING")) { %>
                                            <span class="badge bg-warning text-dark">Pending</span>
                                        <% } else if (payment.getPaymentStatus().equals("FAILED")) { %>
                                            <span class="badge bg-danger">Failed</span>
                                        <% } else if (payment.getPaymentStatus().equals("REFUNDED")) { %>
                                            <span class="badge bg-info">Refunded</span>
                                        <% } %>
                                    </td>
                                    <td><%= payment.getPaymentMethod() %></td>
                                    <td><small><%= payment.getTransactionId() %></small></td>
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
