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

        /* Member Section */
        .member-img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            margin-bottom: 15px;
        }

        .member-section {
            margin-top: 30px;
        }

        .member-card {
            text-align: center;
            margin-bottom: 30px;
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
    <!-- Banner Section -->
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

    <!-- About Us Section -->
    <div class="container my-5">
        <div class="row text-center">
            <!-- Section Title -->
            <div class="col-12">
                <h2 class="display-4 mb-4" style="color: #0056b3;">About Us</h2>
                <p class="lead">Learn more about our project and the team behind it.</p>
            </div>
        </div>

        <!-- Team Introduction Section -->
        <div class="row member-section">
            <!-- Team Member 1 -->
            <div class="col-md-3 member-card">
                <img src="kv401.jpg" alt="Kashish Vaish" class="member-img">
                <h4>Kashish Vaish</h4>
                <p>kv401@scarletmail.rutgers.edu</p>
            </div>
        
            <!-- Team Member 2 -->
            <div class="col-md-3 member-card">
                <img src="https://via.placeholder.com/150" alt="Pranika Massey" class="member-img">
                <h4>Pranika Massey</h4>
                <p>pranika@scarletmail.rutgers.edu</p>
            </div>

            <!-- Team Member 3 -->
            <div class="col-md-3 member-card">
                <img src="https://via.placeholder.com/150" alt="Weihao Song" class="member-img">
                <h4>Weihao Song</h4>
                <p>ws479@scarletmail.rutgers.edu</p>
            </div>

            <!-- Team Member 4 -->
            <div class="col-md-3 member-card">
                <img src="https://via.placeholder.com/150" alt="Ziyu Lin" class="member-img">
                <h4>Ziyu Lin</h4>
                <p>zl711a@scarletmail.rutgers.edu</p>
            </div>
        </div>

        <!-- Project Description Section -->
        <div class="row text-center">
            <div class="col-12">
                <h3 class="display-5" style="color: #0056b3;">Project Overview</h3>
                <p class="lead mb-4">This website is built as part of the submission by Group 7 for the final project of CS 527 - Database Systems for Data Science. Our goal is to create an efficient and user-friendly train reservation system for the Rutgers community.</p>
                <p class="mb-4">The system allows users to easily reserve tickets, explore routes, and manage bookings. We utilized a variety of technologies and databases to ensure a smooth and intuitive user experience.</p>
            </div>
        </div>
    </div>

    <!-- Footer Banner Section -->
    <div class="footer-banner d-flex justify-content-center align-items-center py-2" style="background-color: #0056b3; color: white; position: fixed; bottom: 0; width: 100%; z-index: 10;">
        <div class="text-center">
            <h2>Rutgers Transit</h2>
            <p>Way to Go</p>
        </div>
    </div>

    <!-- Footer Section -->
    <footer class="py-3 bg-light mt-5">
        <div class="container text-center">
            <p>&copy; 2024 Group 07 Train Reservation System. All Rights Reserved.</p>
            <p><a href="contact.jsp">Contact Us</a> | <a href="about.jsp">About Us</a></p>
        </div>
    </footer>

    <!-- Bootstrap JS (optional for interactive elements) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
