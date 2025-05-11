<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.roomly.dao.RoomDAO" %>
<%@ page import="com.roomly.model.Room" %>
<%@ page import="com.roomly.model.User" %>

<%
    // Check if user is logged in and is admin
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null || !currentUser.isAdmin()) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    // Get action parameter
    String action = request.getParameter("action");
    
    if (action == null) {
        response.sendRedirect("rooms.jsp?error=1");
        return;
    }
    
    RoomDAO roomDAO = new RoomDAO();
    
    if (action.equals("add")) {
        // Add new room
        String roomName = request.getParameter("roomName");
        String roomType = request.getParameter("roomType");
        String capacityStr = request.getParameter("capacity");
        String pricePerHourStr = request.getParameter("pricePerHour");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");
        
        try {
            int capacity = Integer.parseInt(capacityStr);
            double pricePerHour = Double.parseDouble(pricePerHourStr);
            
            Room room = new Room();
            room.setRoomName(roomName);
            room.setRoomType(roomType);
            room.setCapacity(capacity);
            room.setPricePerHour(pricePerHour);
            room.setDescription(description);
            room.setImageUrl(imageUrl);
            room.setActive(true);
            
            boolean success = roomDAO.addRoom(room);
            
            if (success) {
                response.sendRedirect("rooms.jsp?success=add");
            } else {
                response.sendRedirect("rooms.jsp?error=1");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("rooms.jsp?error=1");
        }
    } else if (action.equals("update")) {
        // Update existing room
        String roomIdStr = request.getParameter("roomId");
        String roomName = request.getParameter("roomName");
        String roomType = request.getParameter("roomType");
        String capacityStr = request.getParameter("capacity");
        String pricePerHourStr = request.getParameter("pricePerHour");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");
        String isActiveStr = request.getParameter("isActive");
        
        try {
            int roomId = Integer.parseInt(roomIdStr);
            int capacity = Integer.parseInt(capacityStr);
            double pricePerHour = Double.parseDouble(pricePerHourStr);
            boolean isActive = isActiveStr != null;
            
            Room room = new Room();
            room.setRoomId(roomId);
            room.setRoomName(roomName);
            room.setRoomType(roomType);
            room.setCapacity(capacity);
            room.setPricePerHour(pricePerHour);
            room.setDescription(description);
            room.setImageUrl(imageUrl);
            room.setActive(isActive);
            
            boolean success = roomDAO.updateRoom(room);
            
            if (success) {
                response.sendRedirect("rooms.jsp?success=update");
            } else {
                response.sendRedirect("rooms.jsp?error=1");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("rooms.jsp?error=1");
        }
    } else if (action.equals("delete")) {
        // Delete room (soft delete)
        String roomIdStr = request.getParameter("roomId");
        
        try {
            int roomId = Integer.parseInt(roomIdStr);
            
            boolean success = roomDAO.deleteRoom(roomId);
            
            if (success) {
                response.sendRedirect("rooms.jsp?success=delete");
            } else {
                response.sendRedirect("rooms.jsp?error=1");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("rooms.jsp?error=1");
        }
    } else {
        response.sendRedirect("rooms.jsp?error=1");
    }
%>
