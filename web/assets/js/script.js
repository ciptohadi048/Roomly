/**
 * Roomly - Room Reservation System
 * Main JavaScript file for client-side functionality
 */

document.addEventListener("DOMContentLoaded", () => {
  // Initialize Bootstrap tooltips
  var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
  var tooltipList = tooltipTriggerList.map((tooltipTriggerEl) => new bootstrap.Tooltip(tooltipTriggerEl));

  // Room booking form calculations
  initBookingCalculator();

  // Form validations
  initFormValidations();

  // Payment method toggle
  initPaymentMethodToggle();
});

/**
 * Initialize booking calculator for estimating costs
 */
function initBookingCalculator() {
  const bookingDateInput = document.getElementById("bookingDate");
  const startTimeInput = document.getElementById("startTime");
  const endTimeInput = document.getElementById("endTime");
  const estimatedCostInput = document.getElementById("estimatedCost");
  const pricePerHourElement = document.getElementById("pricePerHour");

  if (startTimeInput && endTimeInput && estimatedCostInput && pricePerHourElement) {
    const pricePerHour = Number.parseFloat(pricePerHourElement.value);

    const calculateCost = () => {
      if (startTimeInput.value && endTimeInput.value) {
        const startParts = startTimeInput.value.split(":");
        const endParts = endTimeInput.value.split(":");

        const startMinutes = Number.parseInt(startParts[0]) * 60 + Number.parseInt(startParts[1]);
        const endMinutes = Number.parseInt(endParts[0]) * 60 + Number.parseInt(endParts[1]);

        if (endMinutes > startMinutes) {
          const durationHours = (endMinutes - startMinutes) / 60 ;
          const cost = (durationHours * pricePerHour);
          estimatedCostInput.value = cost.toFixed(2);
        } else {;
          estimatedCostInput.value = "0.00";
        }
      }
    };

    startTimeInput.addEventListener("change", calculateCost);
    endTimeInput.addEventListener("change", calculateCost);
  }
}

/**
 * Initialize form validations
 */
function initFormValidations() {
  // Registration form validation
  const registerForm = document.getElementById("registerForm");
  if (registerForm) {
    registerForm.addEventListener("submit", (event) => {
      const password = document.getElementById("password").value;
      const confirmPassword = document.getElementById("confirmPassword").value;
      const passwordError = document.getElementById("passwordError");

      if (password !== confirmPassword) {
        event.preventDefault();
        passwordError.style.display = "block";
      } else {
        passwordError.style.display = "none";
      }
    });
  }

  // Booking form validation
  const bookingForm = document.getElementById("bookingForm");
  if (bookingForm) {
    bookingForm.addEventListener("submit", (event) => {
      const bookingDate = document.getElementById("bookingDate").value;
      const startTime = document.getElementById("startTime").value;
      const endTime = document.getElementById("endTime").value;

      if (!bookingDate || !startTime || !endTime) {
        event.preventDefault();
        alert("Please fill in all fields.");
        return;
      }

      const startDateTime = new Date(bookingDate + "T" + startTime);
      const endDateTime = new Date(bookingDate + "T" + endTime);

      if (endDateTime <= startDateTime) {
        event.preventDefault();
        alert("End time must be after start time.");
        return;
      }
    });
  }

  // Payment form validation
  const paymentForm = document.getElementById("paymentForm");
  if (paymentForm) {
    paymentForm.addEventListener("submit", (event) => {
      const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;

      if (paymentMethod === "CREDIT_CARD") {
        const cardNumber = document.getElementById("cardNumber").value;
        const expiryDate = document.getElementById("expiryDate").value;
        const cvv = document.getElementById("cvv").value;
        const cardholderName = document.getElementById("cardholderName").value;

        if (!cardNumber || !expiryDate || !cvv || !cardholderName) {
          event.preventDefault();
          alert("Please fill in all credit card details.");
          return;
        }

        // Basic credit card validation
        if (!/^\d{16}$/.test(cardNumber.replace(/\s/g, ""))) {
          event.preventDefault();
          alert("Please enter a valid 16-digit card number.");
          return;
        }

        if (!/^\d{3,4}$/.test(cvv)) {
          event.preventDefault();
          alert("Please enter a valid CVV code.");
          return;
        }

        if (!/^\d{2}\/\d{2}$/.test(expiryDate)) {
          event.preventDefault();
          alert("Please enter a valid expiry date (MM/YY).");
          return;
        }
      }
    });
  }
}

/**
 * Initialize payment method toggle
 */
function initPaymentMethodToggle() {
  const creditCardRadio = document.getElementById("creditCard");
  const paypalRadio = document.getElementById("paypal");
  const creditCardDetails = document.getElementById("creditCardDetails");
  const paypalDetails = document.getElementById("paypalDetails");

  if (creditCardRadio && paypalRadio && creditCardDetails && paypalDetails) {
    creditCardRadio.addEventListener("change", function () {
      if (this.checked) {
        creditCardDetails.style.display = "block";
        paypalDetails.style.display = "none";
      }
    });

    paypalRadio.addEventListener("change", function () {
      if (this.checked) {
        creditCardDetails.style.display = "none";
        paypalDetails.style.display = "block";
      }
    });
  }
}

/**
 * Format credit card number with spaces
 */
function formatCardNumber(input) {
  let value = input.value.replace(/\s+/g, "");
  if (value.length > 0) {
    value = value.match(/.{1,4}/g).join(" ");
  }
  input.value = value;
}

/**
 * Format expiry date with slash
 */
function formatExpiryDate(input) {
  let value = input.value.replace(/\D/g, "");
  if (value.length > 2) {
    value = value.substring(0, 2) + "/" + value.substring(2, 4);
  }
  input.value = value;
}

/**
 * Search rooms with filters
 */
function searchRooms() {
  const keyword = document.getElementById("keyword").value;
  const roomType = document.getElementById("roomType").value;
  const capacity = document.getElementById("capacity").value;

  window.location.href = `rooms.jsp?keyword=${encodeURIComponent(keyword)}&roomType=${encodeURIComponent(roomType)}&capacity=${encodeURIComponent(capacity)}`;
  return false;
}

/**
 * Toggle room availability calendar
 */
function toggleAvailabilityCalendar(roomId) {
  const calendarContainer = document.getElementById(`calendar-${roomId}`);
  if (calendarContainer.style.display === "none") {
    calendarContainer.style.display = "block";
    // Here you would typically load the availability data via AJAX
    // For now, we'll just show a loading message
    calendarContainer.innerHTML = '<div class="text-center p-3">Loading availability data...</div>';
  } else {
    calendarContainer.style.display = "none";
  }
}

/**
 * Confirm booking cancellation
 */
function confirmCancellation(bookingId) {
  if (confirm("Are you sure you want to cancel this booking? This action cannot be undone.")) {
    window.location.href = `cancel-booking.jsp?id=${bookingId}`;
  }
}

/**
 * Preview room image
 */
function previewImage(input) {
  const preview = document.getElementById("imagePreview");
  if (input.files && input.files[0]) {
    const reader = new FileReader();
    reader.onload = (e) => {
      preview.src = e.target.result;
      preview.style.display = "block";
   };
    reader.readAsDataURL(input.files[0]);
  }
}

/**
 * Initialize date picker with disabled dates
 * This would typically be used with a library like flatpickr or bootstrap-datepicker
 */
function initDatePicker(disabledDates) {
  // This is a placeholder for date picker initialization
  // In a real implementation, you would use a library like flatpickr
  console.log("Date picker would be initialized with disabled dates:", disabledDates);
}

function validateRescheduleForm() {
  const bookingDate = document.getElementById("bookingDate").value;
  const startTime = document.getElementById("startTime").value;
  const endTime = document.getElementById("endTime").value;

  if (!bookingDate || !startTime || !endTime) {
    alert("Please fill in all fields.");
    return false;
  }

  const startDateTime = new Date(bookingDate + "T" + startTime);
  const endDateTime = new Date(bookingDate + "T" + endTime);

  if (endDateTime <= startDateTime) {
    alert("End time must be after start time.");
   }
 }
 