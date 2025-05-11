<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Roomly</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        .error-container {
            background: linear-gradient(135deg, #ff6b6b 0%, #ff8e8e 100%);
            border-radius: 1rem;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-top: 2rem;
            color: white;
        }
        
        .error-icon {
            font-size: 5rem;
            margin-bottom: 1rem;
        }
        
        .error-title {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 1rem;
        }
        
        .error-message {
            font-size: 1.2rem;
            margin-bottom: 2rem;
        }
        
        .btn-back {
            background: white;
            color: #ff6b6b;
            border: none;
            padding: 0.75rem 1.5rem;
            font-weight: bold;
            border-radius: 0.5rem;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .btn-back:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(255, 107, 107, 0.3);
            background: white;
            color: #ff4757;
        }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="error-container text-center">
                    <div class="error-icon">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                    <div class="error-title">Oops! Something went wrong</div>
                    <div class="error-message">
                        <% 
                            String errorMessage = (String) session.getAttribute("errorMessage");
                            if (errorMessage != null && !errorMessage.isEmpty()) {
                                out.println(errorMessage);
                                session.removeAttribute("errorMessage");
                            } else {
                                out.println("An unexpected error occurred. Please try again later.");
                            }
                        %>
                    </div>
                    <a href="index.jsp" class="btn btn-back">
                        <i class="fas fa-home me-2"></i>Return to Home
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="includes/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
