<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.roomly.dao.RoomDAO" %>
<%@ page import="com.roomly.model.Room" %>
<%@ page import="com.roomly.model.User" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    // Get room ID from request
    String roomIdStr = request.getParameter("id");
    int roomId = 0;
    
    try {
        roomId = Integer.parseInt(roomIdStr);
    } catch (NumberFormatException e) {
        response.sendRedirect("rooms.jsp");
        return;
    }
    
    // Get room details
    RoomDAO roomDAO = new RoomDAO();
    Room room = roomDAO.getRoomById(roomId);
    
    if (room == null) {
        response.sendRedirect("rooms.jsp");
        return;
    }
    
    // Check if user is logged in
    User currentUser = (User) session.getAttribute("currentUser");
    boolean isLoggedIn = currentUser != null;
    
    // Get current date for default booking date
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    String today = dateFormat.format(new Date());
    
    // Check for error messages
    String error = request.getParameter("error");
    String errorMessage = "";
    if (error != null) {
        if (error.equals("unavailable")) {
            errorMessage = "This room is not available for the selected time slot.";
        } else if (error.equals("booking")) {
            errorMessage = "There was an error creating your booking. Please try again.";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= room.getRoomName() %> - Roomly</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        /* Enhanced styling for room details page */
        .room-header {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            border-radius: 0.5rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        
        .room-image {
            border-radius: 1rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
            max-height: 400px;
            object-fit: cover;
            width: 100%;
        }
        
        .room-image:hover {
            transform: scale(1.02);
        }
        
        .feature-icon {
            font-size: 2rem;
            color: #6a11cb;
            margin-bottom: 1rem;
        }
        
        .booking-card {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        .booking-card .card-header {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            color: white;
            font-weight: bold;
            padding: 1.5rem;
        }
        
        .booking-form {
            padding: 2rem;
        }
        
        .form-control, .btn {
            border-radius: 0.5rem;
            padding: 0.75rem 1rem;
        }
        
        .btn-book {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            border: none;
            padding: 1rem;
            font-weight: bold;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .btn-book:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(106, 17, 203, 0.3);
        }
        
        .room-details-card {
            border: none;
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .room-details-card .list-group-item {
            padding: 1rem 1.5rem;
            border-left: none;
            border-right: none;
        }
        
        .room-details-card .list-group-item:last-child {
            border-bottom: none;
        }
        
        .room-description {
            font-size: 1.1rem;
            line-height: 1.8;
            color: #555;
        }
        
        .estimated-cost-container {
            background-color: #f8f9fa;
            padding: 1rem;
            border-radius: 0.5rem;
            margin-bottom: 1.5rem;
        }
        
        .room-type-badge {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 2rem;
            font-weight: bold;
            display: inline-block;
            margin-bottom: 1rem;
        }
        
        /* Animation for booking confirmation */
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        .pulse {
            animation: pulse 2s infinite;
        }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <div class="room-header">
        <div class="container">
            <h1 class="display-4"><%= room.getRoomName() %></h1>
            <div class="room-type-badge">
                <i class="fas fa-tag me-2"></i><%= room.getRoomType() %>
            </div>
        </div>
    </div>
    
    <div class="container mt-4">
        <% if (!errorMessage.isEmpty()) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i><%= errorMessage %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        
        <div class="row">
            <div class="col-lg-7 mb-4">
                <% if (room.getImageUrl() != null && !room.getImageUrl().isEmpty()) { %>
                    <img src="<%= room.getImageUrl() %>" class="room-image" alt="<%= room.getRoomName() %>">
                <% } else { %>
                    <img src="assets/images/room-placeholder.jpg" class="room-image" alt="<%= room.getRoomName() %>">
                <% } %>
                
                <div class="mt-4">
                    <h3>About This Room</h3>
                    <p class="room-description"><%= room.getDescription() %></p>
                    
                    <div class="room-details-card">
                        <div class="card-body">
                            <h5 class="card-title">Room Features</h5>
                            <div class="row text-center mt-4">
                                <div class="col-md-4 mb-4">
                                    <div class="feature-icon">
                                        <i class="fas fa-users"></i>
                                    </div>
                                    <h6>Capacity</h6>
                                    <p><%= room.getCapacity() %> people</p>
                                </div>
                                <div class="col-md-4 mb-4">
                                    <div class="feature-icon">
                                        <i class="fas fa-wifi"></i>
                                    </div>
                                    <h6>Wi-Fi</h6>
                                    <p>High-speed internet</p>
                                </div>
                                <div class="col-md-4 mb-4">
                                    <div class="feature-icon">
                                        <i class="fas fa-tv"></i>
                                    </div>
                                    <h6>Equipment</h6>
                                    <p>Projector & Screen</p>
                                </div>
                            </div>
                        </div>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item d-flex justify-content-between">
                                <span>Room Type:</span>
                                <span class="fw-bold"><%= room.getRoomType() %></span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between">
                                <span>Capacity:</span>
                                <span class="fw-bold"><%= room.getCapacity() %> people</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between">
                                <span>Price:</span>
                                <span class="fw-bold">$<%= String.format("%.2f", room.getPricePerHour()) %> per hour</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-5">
                <div class="booking-card">
                    <div class="card-header">
                        <h4 class="mb-0"><i class="fas fa-calendar-check me-2"></i>Book This Room</h4>
                    </div>
                    <div class="card-body booking-form">
                        <% if (isLoggedIn) { %>
                            <form action="booking-process.jsp" method="post" id="bookingForm" onsubmit="return validateBookingForm()">
                                <input type="hidden" name="roomId" value="<%= room.getRoomId() %>">
                                <input type="hidden" name="pricePerHour" id="pricePerHour" value="<%= room.getPricePerHour() %>">
                                
                                <div class="mb-3">
                                    <label for="bookingDate" class="form-label">Date</label>
                                    <input type="date" class="form-control" id="bookingDate" name="bookingDate" min="<%= today %>" required>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="startTime" class="form-label">Start Time</label>
                                        <input type="time" class="form-control" id="startTime" name="startTime" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="endTime" class="form-label">End Time</label>
                                        <input type="time" class="form-control" id="endTime" name="endTime" required>
                                    </div>
                                </div>
                                
                                <div class="mb-4 estimated-cost-container">
                                    <label class="form-label fw-bold">Estimated Cost:</label>
                                    <div class="input-group">
                                        <span class="input-group-text">$</span>
                                        <input type="text" class="form-control" id="estimatedCost" readonly value="0.00">
                                    </div>
                                </div>
                                
                                <button type="submit" class="btn btn-primary btn-book w-100">
                                    <i class="fas fa-credit-card me-2"></i>Proceed to Payment
                                </button>
                            </form>
                        <% } else { %>
                            <div class="alert alert-info mb-0">
                                <i class="fas fa-info-circle me-2"></i>Please <a href="login.jsp" class="alert-link">login</a> to book this room.
                            </div>
                        <% } %>
                    </div>
                </div>
                
                <div class="card mt-4 room-details-card">
                    <div class="card-body">
                        <h5 class="card-title"><i class="fas fa-info-circle me-2"></i>Booking Information</h5>
                        <ul class="list-unstyled mt-3">
                            <li class="mb-2"><i class="fas fa-check-circle text-success me-2"></i> Free cancellation up to 24 hours before</li>
                            <li class="mb-2"><i class="fas fa-check-circle text-success me-2"></i> Pay only for the time you need</li>
                            <li class="mb-2"><i class="fas fa-check-circle text-success me-2"></i> All equipment included in price</li>
                            <li class="mb-2"><i class="fas fa-check-circle text-success me-2"></i> Technical support available</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="includes/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function validateBookingForm() {
            var bookingDate = document.getElementById("bookingDate").value;
            var startTime = document.getElementById("startTime").value;
            var endTime = document.getElementById("endTime").value;
            
            if (!bookingDate || !startTime || !endTime) {
                alert("Please fill in all fields.");
                return false;
            }
            
            var startDateTime = new Date(bookingDate + "T" + startTime);
            var endDateTime = new Date(bookingDate + "T" + endTime);
            
            if (endDateTime <= startDateTime) {
                alert("End time must be after start time.");
                return false;
            }
            
            return true;
        }
        
        // Calculate estimated cost
        document.addEventListener("DOMContentLoaded", function() {
            var pricePerHour = parseFloat(document.getElementById("pricePerHour").value);
            var startTimeInput = document.getElementById("startTime");
            var endTimeInput = document.getElementById("endTime");
            var estimatedCostInput = document.getElementById("estimatedCost");
            
            function calculateCost() {
                if (startTimeInput.value && endTimeInput.value) {
                    var startParts = startTimeInput.value.split(":");
                    var endParts = endTimeInput.value.split(":");
                    
                    var startMinutes = parseInt(startParts[0]) * 60 + parseInt(startParts[1]);
                    var endMinutes = parseInt(endParts[0]) * 60 + parseInt(endParts[1]);
                    
                    if (endMinutes > startMinutes) {
                        var durationHours = (endMinutes - startMinutes) / 60;
                        var cost = durationHours * pricePerHour;
                        estimatedCostInput.value = cost.toFixed(2);
                    } else {
                        estimatedCostInput.value = "0.00";
                    }
                }
            }
            
            startTimeInput.addEventListener("change", calculateCost);
            endTimeInput.addEventListener("change", calculateCost);
        });
    </script>
</body>
</html>
