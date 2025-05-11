<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.roomly.dao.BookingDAO" %>
<%@ page import="com.roomly.model.Booking" %>
<%@ page import="com.roomly.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%
   // Check if user is logged in
   User currentUser = (User) session.getAttribute("currentUser");
   if (currentUser == null) {
       response.sendRedirect("login.jsp");
       return;
   }

   int userId = currentUser.getUserId();
   
   // Get user's bookings
   BookingDAO bookingDAO = new BookingDAO();
   List<Booking> bookings = bookingDAO.getBookingsByUserId(userId);
   
   SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
   SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
   
   Date now = new Date();
   
   // Get success/error messages
   String success = request.getParameter("success");
   String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>My Bookings - Roomly</title>
   <!-- Bootstrap CSS -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
   <!-- Font Awesome for icons -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
   <!-- Custom CSS -->
   <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
   <jsp:include page="includes/header.jsp" />
   
   <div class="container mt-5 mb-5">
       <div class="row">
           <div class="col-12">
               <h1 class="mb-4">My Bookings</h1>
               
               <% if (success != null) { %>
                   <div class="alert alert-success alert-dismissible fade show" role="alert">
                       <% if (success.equals("cancel")) { %>
                           <i class="fas fa-check-circle me-2"></i> Your booking has been successfully cancelled.
                       <% } else if (success.equals("reschedule")) { %>
                           <i class="fas fa-check-circle me-2"></i> Your booking has been successfully rescheduled.
                       <% } %>
                       <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                   </div>
               <% } %>
               
               <% if (error != null) { %>
                   <div class="alert alert-danger alert-dismissible fade show" role="alert">
                       <i class="fas fa-exclamation-circle me-2"></i>
                       <% if (error.equals("system")) { %>
                           A system error occurred. Please try again later.
                       <% } else if (error.equals("unauthorized")) { %>
                           You are not authorized to perform this action.
                       <% } else if (error.equals("invalid_input")) { %>
                           Invalid input. Please check your data and try again.
                       <% } %>
                       <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                   </div>
               <% } %>
               
               <% if (bookings.isEmpty()) { %>
                   <div class="card text-center p-5 shadow-sm">
                       <div class="card-body">
                           <i class="fas fa-calendar-times fa-4x text-muted mb-3"></i>
                           <h3>No Bookings Found</h3>
                           <p class="text-muted">You haven't made any bookings yet.</p>
                           <a href="rooms.jsp" class="btn btn-primary mt-3">
                               <i class="fas fa-search me-2"></i> Browse Rooms
                           </a>
                       </div>
                   </div>
               <% } else { %>
                   <div class="card shadow-sm">
                       <div class="card-header bg-light">
                           <ul class="nav nav-tabs card-header-tabs" id="bookingTabs" role="tablist">
                               <li class="nav-item" role="presentation">
                                   <button class="nav-link active" id="all-tab" data-bs-toggle="tab" data-bs-target="#all" type="button" role="tab" aria-controls="all" aria-selected="true">All Bookings</button>
                               </li>
                               <li class="nav-item" role="presentation">
                                   <button class="nav-link" id="upcoming-tab" data-bs-toggle="tab" data-bs-target="#upcoming" type="button" role="tab" aria-controls="upcoming" aria-selected="false">Upcoming</button>
                               </li>
                               <li class="nav-item" role="presentation">
                                   <button class="nav-link" id="past-tab" data-bs-toggle="tab" data-bs-target="#past" type="button" role="tab" aria-controls="past" aria-selected="false">Past</button>
                               </li>
                               <li class="nav-item" role="presentation">
                                   <button class="nav-link" id="cancelled-tab" data-bs-toggle="tab" data-bs-target="#cancelled" type="button" role="tab" aria-controls="cancelled" aria-selected="false">Cancelled</button>
                               </li>
                           </ul>
                       </div>
                       <div class="card-body">
                           <div class="tab-content" id="bookingTabsContent">
                               <div class="tab-pane fade show active" id="all" role="tabpanel" aria-labelledby="all-tab">
                                   <div class="table-responsive">
                                       <table class="table table-hover">
                                           <thead class="table-light">
                                               <tr>
                                                   <th>Room</th>
                                                   <th>Check-in</th>
                                                   <th>Check-out</th>
                                                   <th>Status</th>
                                                   <th>Actions</th>
                                               </tr>
                                           </thead>
                                           <tbody>
                                               <% for (Booking booking : bookings) {
                                                   boolean isPastBooking = booking.getStartTime().before(now);
                                                   boolean canReschedule = !isPastBooking && 
                                                                          !booking.getBookingStatus().equals("CANCELLED") && 
                                                                          !booking.getBookingStatus().equals("COMPLETED");
                                                   
                                                   String statusClass = "";
                                                   if (booking.getBookingStatus().equals("CONFIRMED")) {
                                                       statusClass = "bg-success";
                                                   } else if (booking.getBookingStatus().equals("PENDING")) {
                                                       statusClass = "bg-warning text-dark";
                                                   } else if (booking.getBookingStatus().equals("CANCELLED")) {
                                                       statusClass = "bg-danger";
                                                   } else if (booking.getBookingStatus().equals("COMPLETED")) {
                                                       statusClass = "bg-info";
                                                   }
                                               %>
                                                   <tr class="<%= isPastBooking ? "text-muted" : "" %>">
                                                       <td><%= booking.getRoomName() %></td>
                                                       <td>
                                                           <div><%= dateFormat.format(booking.getStartTime()) %></div>
                                                           <small class="text-muted"><%= timeFormat.format(booking.getStartTime()) %></small>
                                                       </td>
                                                       <td>
                                                           <div><%= dateFormat.format(booking.getEndTime()) %></div>
                                                           <small class="text-muted"><%= timeFormat.format(booking.getEndTime()) %></small>
                                                       </td>
                                                       <td><span class="badge <%= statusClass %>"><%= booking.getBookingStatus() %></span></td>
                                                       <td>
                                                           <div class="btn-group" role="group">
                                                               <a href="booking-details.jsp?id=<%= booking.getBookingId() %>" class="btn btn-sm btn-outline-primary">
                                                                   <i class="fas fa-info-circle"></i> Details
                                                               </a>
                                                               
                                                               <% if (canReschedule) { %>
                                                                   <a href="reschedule-booking.jsp?id=<%= booking.getBookingId() %>" class="btn btn-sm btn-outline-info">
                                                                       <i class="fas fa-calendar-alt"></i> Reschedule
                                                                   </a>
                                                               <% } %>
                                                               
                                                               <% if (!isPastBooking && !booking.getBookingStatus().equals("CANCELLED")) { %>
                                                                   <a href="cancel-booking.jsp?id=<%= booking.getBookingId() %>" class="btn btn-sm btn-outline-danger" 
                                                                      onclick="return confirm('Are you sure you want to cancel this booking?')">
                                                                       <i class="fas fa-times-circle"></i> Cancel
                                                                   </a>
                                                               <% } %>
                                                           </div>
                                                       </td>
                                                   </tr>
                                               <% } %>
                                           </tbody>
                                       </table>
                                   </div>
                               </div>
                               
                               <!-- Upcoming Bookings Tab -->
                               <div class="tab-pane fade" id="upcoming" role="tabpanel" aria-labelledby="upcoming-tab">
                                   <div class="table-responsive">
                                       <table class="table table-hover">
                                           <thead class="table-light">
                                               <tr>
                                                   <th>Room</th>
                                                   <th>Check-in</th>
                                                   <th>Check-out</th>
                                                   <th>Status</th>
                                                   <th>Actions</th>
                                               </tr>
                                           </thead>
                                           <tbody>
                                               <% 
                                               boolean hasUpcoming = false;
                                               for (Booking booking : bookings) {
                                                   boolean isUpcoming = booking.getStartTime().after(now) && 
                                                                       !booking.getBookingStatus().equals("CANCELLED");
                                                   if (isUpcoming) {
                                                       hasUpcoming = true;
                                                       boolean canReschedule = !booking.getBookingStatus().equals("COMPLETED");
                                                       
                                                       String statusClass = "";
                                                       if (booking.getBookingStatus().equals("CONFIRMED")) {
                                                           statusClass = "bg-success";
                                                       } else if (booking.getBookingStatus().equals("PENDING")) {
                                                           statusClass = "bg-warning text-dark";
                                                       }
                                               %>
                                                   <tr>
                                                       <td><%= booking.getRoomName() %></td>
                                                       <td>
                                                           <div><%= dateFormat.format(booking.getStartTime()) %></div>
                                                           <small class="text-muted"><%= timeFormat.format(booking.getStartTime()) %></small>
                                                       </td>
                                                       <td>
                                                           <div><%= dateFormat.format(booking.getEndTime()) %></div>
                                                           <small class="text-muted"><%= timeFormat.format(booking.getEndTime()) %></small>
                                                       </td>
                                                       <td><span class="badge <%= statusClass %>"><%= booking.getBookingStatus() %></span></td>
                                                       <td>
                                                           <div class="btn-group" role="group">
                                                               <a href="booking-details.jsp?id=<%= booking.getBookingId() %>" class="btn btn-sm btn-outline-primary">
                                                                   <i class="fas fa-info-circle"></i> Details
                                                               </a>
                                                               
                                                               <% if (canReschedule) { %>
                                                                   <a href="reschedule-booking.jsp?id=<%= booking.getBookingId() %>" class="btn btn-sm btn-outline-info">
                                                                       <i class="fas fa-calendar-alt"></i> Reschedule
                                                                   </a>
                                                               <% } %>
                                                               
                                                               <a href="cancel-booking.jsp?id=<%= booking.getBookingId() %>" class="btn btn-sm btn-outline-danger" 
                                                                  onclick="return confirm('Are you sure you want to cancel this booking?')">
                                                                   <i class="fas fa-times-circle"></i> Cancel
                                                               </a>
                                                           </div>
                                                       </td>
                                                   </tr>
                                               <% 
                                                   }
                                               } 
                                               if (!hasUpcoming) {
                                               %>
                                                   <tr>
                                                       <td colspan="5" class="text-center py-4">
                                                           <i class="fas fa-calendar-times fa-2x text-muted mb-3"></i>
                                                           <p class="mb-0">No upcoming bookings found.</p>
                                                       </td>
                                                   </tr>
                                               <% } %>
                                           </tbody>
                                       </table>
                                   </div>
                               </div>
                               
                               <!-- Past Bookings Tab -->
                               <div class="tab-pane fade" id="past" role="tabpanel" aria-labelledby="past-tab">
                                   <div class="table-responsive">
                                       <table class="table table-hover">
                                           <thead class="table-light">
                                               <tr>
                                                   <th>Room</th>
                                                   <th>Check-in</th>
                                                   <th>Check-out</th>
                                                   <th>Status</th>
                                                   <th>Actions</th>
                                               </tr>
                                           </thead>
                                           <tbody>
                                               <% 
                                               boolean hasPast = false;
                                               for (Booking booking : bookings) {
                                                   boolean isPast = booking.getStartTime().before(now) && 
                                                                   !booking.getBookingStatus().equals("CANCELLED");
                                                   if (isPast) {
                                                       hasPast = true;
                                                       
                                                       String statusClass = "";
                                                       if (booking.getBookingStatus().equals("CONFIRMED")) {
                                                           statusClass = "bg-success";
                                                       } else if (booking.getBookingStatus().equals("COMPLETED")) {
                                                           statusClass = "bg-info";
                                                       }
                                               %>
                                                   <tr class="text-muted">
                                                       <td><%= booking.getRoomName() %></td>
                                                       <td>
                                                           <div><%= dateFormat.format(booking.getStartTime()) %></div>
                                                           <small class="text-muted"><%= timeFormat.format(booking.getStartTime()) %></small>
                                                       </td>
                                                       <td>
                                                           <div><%= dateFormat.format(booking.getEndTime()) %></div>
                                                           <small class="text-muted"><%= timeFormat.format(booking.getEndTime()) %></small>
                                                       </td>
                                                       <td><span class="badge <%= statusClass %>"><%= booking.getBookingStatus() %></span></td>
                                                       <td>
                                                           <a href="booking-details.jsp?id=<%= booking.getBookingId() %>" class="btn btn-sm btn-outline-primary">
                                                               <i class="fas fa-info-circle"></i> Details
                                                           </a>
                                                       </td>
                                                   </tr>
                                               <% 
                                                   }
                                               } 
                                               if (!hasPast) {
                                               %>
                                                   <tr>
                                                       <td colspan="5" class="text-center py-4">
                                                           <i class="fas fa-history fa-2x text-muted mb-3"></i>
                                                           <p class="mb-0">No past bookings found.</p>
                                                       </td>
                                                   </tr>
                                               <% } %>
                                           </tbody>
                                       </table>
                                   </div>
                               </div>
                               
                               <!-- Cancelled Bookings Tab -->
                               <div class="tab-pane fade" id="cancelled" role="tabpanel" aria-labelledby="cancelled-tab">
                                   <div class="table-responsive">
                                       <table class="table table-hover">
                                           <thead class="table-light">
                                               <tr>
                                                   <th>Room</th>
                                                   <th>Check-in</th>
                                                   <th>Check-out</th>
                                                   <th>Status</th>
                                                   <th>Actions</th>
                                               </tr>
                                           </thead>
                                           <tbody>
                                               <% 
                                               boolean hasCancelled = false;
                                               for (Booking booking : bookings) {
                                                   if (booking.getBookingStatus().equals("CANCELLED")) {
                                                       hasCancelled = true;
                                               %>
                                                   <tr class="text-muted">
                                                       <td><%= booking.getRoomName() %></td>
                                                       <td>
                                                           <div><%= dateFormat.format(booking.getStartTime()) %></div>
                                                           <small class="text-muted"><%= timeFormat.format(booking.getStartTime()) %></small>
                                                       </td>
                                                       <td>
                                                           <div><%= dateFormat.format(booking.getEndTime()) %></div>
                                                           <small class="text-muted"><%= timeFormat.format(booking.getEndTime()) %></small>
                                                       </td>
                                                       <td><span class="badge bg-danger">CANCELLED</span></td>
                                                       <td>
                                                           <a href="booking-details.jsp?id=<%= booking.getBookingId() %>" class="btn btn-sm btn-outline-primary">
                                                               <i class="fas fa-info-circle"></i> Details
                                                           </a>
                                                       </td>
                                                   </tr>
                                               <% 
                                                   }
                                               } 
                                               if (!hasCancelled) {
                                               %>
                                                   <tr>
                                                       <td colspan="5" class="text-center py-4">
                                                           <i class="fas fa-ban fa-2x text-muted mb-3"></i>
                                                           <p class="mb-0">No cancelled bookings found.</p>
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
                   
                   <div class="mt-4">
                       <a href="rooms.jsp" class="btn btn-primary">
                           <i class="fas fa-plus-circle me-2"></i> Book a New Room
                       </a>
                   </div>
               <% } %>
           </div>
       </div>
   </div>
   
   <jsp:include page="includes/footer.jsp" />
   
   <!-- Bootstrap JS Bundle with Popper -->
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
   
   <script>
       // Initialize Bootstrap tabs
       document.addEventListener('DOMContentLoaded', function() {
           const triggerTabList = [].slice.call(document.querySelectorAll('#bookingTabs button'));
           triggerTabList.forEach(function(triggerEl) {
               const tabTrigger = new bootstrap.Tab(triggerEl);
               triggerEl.addEventListener('click', function(event) {
                   event.preventDefault();
                   tabTrigger.show();
               });
           });
       });
   </script>
</body>
</html>
