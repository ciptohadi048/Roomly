<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Roomly</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <div class="container mt-5">
        <h1 class="display-4 mb-4">Contact Us</h1>
        <p class="lead mb-5">We'd love to hear from you. Please fill out the form below or use our contact information to get in touch with us.</p>
        
        <div class="row">
            <div class="col-md-6 mb-5">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">Send us a Message</h4>
                    </div>
                    <div class="card-body">
                        <% 
                            String success = request.getParameter("success");
                            if (success != null && success.equals("1")) {
                        %>
                            <div class="alert alert-success" role="alert">
                                Your message has been sent successfully. We'll get back to you soon!
                            </div>
                        <% } %>
                        
                        <form action="contact-process.jsp" method="post" id="contactForm">
                            <div class="mb-3">
                                <label for="name" class="form-label">Your Name</label>
                                <input type="text" class="form-control" id="name" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email Address</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                            <div class="mb-3">
                                <label for="subject" class="form-label">Subject</label>
                                <input type="text" class="form-control" id="subject" name="subject" required>
                            </div>
                            <div class="mb-3">
                                <label for="message" class="form-label">Message</label>
                                <textarea class="form-control" id="message" name="message" rows="5" required></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">Send Message</button>
                        </form>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6">
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">Contact Information</h4>
                    </div>
                    <div class="card-body">
                        <div class="d-flex mb-4">
                            <div class="flex-shrink-0">
                                <i class="bi bi-geo-alt fs-3 text-primary"></i>
                            </div>
                            <div class="ms-3">
                                <h5>Address</h5>
                                <p class="mb-0">CheeryField<br>Bandung<br>Indonesia</p>
                            </div>
                        </div>
                        
                        <div class="d-flex mb-4">
                            <div class="flex-shrink-0">
                                <i class="bi bi-telephone fs-3 text-primary"></i>
                            </div>
                            <div class="ms-3">
                                <h5>Phone</h5>
                                <p class="mb-0">+6285155222792</p>
                            </div>
                        </div>
                        
                        <div class="d-flex mb-4">
                            <div class="flex-shrink-0">
                                <i class="bi bi-envelope fs-3 text-primary"></i>
                            </div>
                            <div class="ms-3">
                                <h5>Email</h5>
                                <p class="mb-0">info@roomly.com</p>
                                <p class="mb-0">support@roomly.com</p>
                            </div>
                        </div>
                        
                        <div class="d-flex">
                            <div class="flex-shrink-0">
                                <i class="bi bi-clock fs-3 text-primary"></i>
                            </div>
                            <div class="ms-3">
                                <h5>Business Hours</h5>
                                <p class="mb-0">Monday - Friday: 9:00 AM - 6:00 PM</p>
                                <p class="mb-0">Saturday: 10:00 AM - 4:00 PM</p>
                                <p class="mb-0">Sunday: Closed</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">Our Location</h4>
                    </div>
                    <div class="card-body p-0">
                        <div class="ratio ratio-16x9">
                            <iframe src="https://www.google.com/maps/place/Cherry+Field,+Cluster+Celeste/@-6.9741288,107.6385868,17z/data=!3m1!4b1!4m6!3m5!1s0x2e68e9b6981a8fab:0xa8f5334e2eec440a!8m2!3d-6.9741288!4d107.6411617!16s%2Fg%2F11crzq337g?entry=ttu&g_ep=EgoyMDI1MDUwNy4wIKXMDSoASAFQAw%3D%3D"
                                    style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row mt-5">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">Frequently Asked Questions</h4>
                    </div>
                    <div class="card-body">
                        <div class="accordion" id="faqAccordion">
                            <div class="accordion-item">
                                <h2 class="accordion-header" id="faqOne">
                                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#faqCollapseOne" aria-expanded="true" aria-controls="faqCollapseOne">
                                        How do I book a room?
                                    </button>
                                </h2>
                                <div id="faqCollapseOne" class="accordion-collapse collapse show" aria-labelledby="faqOne" data-bs-parent="#faqAccordion">
                                    <div class="accordion-body">
                                        Booking a room is simple! Browse our available rooms, select the one you want, choose your date and time, and complete the payment process. You'll receive an instant confirmation of your booking.
                                    </div>
                                </div>
                            </div>
                            <div class="accordion-item">
                                <h2 class="accordion-header" id="faqTwo">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faqCollapseTwo" aria-expanded="false" aria-controls="faqCollapseTwo">
                                        Can I cancel my booking?
                                    </button>
                                </h2>
                                <div id="faqCollapseTwo" class="accordion-collapse collapse" aria-labelledby="faqTwo" data-bs-parent="#faqAccordion">
                                    <div class="accordion-body">
                                        Yes, you can cancel your booking through your account dashboard. Please note that cancellation policies may vary depending on how close to the booking time you cancel.
                                    </div>
                                </div>
                            </div>
                            <div class="accordion-item">
                                <h2 class="accordion-header" id="faqThree">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faqCollapseThree" aria-expanded="false" aria-controls="faqCollapseThree">
                                        What payment methods do you accept?
                                    </button>
                                </h2>
                                <div id="faqCollapseThree" class="accordion-collapse collapse" aria-labelledby="faqThree" data-bs-parent="#faqAccordion">
                                    <div class="accordion-body">
                                        We accept all major credit cards and PayPal. All payments are processed securely through our payment gateway.
                                    </div>
                                </div>
                            </div>
                            <div class="accordion-item">
                                <h2 class="accordion-header" id="faqFour">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faqCollapseFour" aria-expanded="false" aria-controls="faqCollapseFour">
                                        How far in advance can I book a room?
                                    </button>
                                </h2>
                                <div id="faqCollapseFour" class="accordion-collapse collapse" aria-labelledby="faqFour" data-bs-parent="#faqAccordion">
                                    <div class="accordion-body">
                                        You can book rooms up to 3 months in advance. This allows for better planning while ensuring availability information remains accurate.
                                    </div>
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
    <script src="assets/js/script.js"></script>
</body>
</html>
