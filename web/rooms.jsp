<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.roomly.dao.RoomDAO" %>
<%@ page import="com.roomly.model.Room" %>
<%@ page import="java.util.List" %>

<%
    // Get search parameters
    String keyword = request.getParameter("keyword");
    String roomType = request.getParameter("roomType");
    String capacityStr = request.getParameter("capacity");
    
    Integer minCapacity = null;
    if (capacityStr != null && !capacityStr.isEmpty()) {
        try {
            minCapacity = Integer.parseInt(capacityStr);
        } catch (NumberFormatException e) {
            // Ignore invalid input
        }
    }
    
    // Get rooms based on search criteria
    RoomDAO roomDAO = new RoomDAO();
    List<Room> rooms;
    
    if (keyword != null || roomType != null || minCapacity != null) {
        rooms = roomDAO.searchRooms(keyword, roomType, minCapacity);
    } else {
        rooms = roomDAO.getAllRooms();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Rooms - Roomly</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="assets/css/rooms.css">
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <div class="container">
        <div class="page-header">
            <div class="container">
                <h1 class="page-title">Browse Available Rooms</h1>
                <p class="page-subtitle">Find the perfect space for your needs</p>
            </div>
        </div>
        
        <!-- Search Form -->
        <div class="search-form-container">
            <form action="rooms.jsp" method="get" class="search-form">
                <div class="form-group">
                    <label for="keyword" class="form-label">Search</label>
                    <input type="text" class="form-control" id="keyword" name="keyword" placeholder="Room name or description" value="<%= keyword != null ? keyword : "" %>">
                </div>
                <div class="form-group">
                    <label for="roomType" class="form-label">Room Type</label>
                    <select class="form-control" id="roomType" name="roomType">
                        <option value="">All Types</option>
                        <option value="Conference" <%= "Conference".equals(roomType) ? "selected" : "" %>>Conference</option>
                        <option value="Meeting" <%= "Meeting".equals(roomType) ? "selected" : "" %>>Meeting</option>
                        <option value="Study" <%= "Study".equals(roomType) ? "selected" : "" %>>Study</option>
                        <option value="Presentation" <%= "Presentation".equals(roomType) ? "selected" : "" %>>Presentation</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="capacity" class="form-label">Min. Capacity</label>
                    <input type="number" class="form-control" id="capacity" name="capacity" min="1" value="<%= minCapacity != null ? minCapacity : "" %>">
                </div>
                <button type="submit" class="btn-search"><i class="fas fa-search"></i> Search</button>
            </form>
        </div>
        
        <!-- Room List -->
        <% if (rooms.isEmpty()) { %>
            <div class="no-results">
                <div class="no-results-icon">
                    <i class="fas fa-search"></i>
                </div>
                <h3 class="no-results-title">No Rooms Found</h3>
                <p class="no-results-text">No rooms found matching your criteria. Please try a different search.</p>
                <a href="rooms.jsp" class="btn-reset-search">Reset Search</a>
            </div>
        <% } else { %>
            <div class="rooms-grid">
                <% for (Room room : rooms) { %>
                    <div class="room-card">
                        <div class="room-image">
                            <% if (room.getImageUrl() != null && !room.getImageUrl().isEmpty()) { %>
                                <img src="<%= room.getImageUrl() %>" alt="<%= room.getRoomName() %>">
                            <% } else { %>
                                <img src="assets/images/room-placeholder.jpg" alt="<%= room.getRoomName() %>">
                            <% } %>
                            <span class="room-type-badge"><%= room.getRoomType() %></span>
                        </div>
                        <div class="room-details">
                            <h3 class="room-title"><%= room.getRoomName() %></h3>
                            <p class="room-description"><%= room.getDescription().length() > 100 ? room.getDescription().substring(0, 100) + "..." : room.getDescription() %></p>
                            <div class="room-info">
                                <div class="room-info-item">
                                    <i class="fas fa-user-friends"></i> Capacity: <%= room.getCapacity() %> people
                                </div>
                                <div class="room-info-item">
                                    <i class="fas fa-tag"></i> Type: <%= room.getRoomType() %>
                                </div>
                            </div>
                            <p class="room-price">$<%= String.format("%.2f", room.getPricePerHour()) %> per hour</p>
                            <div class="room-actions">
                                <a href="room-details.jsp?id=<%= room.getRoomId() %>" class="btn-view-details">View Details</a>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } %>
    </div>
    
    <jsp:include page="includes/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/script.js"></script>
</body>
</html>
