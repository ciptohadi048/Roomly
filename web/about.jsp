<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Roomly</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="assets/css/about.css">
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <div class="container">
        <section class="about-hero-section">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <div class="about-hero-content">
                        <h1 class="about-hero-title">About Roomly</h1>
                        <p class="about-hero-subtitle">Simplifying room reservations for businesses, educational institutions, and organizations of all sizes.</p>
                        <p class="about-hero-text">Roomly was founded in 2023 with a simple mission: to make room booking hassle-free. We understand the challenges of managing shared spaces, and we've built a solution that streamlines the entire process from browsing available rooms to completing your reservation.</p>
                        <p class="about-hero-text">Our platform helps organizations maximize the use of their spaces while providing users with a seamless booking experience. Whether you're looking for a quiet study room, a conference space for your next big meeting, or an auditorium for a presentation, Roomly makes it easy to find and book the perfect room.</p>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="about-hero-image">
                        <img src="assets/images/about/about.jpg" alt="Modern meeting room" class="img-fluid">
                        <div class="image-shape-1"></div>
                        <div class="image-shape-2"></div>
                    </div>
                </div>
            </div>
        </section>
        
        <section class="mission-section">
            <div class="mission-card">
                <div class="mission-icon">
                    <i class="fas fa-bullseye"></i>
                </div>
                <h2 class="mission-title">Our Mission</h2>
                <p class="mission-text">"To create a world where finding and booking the perfect space is effortless, enabling people to focus on what matters most: their work, studies, and connections."</p>
            </div>
        </section>
        
        <section class="team-section">
            <h2 class="section-title">Our Team</h2>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="team-card">
                        <div class="team-image">
                            <img src="assets/images/PASFT1.jpg" alt="Team member">
                            <div class="team-social">
                                <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                                <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                                <a href="#" class="social-link"><i class="fas fa-envelope"></i></a>
                            </div>
                        </div>
                        <div class="team-info">
                            <h3 class="team-name">Cipto Hadi Dwi Nugroho</h3>
                            <p class="team-position">Founder & CEO</p>
                            <p class="team-bio">With over 2 years of experience in property management, Sarah leads our vision and strategy.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="team-card">
                        <div class="team-image">
                            <img src="assets/images/team-2.jpg" alt="Team member">
                            <div class="team-social">
                                <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                                <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                                <a href="#" class="social-link"><i class="fas fa-envelope"></i></a>
                            </div>
                        </div>
                        <div class="team-info">
                            <h3 class="team-name">Michael Chen</h3>
                            <p class="team-position">CTO</p>
                            <p class="team-bio">Michael brings his technical expertise to build and maintain our robust booking platform.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="team-card">
                        <div class="team-image">
                            <img src="assets/images/team-3.jpg" alt="Team member">
                            <div class="team-social">
                                <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                                <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                                <a href="#" class="social-link"><i class="fas fa-envelope"></i></a>
                            </div>
                        </div>
                        <div class="team-info">
                            <h3 class="team-name">Olivia Rodriguez</h3>
                            <p class="team-position">Customer Success Manager</p>
                            <p class="team-bio">Olivia ensures our clients have the best possible experience with Roomly.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <section class="journey-section">
            <h2 class="section-title">Our Journey</h2>
            <div class="timeline">
                <div class="timeline-item">
                    <div class="timeline-dot"></div>
                    <div class="timeline-content">
                        <h3 class="timeline-date">2023</h3>
                        <h4 class="timeline-title">Founded</h4>
                        <p class="timeline-text">Roomly was founded with a vision to revolutionize the room booking experience.</p>
                    </div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-dot"></div>
                    <div class="timeline-content">
                        <h3 class="timeline-date">2023</h3>
                        <h4 class="timeline-title">Beta Launch</h4>
                        <p class="timeline-text">We launched our beta version to a select group of early adopters.</p>
                    </div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-dot"></div>
                    <div class="timeline-content">
                        <h3 class="timeline-date">2024</h3>
                        <h4 class="timeline-title">Official Release</h4>
                        <p class="timeline-text">After incorporating valuable feedback, we officially released Roomly to the public.</p>
                    </div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-dot"></div>
                    <div class="timeline-content">
                        <h3 class="timeline-date">2024</h3>
                        <h4 class="timeline-title">Expanding Globally</h4>
                        <p class="timeline-text">We're now expanding our services to reach customers worldwide.</p>
                    </div>
                </div>
            </div>
        </section>
        
        <section class="features-values-section">
            <div class="row">
                <div class="col-md-6 mb-4">
                    <div class="features-card">
                        <h2 class="card-title">Why Choose Roomly?</h2>
                        <ul class="features-list">
                            <li class="feature-item">
                                <div class="feature-icon">
                                    <i class="fas fa-check-circle"></i>
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">Easy Booking</h4>
                                    <p class="feature-text">Our intuitive interface makes finding and booking rooms simple.</p>
                                </div>
                            </li>
                            <li class="feature-item">
                                <div class="feature-icon">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">Real-time Availability</h4>
                                    <p class="feature-text">See up-to-date room availability instantly.</p>
                                </div>
                            </li>
                            <li class="feature-item">
                                <div class="feature-icon">
                                    <i class="fas fa-shield-alt"></i>
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">Secure Payments</h4>
                                    <p class="feature-text">Our payment system ensures your transactions are safe.</p>
                                </div>
                            </li>
                            <li class="feature-item">
                                <div class="feature-icon">
                                    <i class="fas fa-bell"></i>
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">Instant Confirmations</h4>
                                    <p class="feature-text">Receive immediate booking confirmations.</p>
                                </div>
                            </li>
                            <li class="feature-item">
                                <div class="feature-icon">
                                    <i class="fas fa-headset"></i>
                                </div>
                                <div class="feature-content">
                                    <h4 class="feature-title">24/7 Support</h4>
                                    <p class="feature-text">Our team is always available to assist you.</p>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <div class="values-card">
                        <h2 class="card-title">Our Values</h2>
                        <div class="accordion" id="valuesAccordion">
                            <div class="accordion-item">
                                <h2 class="accordion-header" id="headingOne">
                                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                        <i class="fas fa-lightbulb"></i> Simplicity
                                    </button>
                                </h2>
                                <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#valuesAccordion">
                                    <div class="accordion-body">
                                        We believe in making things simple. Our platform is designed to be intuitive and easy to use, eliminating unnecessary complexity.
                                    </div>
                                </div>
                            </div>
                            <div class="accordion-item">
                                <h2 class="accordion-header" id="headingTwo">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                        <i class="fas fa-handshake"></i> Reliability
                                    </button>
                                </h2>
                                <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#valuesAccordion">
                                    <div class="accordion-body">
                                        You can count on us. We ensure our platform is reliable, your bookings are secure, and our support is always available when you need it.
                                    </div>
                                </div>
                            </div>
                            <div class="accordion-item">
                                <h2 class="accordion-header" id="headingThree">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                        <i class="fas fa-rocket"></i> Innovation
                                    </button>
                                </h2>
                                <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#valuesAccordion">
                                    <div class="accordion-body">
                                        We continuously improve our platform with new features and technologies to provide the best possible experience for our users.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <section class="cta-section">
            <div class="cta-content">
                <h2 class="cta-title">Ready to get started?</h2>
                <p class="cta-text">Join thousands of satisfied customers who use Roomly for their room booking needs.</p>
                <div class="cta-buttons">
                    <a href="rooms.jsp" class="cta-btn primary">Browse Rooms</a>
                    <a href="register.jsp" class="cta-btn secondary">Create an Account</a>
                </div>
            </div>
        </section>
    </div>
    
    <jsp:include page="includes/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/script.js"></script>
</body>
</html>
