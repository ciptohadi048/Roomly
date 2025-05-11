<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.roomly.dao.RoomDAO" %>
<%@ page import="com.roomly.model.Room" %>
<%@ page import="com.roomly.model.User" %>
<%@ page import="java.util.List" %>

<%
    // Check if user is logged in and is admin
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null || !currentUser.isAdmin()) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    // Get all rooms
    RoomDAO roomDAO = new RoomDAO();
    List<Room> rooms = roomDAO.getAllRooms();
    
    // Get success/error messages
    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Rooms - Roomly Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/style.css">
</head>
<body>
    <jsp:include page="../includes/header.jsp" />
    
    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Manage Rooms</h2>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addRoomModal">
                Add New Room
            </button>
        </div>
        
        <% if (success != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <% if (success.equals("add")) { %>
                    Room added successfully.
                <% } else if (success.equals("update")) { %>
                    Room updated successfully.
                <% } else if (success.equals("delete")) { %>
                    Room deleted successfully.
                <% } %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        
        <% if (error != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                An error occurred. Please try again.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Room Name</th>
                                <th>Type</th>
                                <th>Capacity</th>
                                <th>Price/Hour</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Room room : rooms) { %>
                                <tr>
                                    <td><%= room.getRoomId() %></td>
                                    <td><%= room.getRoomName() %></td>
                                    <td><%= room.getRoomType() %></td>
                                    <td><%= room.getCapacity() %></td>
                                    <td>$<%= String.format("%.2f", room.getPricePerHour()) %></td>
                                    <td>
                                        <% if (room.isActive()) { %>
                                            <span class="badge bg-success">Active</span>
                                        <% } else { %>
                                            <span class="badge bg-danger">Inactive</span>
                                        <% } %>
                                    </td>
                                    <td>
                                        <button type="button" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#editRoomModal<%= room.getRoomId() %>">
                                            Edit
                                        </button>
                                        <button type="button" class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#deleteRoomModal<%= room.getRoomId() %>">
                                            Delete
                                        </button>
                                    </td>
                                </tr>
                                
                                <!-- Edit Room Modal -->
                                <div class="modal fade" id="editRoomModal<%= room.getRoomId() %>" tabindex="-1" aria-labelledby="editRoomModalLabel<%= room.getRoomId() %>" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="editRoomModalLabel<%= room.getRoomId() %>">Edit Room</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <form action="room-process.jsp" method="post">
                                                <div class="modal-body">
                                                    <input type="hidden" name="action" value="update">
                                                    <input type="hidden" name="roomId" value="<%= room.getRoomId() %>">
                                                    
                                                    <div class="mb-3">
                                                        <label for="roomName<%= room.getRoomId() %>" class="form-label">Room Name</label>
                                                        <input type="text" class="form-control" id="roomName<%= room.getRoomId() %>" name="roomName" value="<%= room.getRoomName() %>" required>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="roomType<%= room.getRoomId() %>" class="form-label">Room Type</label>
                                                        <select class="form-select" id="roomType<%= room.getRoomId() %>" name="roomType" required>
                                                            <option value="Conference" <%= "Conference".equals(room.getRoomType()) ? "selected" : "" %>>Conference</option>
                                                            <option value="Meeting" <%= "Meeting".equals(room.getRoomType()) ? "selected" : "" %>>Meeting</option>
                                                            <option value="Study" <%= "Study".equals(room.getRoomType()) ? "selected" : "" %>>Study</option>
                                                            <option value="Presentation" <%= "Presentation".equals(room.getRoomType()) ? "selected" : "" %>>Presentation</option>
                                                        </select>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="capacity<%= room.getRoomId() %>" class="form-label">Capacity</label>
                                                        <input type="number" class="form-control" id="capacity<%= room.getRoomId() %>" name="capacity" value="<%= room.getCapacity() %>" min="1" required>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="pricePerHour<%= room.getRoomId() %>" class="form-label">Price Per Hour</label>
                                                        <div class="input-group">
                                                            <span class="input-group-text">$</span>
                                                            <input type="number" class="form-control" id="pricePerHour<%= room.getRoomId() %>" name="pricePerHour" value="<%= room.getPricePerHour() %>" min="0" step="0.01" required>
                                                        </div>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="description<%= room.getRoomId() %>" class="form-label">Description</label>
                                                        <textarea class="form-control" id="description<%= room.getRoomId() %>" name="description" rows="3"><%= room.getDescription() %></textarea>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="imageUrl<%= room.getRoomId() %>" class="form-label">Image URL</label>
                                                        <input type="text" class="form-control" id="imageUrl<%= room.getRoomId() %>" name="imageUrl" value="<%= room.getImageUrl() != null ? room.getImageUrl() : "" %>">
                                                    </div>
                                                    <div class="mb-3 form-check">
                                                        <input type="checkbox" class="form-check-input" id="isActive<%= room.getRoomId() %>" name="isActive" <%= room.isActive() ? "checked" : "" %>>
                                                        <label class="form-check-label" for="isActive<%= room.getRoomId() %>">Active</label>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Delete Room Modal -->
                                <div class="modal fade" id="deleteRoomModal<%= room.getRoomId() %>" tabindex="-1" aria-labelledby="deleteRoomModalLabel<%= room.getRoomId() %>" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="deleteRoomModalLabel<%= room.getRoomId() %>">Confirm Delete</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                Are you sure you want to delete the room "<%= room.getRoomName() %>"? This action cannot be undone.
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                <a href="room-process.jsp?action=delete&roomId=<%= room.getRoomId() %>" class="btn btn-danger">Delete</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Add Room Modal -->
    <div class="modal fade" id="addRoomModal" tabindex="-1" aria-labelledby="addRoomModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addRoomModalLabel">Add New Room</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="room-process.jsp" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="add">
                        
                        <div class="mb-3">
                            <label for="roomName" class="form-label">Room Name</label>
                            <input type="text" class="form-control" id="roomName" name="roomName" required>
                        </div>
                        <div class="mb-3">
                            <label for="roomType" class="form-label">Room Type</label>
                            <select class="form-select" id="roomType" name="roomType" required>
                                <option value="Conference">Conference</option>
                                <option value="Meeting">Meeting</option>
                                <option value="Study">Study</option>
                                <option value="Presentation">Presentation</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="capacity" class="form-label">Capacity</label>
                            <input type="number" class="form-control" id="capacity" name="capacity" min="1" required>
                        </div>
                        <div class="mb-3">
                            <label for="pricePerHour" class="form-label">Price Per Hour</label>
                            <div class="input-group">
                                <span class="input-group-text">$</span>
                                <input type="number" class="form-control" id="pricePerHour" name="pricePerHour" min="0" step="0.01" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="imageUrl" class="form-label">Image URL</label>
                            <input type="text" class="form-control" id="imageUrl" name="imageUrl">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Add Room</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <jsp:include page="../includes/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/script.js"></script>
</body>
</html>
