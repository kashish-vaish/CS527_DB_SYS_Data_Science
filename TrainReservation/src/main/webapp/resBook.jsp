<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, java.text.*, com.cs527.pkg.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page import="java.sql.*" %>

<%
    // Get session attributes that were sent from the previous page
    String origin = (String) session.getAttribute("origin");
    String destination = (String) session.getAttribute("destination");
    String schedule = (String) session.getAttribute("schedule");
    String fare = (String) session.getAttribute("r_fare");
    String ticketType = (String) request.getParameter("trip");  // The selected ticket type
    String discountType = (String) request.getParameter("discount");  // The selected discount type
    String tripClass = (String) request.getParameter("class");
    System.out.println("kv");
    System.out.println(origin);
    
    // Format the current date for display (optional, in case it's needed)
    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    java.util.Date currentDate = new java.util.Date();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservation Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .form-control[readonly] {
            background-color: #f0f0f0; /* Greyed out fields */
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <h3 class="text-center">Booking Reservation</h3>
        
        <!-- Display Reservation Information -->
        <div class="card">
            <div class="card-header">
                <h5>Reservation Details</h5>
            </div>
            <div class="card-body">
                <form action="insertReservation.jsp" method="post">
                    <!-- Date (readonly, from session or default) -->
                    <div class="mb-3">
                        <label for="date" class="form-label">Date</label>
                        <input type="text" class="form-control" id="date" name="date" value="<%= session.getAttribute("date") != null ? session.getAttribute("date") : dateFormat.format(currentDate) %>" readonly>
                    </div>

                    <!-- Origin Station -->
                    <div class="mb-3">
                        <label for="origin" class="form-label">Origin Station</label>
                        <input type="text" class="form-control" id="origin" name="origin" value="<%= origin %>" readonly>
                    </div>

                    <!-- Destination Station -->
                    <div class="mb-3">
                        <label for="destination" class="form-label">Destination Station</label>
                        <input type="text" class="form-control" id="destination" name="destination" value="<%= destination %>" readonly>
                    </div>

                    <!-- Train Schedule Number -->
                    <div class="mb-3">
                        <label for="schedule" class="form-label">Train Schedule Number</label>
                        <input type="text" class="form-control" id="schedule" name="schedule" value="<%= schedule %>" readonly>
                    </div>

                    <!-- Ticket Type -->
                    <div class="mb-3">
                        <label for="ticketType" class="form-label">Ticket Type</label>
                        <input type="text" class="form-control" id="ticketType" name="ticketType" value="<%= ticketType != null ? ticketType : "" %>" readonly>
                    </div>

                    <!-- Discount Type -->
                    <div class="mb-3">
                        <label for="discountType" class="form-label">Discount Type</label>
                        <input type="text" class="form-control" id="discountType" name="discountType" value="<%= discountType != null ? discountType : "" %>" readonly>
                    </div>
					
					  <!-- Class -->
                    <div class="mb-3">
                        <label for="tripClass" class="form-label">Class</label>
                        <input type="text" class="form-control" id="tripClass" name="tripClass" value="<%= tripClass != null ? tripClass : "" %>" readonly>
                    </div>
                    
                    <!-- Fare -->
                    <div class="mb-3">
                        <label for="fare" class="form-label">Fare</label>
                        <input type="text" class="form-control" id="fare" name="fare" value="<%= fare %>" readonly>
                    </div>

                    <!-- Number of Tickets (Editable Field) -->
                    <div class="mb-3">
                        <label for="numTickets" class="form-label">Number of Tickets</label>
                        <input type="number" class="form-control" id="numTickets" name="numTickets" value="1" min="1" required>
                    </div>

                    <!-- Submit Button -->
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <button type="submit" class="btn btn-primary me-md-2">Book Reservation</button>
                        <a href="reserve.jsp" class="btn btn-secondary">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <footer class="text-center py-3">&copy; Group 07 Train Reservation System. All Rights Reserved.</footer>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>
