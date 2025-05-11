<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.roomly.model.User" %>

<%
    // Check if user is logged in
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get success/error messages
    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Roomly</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/profile.css">
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <div class="profile-container">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <div class="profile-card card animate-fadeIn">
                        <div class="profile-header card-header">
                            <h4 class="mb-0"><i class="fas fa-user-circle me-2"></i>My Profile</h4>
                        </div>
                        <div class="profile-body card-body">
                            <% if (success != null) { %>
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="fas fa-check-circle me-2"></i>
                                    <% if (success.equals("profile")) { %>
                                        Profile updated successfully.
                                    <% } else if (success.equals("password")) { %>
                                        Password changed successfully.
                                    <% } %>
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            <% } %>
                            
                            <% if (error != null) { %>
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="fas fa-exclamation-circle me-2"></i>
                                    <% if (error.equals("password")) { %>
                                        Current password is incorrect.
                                    <% } else { %>
                                        An error occurred. Please try again.
                                    <% } %>
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            <% } %>
                            
                            <ul class="nav nav-tabs" id="profileTabs" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link active" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="true">
                                        <i class="fas fa-user me-2"></i>Profile Information
                                    </button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="password-tab" data-bs-toggle="tab" data-bs-target="#password" type="button" role="tab" aria-controls="password" aria-selected="false">
                                        <i class="fas fa-key me-2"></i>Change Password
                                    </button>
                                </li>
                            </ul>
                            
                            <div class="tab-content p-3" id="profileTabsContent">
                                <div class="tab-pane fade show active" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                                    <form action="profile-update.jsp" method="post" class="profile-form">
                                        <div class="row mb-4">
                                            <div class="col-md-6">
                                                <label for="username" class="form-label">Username</label>
                                                <div class="input-group">
                                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                                    <input type="text" class="form-control" id="username" value="<%= currentUser.getUsername() %>" readonly>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <label for="fullName" class="form-label">Full Name</label>
                                                <div class="input-group">
                                                    <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                                                    <input type="text" class="form-control" id="fullName" name="fullName" value="<%= currentUser.getFullName() %>" required>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row mb-4">
                                            <div class="col-md-6">
                                                <label for="email" class="form-label">Email</label>
                                                <div class="input-group">
                                                    <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                                    <input type="email" class="form-control" id="email" name="email" value="<%= currentUser.getEmail() %>" required>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <label for="phone" class="form-label">Phone Number</label>
                                                <div class="input-group">
                                                    <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                                    <input type="tel" class="form-control" id="phone" name="phone" value="<%= currentUser.getPhone() != null ? currentUser.getPhone() : "" %>">
                                                </div>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary profile-btn">Update Profile</button>
                                    </form>
                                </div>
                                
                                <div class="tab-pane fade" id="password" role="tabpanel" aria-labelledby="password-tab">
                                    <form action="password-update.jsp" method="post" onsubmit="return validatePasswordForm()" class="profile-form">
                                        <div class="mb-4">
                                            <label for="currentPassword" class="form-label">Current Password</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                                <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                                            </div>
                                        </div>
                                        <div class="mb-4">
                                            <label for="newPassword" class="form-label">New Password</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-key"></i></span>
                                                <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                                            </div>
                                        </div>
                                        <div class="mb-4">
                                            <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-check-double"></i></span>
                                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                            </div>
                                            <div id="passwordError" class="text-danger mt-1" style="display: none;">
                                                <i class="fas fa-exclamation-circle me-1"></i> Passwords do not match
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary profile-btn">Change Password</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="includes/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function validatePasswordForm() {
            var newPassword = document.getElementById("newPassword").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            var passwordError = document.getElementById("passwordError");
            
            if (newPassword !== confirmPassword) {
                passwordError.style.display = "block";
                return false;
            } else {
                passwordError.style.display = "none";
                return true;
            }
        }
    </script>
</body>
</html>
