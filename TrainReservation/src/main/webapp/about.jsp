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

    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

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

      <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
