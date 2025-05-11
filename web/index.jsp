<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Roomly - Room Reservation System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="assets/css/index.css">
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <div class="hero-content">
                        <h1 class="hero-title">Welcome to Roomly</h1>
                        <p class="hero-subtitle">The easiest way to book rooms for your meetings, events, and study sessions.</p>
                        <a href="rooms.jsp" class="hero-btn">Browse Rooms</a>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="hero-image">
                        <img src="assets/images/logo.png" alt="Room booking" class="img-fluid">
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Scroll indicator -->
        <div class="scroll-indicator">
            <i class="fas fa-chevron-down"></i>
            <div class="scroll-text">Scroll to explore</div>
        </div>
    </section>
    
    <div class="container">
        <section class="features-section reveal">
            <h2 class="section-title">Why Choose Roomly</h2>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <h3 class="feature-title">Easy Booking</h3>
                        <p class="feature-text">Browse available rooms and select a time slot that fits your needs with our intuitive booking system.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <h3 class="feature-title">Instant Confirmation</h3>
                        <p class="feature-text">Complete your payment and get instant confirmation for your booking, no waiting required.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-tasks"></i>
                        </div>
                        <h3 class="feature-title">Manage Bookings</h3>
                        <p class="feature-text">View, cancel, or reschedule your bookings with just a few clicks through your personal dashboard.</p>
                    </div>
                </div>
            </div>
        </section>
        
        <section class="popular-rooms-section reveal">
            <h2 class="section-title">Popular Rooms</h2>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="room-card">
                        <div class="room-image">
                            <img src="assets/images/conference.jpg" alt="Conference Room">
                        </div>
                        <div class="room-details">
                            <span class="room-type">Conference</span>
                            <h3 class="room-title">Executive Conference Room</h3>
                            <p class="room-price">$50 <span class="price-period">/ hour</span></p>
                            <div class="room-features">
                                <span class="room-feature"><i class="fas fa-user"></i> 12 People</span>
                                <span class="room-feature"><i class="fas fa-tv"></i> Projector</span>
                                <span class="room-feature"><i class="fas fa-wifi"></i> Wi-Fi</span>
                            </div>
                            <a href="room-details.jsp?id=1" class="btn-view-details">View Details</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="room-card">
                        <div class="room-image">
                            <img src="assets/images/meeting2.jpg" alt="Meeting Room">
                        </div>
                        <div class="room-details">
                            <span class="room-type">Meeting</span>
                            <h3 class="room-title">Collaborative Meeting Room</h3>
                            <p class="room-price">$35 <span class="price-period">/ hour</span></p>
                            <div class="room-features">
                                <span class="room-feature"><i class="fas fa-user"></i> 8 People</span>
                                <span class="room-feature"><i class="fas fa-chalkboard"></i> Whiteboard</span>
                                <span class="room-feature"><i class="fas fa-wifi"></i> Wi-Fi</span>
                            </div>
                            <a href="room-details.jsp?id=2" class="btn-view-details">View Details</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="room-card">
                        <div class="room-image">
                            <img src="assets/images/study.jpg" alt="Study Room">
                        </div>
                        <div class="room-details">
                            <span class="room-type">Study</span>
                            <h3 class="room-title">Quiet Study Room</h3>
                            <p class="room-price">$20 <span class="price-period">/ hour</span></p>
                            <div class="room-features">
                                <span class="room-feature"><i class="fas fa-user"></i> 4 People</span>
                                <span class="room-feature"><i class="fas fa-plug"></i> Power Outlets</span>
                                <span class="room-feature"><i class="fas fa-wifi"></i> Wi-Fi</span>
                            </div>
                            <a href="room-details.jsp?id=3" class="btn-view-details">View Details</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-center mt-4">
                <a href="rooms.jsp" class="btn-view-all">View All Rooms</a>
            </div>
        </section>
        
        <section class="cta-section reveal">
            <div class="cta-content">
                <h2 class="cta-title">Ready to Book Your Perfect Room?</h2>
                <p class="cta-text">Join thousands of satisfied customers who use Roomly for their room booking needs.</p>
                <a href="register.jsp" class="cta-btn">Create an Account</a>
            </div>
        </section>
    </div>
    
    <jsp:include page="includes/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/script.js"></script>
    
    <!-- Add scroll reveal script -->
    <script>
        // Scroll reveal animation
        function revealOnScroll() {
            var reveals = document.querySelectorAll('.reveal');
            
            for (var i = 0; i < reveals.length; i++) {
                var windowHeight = window.innerHeight;
                var elementTop = reveals[i].getBoundingClientRect().top;
                var elementVisible = 150;
                
                if (elementTop < windowHeight - elementVisible) {
                    reveals[i].classList.add('active');
                }
            }
        }
        
        window.addEventListener('scroll', revealOnScroll);
        
        // Trigger once on page load
        window.addEventListener('load', revealOnScroll);
    </script>
</body>
</html>
