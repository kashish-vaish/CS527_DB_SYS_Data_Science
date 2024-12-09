<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, java.text.*, com.cs527.pkg.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page import="java.sql.*" %>
<%
    // Check if the user is logged in
    String username = (String) session.getAttribute("user");
    if (username == null) {
        // If not logged in, redirect to login page
        String referer = request.getRequestURI(); 
        session.setAttribute("referer", referer);
        response.sendRedirect("login.jsp");
        return;
    }

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rutgers Train System</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .banner {
            background-color: #0056b3;
            color: white;
            padding: 20px;
            text-align: center;
        }
        
        .navbar {
            margin-top: 10px;
        }

        .navbar-nav .nav-link {
            color: #0056b3 !important;
        }

        .navbar-nav .nav-link:hover {
            color: #003366 !important;
        }

        .card {
            margin-top: 20px;
            margin-bottom: 20px;
        }

        .table th, .table td {
            text-align: center;
        }

        .filter-form {
            padding: 20px;
        }

        .overlay {
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            background: rgba(0, 0, 0, 0.7);
            visibility: visible;
            opacity: 1;
        }

        .popup {
            margin: 70px auto;
            padding: 20px;
            background: #fff;
            border-radius: 5px;
            width: 80%;
            position: relative;
            max-width: 600px;
        }
    </style>
</head>
<body>
  <div class="banner">
    <h1>Rutgers Train System</h1>
</div>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="reserve.jsp">Reserve</a>
                </li>
            </ul>
            <!-- Add a flex container to push the username and logout to the right -->
            <ul class="navbar-nav ms-auto"> <!-- ms-auto is equivalent to ml-auto in Bootstrap 5 -->
                <% if (username != null) { %>
                    <li class="nav-item">
                        <span class="nav-link">Welcome, <%= username %>!</span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout.jsp">Logout</a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
  
<%
    // Retrieve form data from resBook.jsp
    String origin = request.getParameter("origin");
    String destination = request.getParameter("destination");
    String schedule = request.getParameter("schedule");
    String fare = request.getParameter("fare");
    String ticketType = request.getParameter("ticketType");
    String discountType = request.getParameter("discountType");
    int numTickets = Integer.parseInt(request.getParameter("numTickets")); 

    // Format the current date for insertion (using today's date as the reserved date)
    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    java.util.Date currentDate = new java.util.Date();
    String dateReserved = dateFormat.format(currentDate);

    // Parse fare from string to int (assuming fare is the price per ticket)
    int fareInt = Integer.parseInt(fare);

    // Retrieve schedule number from the session (assuming it's stored)
    String schNum = schedule;

    // Calculate the total fare by multiplying the fare by the number of tickets
    double totalFare = fareInt * numTickets;

    // Adjust fare based on ticket type (for round trip, monthly, etc.)
    if ("Round".equals(ticketType)) {
        totalFare *= 2;
    } else if ("Monthly".equals(ticketType)) {
        totalFare *= 30; // Assuming a month has 30 days
    } else if ("Weekly".equals(ticketType)) {
        totalFare *= 7; // Assuming a week has 7 days
    }

    // Apply discount based on discount type
    if ("Senior/Child".equals(discountType) || "Disabled".equals(discountType)) {
        totalFare /= 2; // 50% discount
    }

    // Additional charge for first class or business class
    String classType = request.getParameter("tripClass");  // This could be coming from the form as well
    if ("First".equals(classType) || "Business".equals(classType)) {
        totalFare += 5;  // Additional charge
    }

    // Connect to the database and insert reservation
    try {
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        Statement stmt = con.createStatement();

        // Get the station IDs for origin and destination
        int originId = 0;
        int destinationId = 0;
        String getStationQuery = "SELECT s.name, s.station_id FROM station s WHERE s.name = ? OR s.name = ?";
        PreparedStatement getStationStmt = con.prepareStatement(getStationQuery);
        getStationStmt.setString(1, origin);
        getStationStmt.setString(2, destination);
        ResultSet stationResult = getStationStmt.executeQuery();

        while (stationResult.next()) {
            if (origin.equals(stationResult.getString("name"))) {
                originId = stationResult.getInt("station_id");
            } else if (destination.equals(stationResult.getString("name"))) {
                destinationId = stationResult.getInt("station_id");
            }
        }

        // Insert the reservation into the database
        String insertReservationQuery = "INSERT INTO reservations (username, total_cost, origin, destination, schedule_num, class, date_ticket, date_reserved, booking_fee, discount, trip) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement insertStmt = con.prepareStatement(insertReservationQuery);

        insertStmt.setString(1, (String) session.getAttribute("user"));  // Get the username from session
        insertStmt.setDouble(2, totalFare);
        insertStmt.setInt(3, originId);
        insertStmt.setInt(4, destinationId);
        insertStmt.setString(5, schNum);
        insertStmt.setString(6, classType);
        insertStmt.setString(7, dateFormat.format(currentDate));  // Ticket date
        insertStmt.setString(8, dateReserved);  // Reserved date
        insertStmt.setDouble(9, 3.5);  // Booking fee
        insertStmt.setString(10, discountType);
        insertStmt.setString(11, ticketType);
		System.out.println(classType);
        insertStmt.executeUpdate();

        // Close connections
        stmt.close();
        insertStmt.close();
        con.close();
        %>
         <!-- Bootstrap Alert (Centered) -->
        <div class="alert alert-success alert-dismissible fade show text-center" role="alert">
            <strong>Reservation Successful!</strong> Your booking has been confirmed. Thank you for choosing our service!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>

        <!-- Centered Return to Homepage Button -->
        <div class="text-center mt-3">
            <a href="index.jsp" class="btn btn-primary">Return to Homepage</a>
            <a href="myBookings.jsp" class="btn btn-primary">View Reservations</a>
        </div>
   <%
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<h3>Failed to book reservation.</h3>");
    }
%>
