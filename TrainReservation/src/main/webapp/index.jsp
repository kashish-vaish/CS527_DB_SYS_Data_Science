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

    <style>
        /* Custom styles for the banner */
        .banner {
            background-color: #0056b3;
            color: white;
            padding: 50px 0;
            text-align: center;
            background-image: url('https://source.unsplash.com/1600x900/?train,railroad'); /* Example image URL */
            background-size: cover;
            background-position: center;
        }
        
        .banner h1 {
            font-family: 'Roboto', sans-serif;
            font-size: 3rem;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }

        /* Navbar Customization */
        .navbar {
            margin-top: 10px;
        }

        .navbar-nav .nav-link {
            color: #0056b3 !important;
        }

        .navbar-nav .nav-link:hover {
            color: #003366 !important;
        }

        /* Card Styles */
        .feature-card {
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .feature-card .card-body {
            padding: 30px;
            text-align: center;
        }

        .feature-card .card-title {
            font-size: 1.5rem;
            font-weight: bold;
        }

        /* Footer Styles */
        footer {
            background-color: #f8f9fa;
            padding: 20px;
            text-align: center;
            font-size: 0.9rem;
            color: #555;
        }

        footer a {
            color: #0056b3;
            text-decoration: none;
        }

        footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="banner">
        <h1>Rutgers Train System</h1>
        <h2>Group 7</h2>
    </div>

    <!-- Navigation Menu -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="reserve.jsp">Reserve</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">Login</a>
                    </li>
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

    <!-- Feature Section -->
    <div class="container my-5">
        <div class="row text-center">
            <div class="col-md-4">
                <div class="card feature-card">
              <!--       <img src="https://source.unsplash.com/500x300/?train-station" class="card-img-top" alt="Train Station"> -->
                    <div class="card-body">
                        <h5 class="card-title">Train Reservations</h5>
                        <p class="card-text">Easily reserve tickets for your next trip.</p>
                        <a href="reserve.jsp" class="btn btn-primary">Reserve Now</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card feature-card">
               <!--      <img src="https://source.unsplash.com/500x300/?railroad" class="card-img-top" alt="Railroad"> -->
                    <div class="card-body">
                        <h5 class="card-title">Explore Routes</h5>
                        <p class="card-text">Discover the best routes available for your journey.</p>
                        <a href="routes.jsp" class="btn btn-primary">Explore Routes</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card feature-card">
           <!--          <img src="https://source.unsplash.com/500x300/?train-passenger" class="card-img-top" alt="Passenger Train"> -->
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

    <!-- Footer -->
<div class="footer-banner d-flex justify-content-center align-items-center py-4" style="background-color: #0056b3; color: white; position: fixed; bottom: 0; width: 100%; z-index: 10;">
    <div class="text-center">
        <h2>Rutgers Transit</h2>
        <p>Way to Go</p>
    </div>
</div>

<div style="padding-bottom: 50px;"> <!-- Adds space for the fixed footer to not overlap content -->
    <!-- Your page content here -->
</div>
<!-- Footer -->
<footer class="py-3 bg-light mt-5">
    <div class="container text-center">
        <p>&copy; 2024 Group 07 Train Reservation System. All Rights Reserved.</p>
        <p><a href="contact.jsp">Contact Us</a> | <a href="about.jsp">About Us</a></p>
    </div>
</footer>
</body>
</html>
