<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.roomly.dao.BookingDAO" %>
<%@ page import="com.roomly.dao.RoomDAO" %>
<%@ page import="com.roomly.model.Booking" %>
<%@ page import="com.roomly.model.Room" %>
<%@ page import="com.roomly.model.User" %>
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
   String bookingIdStr = request.getParameter("id");
   
   if (bookingIdStr == null || bookingIdStr.isEmpty()) {
       response.sendRedirect("my-bookings.jsp");
       return;
   }
   
   int bookingId = Integer.parseInt(bookingIdStr);
   
   // Get booking details
   BookingDAO bookingDAO = new BookingDAO();
   Booking booking = bookingDAO.getBookingById(bookingId);
   
   // Check if booking exists and belongs to the user
   if (booking == null || booking.getUserId() != userId) {
       response.sendRedirect("my-bookings.jsp");
       return;
   }
   
   // Get room details
   RoomDAO roomDAO = new RoomDAO();
   Room room = roomDAO.getRoomById(booking.getRoomId());
   
   SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
   SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
   
   Date now = new Date();
   boolean isPastBooking = booking.getStartTime().before(now);
   
   // Check if booking can be rescheduled
   if (isPastBooking || booking.getBookingStatus().equals("CANCELLED") || booking.getBookingStatus().equals("COMPLETED")) {
       response.sendRedirect("booking-details.jsp?id=" + bookingId + "&error=cannot_reschedule");
       return;
   }
   
   // Format dates for form
   String currentDate = dateFormat.format(booking.getStartTime());
   String currentStartTime = timeFormat.format(booking.getStartTime());
   String currentEndTime = timeFormat.format(booking.getEndTime());
   
   // Error message
   String errorMsg = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>Reschedule Booking - Roomly</title>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
   <link rel="stylesheet" href="assets/css/style.css">
   <style>
       .reschedule-container {
           background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
           border-radius: 15px;
           padding: 30px;
           box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
           max-width: 800px;
           margin: 40px auto;
       }
       
       .reschedule-header {
           text-align: center;
           margin-bottom: 30px;
           position: relative;
       }
       
       .reschedule-header h1 {
           color: #4a6fa5;
           font-size: 32px;
           margin-bottom: 10px;
           text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
       }
       
       .reschedule-header p {
           color: #666;
           font-size: 16px;
       }
       
       .booking-info-card {
           background-color: white;
           border-radius: 10px;
           padding: 20px;
           margin-bottom: 30px;
           box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
           border-left: 5px solid #4a6fa5;
       }
       
       .booking-info-card h3 {
           color: #4a6fa5;
           margin-bottom: 15px;
           font-size: 20px;
       }
       
       .booking-info-grid {
           display: grid;
           grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
           gap: 15px;
       }
       
       .booking-info-item {
           margin-bottom: 10px;
       }
       
       .booking-info-item label {
           display: block;
           font-size: 12px;
           color: #888;
           margin-bottom: 5px;
       }
       
       .booking-info-item p {
           font-weight: 600;
           color: #333;
           font-size: 16px;
       }
       
       .reschedule-form {
           background-color: white;
           border-radius: 10px;
           padding: 25px;
           box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
       }
       
       .reschedule-form h3 {
           color: #4a6fa5;
           margin-bottom: 20px;
           font-size: 20px;
           text-align: center;
       }
       
       .form-group {
           margin-bottom: 20px;
       }
       
       .form-group label {
           display: block;
           margin-bottom: 8px;
           color: #555;
           font-weight: 500;
       }
       
       .form-control {
           width: 100%;
           padding: 12px 15px;
           border: 1px solid #ddd;
           border-radius: 8px;
           font-size: 16px;
           transition: all 0.3s;
       }
       
       .form-control:focus {
           border-color: #4a6fa5;
           box-shadow: 0 0 0 3px rgba(74, 111, 165, 0.2);
       }
       
       .btn-reschedule {
           background: linear-gradient(to right, #4a6fa5, #6b8cce);
           color: white;
           border: none;
           padding: 12px 25px;
           border-radius: 8px;
           font-size: 16px;
           font-weight: 600;
           cursor: pointer;
           width: 100%;
           transition: all 0.3s;
           text-transform: uppercase;
           letter-spacing: 1px;
       }
       
       .btn-reschedule:hover {
           background: linear-gradient(to right, #3d5d8a, #5a7ab8);
           transform: translateY(-2px);
           box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
       }
       
       .btn-cancel {
           background: transparent;
           color: #666;
           border: 1px solid #ddd;
           padding: 12px 25px;
           border-radius: 8px;
           font-size: 16px;
           font-weight: 600;
           cursor: pointer;
           width: 100%;
           transition: all 0.3s;
           margin-top: 10px;
       }
       
       .btn-cancel:hover {
           background-color: #f5f5f5;
           color: #333;
       }
       
       .form-actions {
           display: grid;
           grid-template-columns: 1fr 1fr;
           gap: 15px;
           margin-top: 30px;
       }
       
       .alert {
           padding: 15px;
           border-radius: 8px;
           margin-bottom: 20px;
           font-weight: 500;
       }
       
       .alert-danger {
           background-color: #ffe5e5;
           color: #d63031;
           border-left: 4px solid #d63031;
       }
       
       .policy-section {
           margin-top: 30px;
           background-color: #f8f9fa;
           border-radius: 10px;
           padding: 20px;
           border-left: 5px solid #ffc107;
       }
       
       .policy-section h3 {
           color: #555;
           margin-bottom: 15px;
           font-size: 18px;
       }
       
       .policy-section ul {
           padding-left: 20px;
       }
       
       .policy-section li {
           margin-bottom: 10px;
           color: #666;
       }
       
       @media (max-width: 768px) {
           .booking-info-grid {
               grid-template-columns: 1fr;
           }
           
           .form-actions {
               grid-template-columns: 1fr;
           }
       }
   </style>
</head>
<body>
   <jsp:include page="includes/header.jsp" />
   
   <div class="container">
       <div class="reschedule-container">
           <div class="reschedule-header">
               <h1>Reschedule Your Booking</h1>
               <p>Select a new date and time for your reservation</p>
           </div>
           
           <% if (errorMsg != null && errorMsg.equals("unavailable")) { %>
               <div class="alert alert-danger">
                   The selected time slot is not available. Please choose a different time.
               </div>
           <% } %>
           
           <div class="booking-info-card">
               <h3>Current Booking Details</h3>
               <div class="booking-info-grid">
                   <div class="booking-info-item">
                       <label>Booking ID</label>
                       <p>#<%= booking.getBookingId() %></p>
                   </div>
                   <div class="booking-info-item">
                       <label>Room</label>
                       <p><%= room.getRoomName() %></p>
                   </div>
                   <div class="booking-info-item">
                       <label>Current Date</label>
                       <p><%= dateFormat.format(booking.getStartTime()) %></p>
                   </div>
                   <div class="booking-info-item">
                       <label>Current Time</label>
                       <p><%= timeFormat.format(booking.getStartTime()) %> - <%= timeFormat.format(booking.getEndTime()) %></p>
                   </div>
               </div>
           </div>
           
           <div class="reschedule-form">
               <h3>Choose New Date & Time</h3>
               <form action="reschedule-process.jsp" method="post" id="rescheduleForm">
                   <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                   <input type="hidden" name="roomId" value="<%= booking.getRoomId() %>">
                   
                   <div class="form-group">
                       <label for="newBookingDate">New Date:</label>
                       <input type="date" id="newBookingDate" name="newBookingDate" class="form-control" 
                              value="<%= currentDate %>" min="<%= dateFormat.format(now) %>" required>
                   </div>
                   
                   <div class="form-group">
                       <label for="newStartTime">New Start Time:</label>
                       <input type="time" id="newStartTime" name="newStartTime" class="form-control" 
                              value="<%= currentStartTime %>" required>
                   </div>
                   
                   <div class="form-group">
                       <label for="newEndTime">New End Time:</label>
                       <input type="time" id="newEndTime" name="newEndTime" class="form-control" 
                              value="<%= currentEndTime %>" required>
                   </div>
                   
                   <div class="form-group">
                       <label for="reason">Reason for Rescheduling:</label>
                       <textarea id="reason" name="reason" class="form-control" rows="3" required></textarea>
                   </div>
                   
                   <div class="form-actions">
                       <button type="submit" class="btn-reschedule">Reschedule Booking</button>
                       <a href="booking-details.jsp?id=<%= booking.getBookingId() %>" class="btn-cancel">Cancel</a>
                   </div>
               </form>
           </div>
           
           <div class="policy-section">
               <h3>Rescheduling Policy</h3>
               <ul>
                   <li>Bookings can be rescheduled up to 24 hours before the scheduled start time.</li>
                   <li>You can reschedule a booking up to 3 times.</li>
                   <li>Rescheduling is subject to room availability.</li>
                   <li>If the new time slot has a different price, the difference will be adjusted.</li>
               </ul>
           </div>
       </div>
   </div>
   
   <jsp:include page="includes/footer.jsp" />
   
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
   <script>
       document.addEventListener('DOMContentLoaded', function() {
           const form = document.getElementById('rescheduleForm');
           const dateInput = document.getElementById('newBookingDate');
           const startTimeInput = document.getElementById('newStartTime');
           const endTimeInput = document.getElementById('newEndTime');
           
           form.addEventListener('submit', function(e) {
               const selectedDate = new Date(dateInput.value + 'T' + startTimeInput.value);
               const endTime = new Date(dateInput.value + 'T' + endTimeInput.value);
               const now = new Date();
               
               // Check if selected date is in the past
               if (selectedDate < now) {
                   e.preventDefault();
                   alert('Cannot schedule a booking in the past. Please select a future date and time.');
                   return false;
               }
               
               // Check if end time is after start time
               if (endTime <= selectedDate) {
                   e.preventDefault();
                   alert('End time must be after start time.');
                   return false;
               }
               
               return true;
           });
       });
   </script>
</body>
</html>
