<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.roomly.dao.BookingDAO" %>
<%@ page import="com.roomly.dao.PaymentDAO" %>
<%@ page import="com.roomly.model.Booking" %>
<%@ page import="com.roomly.model.Payment" %>
<%@ page import="com.roomly.model.User" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    // Check if user is logged in
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get booking ID from request
    String bookingIdStr = request.getParameter("id");
    if (bookingIdStr == null) {
        response.sendRedirect("my-bookings.jsp");
        return;
    }
    
    int bookingId = 0;
    try {
        bookingId = Integer.parseInt(bookingIdStr);
    } catch (NumberFormatException e) {
        response.sendRedirect("my-bookings.jsp");
        return;
    }
    
    // Get booking details
    BookingDAO bookingDAO = new BookingDAO();
    Booking booking = bookingDAO.getBookingById(bookingId);
    
    if (booking == null || booking.getUserId() != currentUser.getUserId()) {
        response.sendRedirect("my-bookings.jsp");
        return;
    }
    
    // Get payment details
    PaymentDAO paymentDAO = new PaymentDAO();
    Payment payment = paymentDAO.getPaymentByBookingId(bookingId);
    
    SimpleDateFormat dateFormat = new SimpleDateFormat("EEEE, MMMM d, yyyy");
    SimpleDateFormat timeFormat = new SimpleDateFormat("h:mm a");
    
    String bookingDate = dateFormat.format(booking.getStartTime());
    String startTime = timeFormat.format(booking.getStartTime());
    String endTime = timeFormat.format(booking.getEndTime());
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation - Roomly</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-success text-white">
                        <h4 class="mb-0">Booking Confirmed!</h4>
                    </div>
                    <div class="card-body">
                        <div class="text-center mb-4">
                            <div class="display-1 text-success">
                                <i class="bi bi-check-circle-fill"></i>
                            </div>
                            <h5>Thank you for your booking!</h5>
                            <p>Your reservation has been confirmed and payment has been processed successfully.</p>
                        </div>
                        
                        <div class="card mb-4">
                            <div class="card-header">
                                <h5 class="mb-0">Booking Details</h5>
                            </div>
                            <div class="card-body">
                                <div class="row mb-2">
                                    <div class="col-md-4 fw-bold">Booking ID:</div>
                                    <div class="col-md-8">#<%= booking.getBookingId() %></div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-md-4 fw-bold">Room:</div>
                                    <div class="col-md-8"><%= booking.getRoomName() %></div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-md-4 fw-bold">Date:</div>
                                    <div class="col-md-8"><%= bookingDate %></div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-md-4 fw-bold">Time:</div>
                                    <div class="col-md-8"><%= startTime %> - <%= endTime %></div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-md-4 fw-bold">Status:</div>
                                    <div class="col-md-8">
                                        <span class="badge bg-success">Confirmed</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <% if (payment != null) { %>
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h5 class="mb-0">Payment Information</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row mb-2">
                                        <div class="col-md-4 fw-bold">Amount Paid:</div>
                                        <div class="col-md-8">$<%= String.format("%.2f", payment.getAmount()) %></div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-md-4 fw-bold">Payment Method:</div>
                                        <div class="col-md-8"><%= payment.getPaymentMethod() %></div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-md-4 fw-bold">Transaction ID:</div>
                                        <div class="col-md-8"><%= payment.getTransactionId() %></div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-md-4 fw-bold">Payment Date:</div>
                                        <div class="col-md-8"><%= payment.getPaymentDate() %></div>
                                    </div>
                                </div>
                            </div>
                        <% } %>
                        
                        <div class="d-grid gap-2">
                            <a href="my-bookings.jsp" class="btn btn-primary">View All Bookings</a>
                            <a href="rooms.jsp" class="btn btn-outline-primary">Book Another Room</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="includes/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
