<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Terms and Conditions - Roomly</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        .terms-container {
            min-height: 100vh;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            padding: 60px 0;
        }
        
        .terms-card {
            border: none;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 40px;
        }
        
        .terms-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
        }
        
        .terms-header {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
            color: white;
            padding: 25px 30px;
            position: relative;
            overflow: hidden;
        }
        
        .terms-header::before {
            content: "";
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.2) 0%, transparent 60%);
            transform: rotate(30deg);
        }
        
        .terms-header h2 {
            font-size: 2rem;
            font-weight: 700;
            margin: 0;
            position: relative;
        }
        
        .terms-body {
            padding: 40px 30px;
            background-color: white;
        }
        
        .terms-section {
            margin-bottom: 30px;
        }
        
        .terms-section h3 {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .terms-section p {
            color: #555;
            line-height: 1.8;
            margin-bottom: 15px;
        }
        
        .terms-section ul {
            margin-bottom: 20px;
        }
        
        .terms-section li {
            margin-bottom: 10px;
            color: #555;
            line-height: 1.6;
        }
        
        .last-updated {
            font-style: italic;
            color: #888;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .terms-card {
            animation: fadeInUp 0.6s ease-out;
        }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <div class="terms-container">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="terms-card card">
                        <div class="terms-header">
                            <h2><i class="fas fa-file-contract me-2"></i>Terms and Conditions</h2>
                        </div>
                        <div class="terms-body">
                            <div class="terms-section">
                                <h3>1. Introduction</h3>
                                <p>Welcome to Roomly. These Terms and Conditions govern your use of our website and services. By accessing or using Roomly, you agree to be bound by these Terms. If you disagree with any part of the terms, you may not access the service.</p>
                            </div>
                            
                            <div class="terms-section">
                                <h3>2. Definitions</h3>
                                <p>For the purposes of these Terms and Conditions:</p>
                                <ul>
                                    <li><strong>"Service"</strong> refers to the Roomly website and room reservation system.</li>
                                    <li><strong>"User"</strong> refers to the individual accessing or using the Service.</li>
                                    <li><strong>"Booking"</strong> refers to the reservation of a room through our Service.</li>
                                    <li><strong>"Content"</strong> refers to text, images, videos, and other material which may appear on our Service.</li>
                                </ul>
                            </div>
                            
                            <div class="terms-section">
                                <h3>3. User Accounts</h3>
                                <p>When you create an account with us, you must provide information that is accurate, complete, and current at all times. Failure to do so constitutes a breach of the Terms, which may result in immediate termination of your account on our Service.</p>
                                <p>You are responsible for safeguarding the password that you use to access the Service and for any activities or actions under your password. You agree not to disclose your password to any third party. You must notify us immediately upon becoming aware of any breach of security or unauthorized use of your account.</p>
                            </div>
                            
                            <div class="terms-section">
                                <h3>4. Bookings and Payments</h3>
                                <p>By making a booking through our Service, you agree to pay the specified amount for the room reservation. Payment must be made through the methods provided on our website.</p>
                                <p>Cancellation and refund policies are as follows:</p>
                                <ul>
                                    <li>Cancellations made more than 48 hours before the scheduled check-in time will receive a full refund.</li>
                                    <li>Cancellations made between 24 and 48 hours before the scheduled check-in time will receive a 50% refund.</li>
                                    <li>Cancellations made less than 24 hours before the scheduled check-in time will not be eligible for a refund.</li>
                                </ul>
                            </div>
                            
                            <div class="terms-section">
                                <h3>5. Rescheduling Policy</h3>
                                <p>Users may reschedule their bookings subject to the following conditions:</p>
                                <ul>
                                    <li>Rescheduling requests must be made at least 24 hours before the original check-in time.</li>
                                    <li>The new booking date must be within 30 days of the original booking date.</li>
                                    <li>A booking can be rescheduled only once.</li>
                                    <li>Rescheduling is subject to room availability for the new date and time.</li>
                                </ul>
                            </div>
                            
                            <div class="terms-section">
                                <h3>6. User Conduct</h3>
                                <p>You agree not to use the Service:</p>
                                <ul>
                                    <li>In any way that violates any applicable national or international law or regulation.</li>
                                    <li>To transmit, or procure the sending of, any advertising or promotional material, including any "junk mail", "chain letter," "spam," or any other similar solicitation.</li>
                                    <li>To impersonate or attempt to impersonate Roomly, a Roomly employee, another user, or any other person or entity.</li>
                                    <li>In any way that infringes upon the rights of others, or in any way is illegal, threatening, fraudulent, or harmful.</li>
                                </ul>
                            </div>
                            
                            <div class="terms-section">
                                <h3>7. Intellectual Property</h3>
                                <p>The Service and its original content (excluding Content provided by users), features, and functionality are and will remain the exclusive property of Roomly and its licensors. The Service is protected by copyright, trademark, and other laws of both the United States and foreign countries. Our trademarks and trade dress may not be used in connection with any product or service without the prior written consent of Roomly.</p>
                            </div>
                            
                            <div class="terms-section">
                                <h3>8. Limitation of Liability</h3>
                                <p>In no event shall Roomly, nor its directors, employees, partners, agents, suppliers, or affiliates, be liable for any indirect, incidental, special, consequential or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses, resulting from:</p>
                                <ul>
                                    <li>Your access to or use of or inability to access or use the Service;</li>
                                    <li>Any conduct or content of any third party on the Service;</li>
                                    <li>Any content obtained from the Service; and</li>
                                    <li>Unauthorized access, use or alteration of your transmissions or content.</li>
                                </ul>
                            </div>
                            
                            <div class="terms-section">
                                <h3>9. Changes to Terms</h3>
                                <p>We reserve the right, at our sole discretion, to modify or replace these Terms at any time. If a revision is material we will try to provide at least 30 days' notice prior to any new terms taking effect. What constitutes a material change will be determined at our sole discretion.</p>
                                <p>By continuing to access or use our Service after those revisions become effective, you agree to be bound by the revised terms. If you do not agree to the new terms, please stop using the Service.</p>
                            </div>
                            
                            <div class="terms-section">
                                <h3>10. Contact Us</h3>
                                <p>If you have any questions about these Terms, please contact us at:</p>
                                <p><i class="fas fa-envelope me-2"></i>Email: support@roomly.com</p>
                                <p><i class="fas fa-phone me-2"></i>Phone: +1 (555) 123-4567</p>
                            </div>
                            
                            <p class="last-updated">Last updated: May 11, 2023</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="includes/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
