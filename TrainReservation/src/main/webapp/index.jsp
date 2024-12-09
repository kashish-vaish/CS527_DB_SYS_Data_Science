<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
    String username = (String) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rutgers Train System</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@400;500&display=swap" rel="stylesheet">

	<link href="css/styles.css" rel="stylesheet">

</head>
<body>

    <%@ include file="header.jsp" %>

    <!-- Feature Section -->
    <div class="container my-5">
        <div class="row text-center">
            <div class="col-md-4">
                <div class="card feature-card">
                    <div class="card-body">
                        <h5 class="card-title">Train Reservations</h5>
                        <p class="card-text">Easily reserve tickets for your next trip.</p>
                        <a href="reserve.jsp" class="btn btn-primary">Reserve Now</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card feature-card">
                    <div class="card-body">
                        <h5 class="card-title">Explore Routes</h5>
                        <p class="card-text">Discover the best routes available for your journey.</p>
                        <a href="routes.jsp" class="btn btn-primary">Explore Routes</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card feature-card">
                    <div class="card-body">
                        <% if (username == null) { %>
                        <h5 class="card-title">Passenger Login</h5>
                        <p class="card-text">Sign in to access your booking history and more.</p>
                        <a href="login.jsp" class="btn btn-primary">Login</a>
                        <% } else { %>
                        <h5 class="card-title">My Bookings</h5>
                        <p class="card-text">View your booking history and manage your reservations.</p>
                        <a href="myBookings.jsp" class="btn btn-primary">View My Bookings</a>
                        <% } %>  
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Include the footer -->
    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>
