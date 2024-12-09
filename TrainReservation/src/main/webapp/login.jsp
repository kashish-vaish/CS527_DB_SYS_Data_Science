<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rutgers Train System</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

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

        /* Form Styling */
        .login-form {
            max-width: 400px;
            margin: 50px auto;
            background-color: #f8f9fa;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .login-form h2 {
            margin-bottom: 20px;
            text-align: center;
        }

        .login-form .form-group {
            margin-bottom: 20px;
        }

        .login-form .btn-primary {
            width: 100%;
        }

        .error-message {
            color: red;
            text-align: center;
            font-weight: bold;
            margin-top: 20px;
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
                </ul>
            </div>
        </div>
    </nav>

    <!-- Login Form Section -->
    <div class="login-form">
        <h2>Login</h2>
        <form method="post" action="credCheck.jsp">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" class="form-control" name="username" id="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" class="form-control" name="password" id="password" required>
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>

            <% if (request.getParameter("error") != null) { %>
                <div class="error-message">
                    Incorrect username/password, Login failed!
                </div>
            <% } %>
        </form>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Group 07 Train Reservation System. All Rights Reserved.</p>
        <p><a href="contact.jsp">Contact Us</a> | <a href="about.jsp">About Us</a></p>
    </footer>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>
