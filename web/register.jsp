<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Roomly</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/register.css">
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <div class="register-container">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <div class="register-card card animate-fadeIn">
                        <div class="register-header card-header">
                            <h4 class="mb-0"><i class="fas fa-user-plus me-2"></i>Create a New Account</h4>
                        </div>
                        <div class="register-body card-body">
                            <% 
                                String error = request.getParameter("error");
                                if (error != null) {
                                    if (error.equals("1")) {
                            %>
                                <div class="alert alert-danger" role="alert">
                                    <i class="fas fa-exclamation-circle me-2"></i>
                                    Username already exists. Please choose a different username.
                                </div>
                            <% 
                                    } else if (error.equals("2")) {
                            %>
                                <div class="alert alert-danger" role="alert">
                                    <i class="fas fa-exclamation-circle me-2"></i>
                                    Email already exists. Please use a different email address.
                                </div>
                            <% 
                                    }
                                }
                            %>
                            
                            <form action="register-process.jsp" method="post" onsubmit="return validateForm()" class="register-form">
                                <div class="row mb-4">
                                    <div class="col-md-6">
                                        <label for="username" class="form-label">Username</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                                            <input type="text" class="form-control" id="username" name="username" placeholder="Choose a username" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="fullName" class="form-label">Full Name</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                                            <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Enter your full name" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mb-4">
                                    <div class="col-md-6">
                                        <label for="email" class="form-label">Email</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                            <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="phone" class="form-label">Phone Number</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                            <input type="tel" class="form-control" id="phone" name="phone" placeholder="Enter your phone number">
                                        </div>
                                    </div>
                                </div>
                                <div class="row mb-4">
                                    <div class="col-md-6">
                                        <label for="password" class="form-label">Password</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                            <input type="password" class="form-control" id="password" name="password" placeholder="Create a password" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="confirmPassword" class="form-label">Confirm Password</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
                                        </div>
                                        <div id="passwordError" class="text-danger mt-1" style="display: none;">
                                            <i class="fas fa-exclamation-circle me-1"></i> Passwords do not match
                                        </div>
                                    </div>
                                </div>
                                <div class="mb-4 form-check">
                                    <input type="checkbox" class="form-check-input" id="termsAgreement" name="termsAgreement" required>
                                    <label class="form-check-label" for="termsAgreement">I agree to the <a href="terms.jsp" target="_blank">Terms and Conditions</a></label>
                                </div>
                                <button type="submit" class="btn btn-primary register-btn w-100">Register</button>
                            </form>
                            
                            <div class="register-footer mt-4 text-center">
                                <p>Already have an account? <a href="login.jsp">Login here</a></p>
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
        function validateForm() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            var passwordError = document.getElementById("passwordError");
            
            if (password !== confirmPassword) {
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
