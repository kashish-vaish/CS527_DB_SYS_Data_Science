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
    </style>
</head>
<body>
 <div class="banner">
        <h1>Rutgers Train System</h1>
    </div>

    <!-- Navigation Menu -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
       <!--      <a class="navbar-brand" href="#">CS527 Group 7</a> -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
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
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">Login</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>


<nav class="navbar navbar-expand-lg navbar-light bg-light">
</nav>
<div class="container">
    <div class="card">
        <div class="card-body">
            <h3 class="card-title text-center">Welcome to the Train Reservation System</h3>
            <form action="fareDisplay.jsp" method="post">
                <div class="mb-4">
                    <label for="origin" class="form-label">Select Origin</label>
                    <select class="form-select" id="origin" name="origin" required>
                        <option value="">Select Origin</option>
                        <% 
                            try {
                                ApplicationDB db = new ApplicationDB();
                                Connection con = db.getConnection();
                                String query = "SELECT tl_name FROM transit_line";
                                PreparedStatement pstmt = con.prepareStatement(query);
                                ResultSet rs = pstmt.executeQuery();
                                while (rs.next()) {
                                    String station = rs.getString("tl_name");
                                    out.println("<option value='" + station + "'>" + station + "</option>");
                                }
                                rs.close();
                                pstmt.close();
                                con.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </select>
                </div>

                <div class="mb-4">
                    <label for="destination" class="form-label">Select Destination</label>
                    <select class="form-select" id="destination" name="destination" required>
                        <option value="">Select Destination</option>
                        <% 
                            try {
                                ApplicationDB db = new ApplicationDB();
                                Connection con = db.getConnection();
                                String query = "SELECT tl_name FROM transit_line";
                                PreparedStatement pstmt = con.prepareStatement(query);
                                ResultSet rs = pstmt.executeQuery();
                                while (rs.next()) {
                                    String station = rs.getString("tl_name");
                                    out.println("<option value='" + station + "'>" + station + "</option>");
                                }
                                rs.close();
                                pstmt.close();
                                con.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </select>
                </div>
                <div class="mb-4">
                    <label for="travelDate" class="form-label">Select Date of Travel</label>
                    <input type="date" class="form-control" id="travelDate" name="travelDate" required>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Submit</button>
                </div>
            </form>
        </div>
    </div>
    <%
        String origin = request.getParameter("origin");
        String destination = request.getParameter("destination");
        if (origin != null && destination != null) {
            try {
                ApplicationDB db = new ApplicationDB();
                Connection con = db.getConnection();
                String fareQuery = "SELECT fare FROM transit_line WHERE tl_name = ?";
                PreparedStatement pstmt = con.prepareStatement(fareQuery);
                pstmt.setString(1, origin);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    double fare = rs.getDouble("fare");
                    out.println("<div class='mt-4 alert alert-info'>Fare: $" + fare + "</div>");
                } else {
                    out.println("<div class='mt-4 alert alert-warning'>No fare information available for the selected route.</div>");
                }
                rs.close();
                pstmt.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='mt-4 alert alert-danger'>An error occurred while retrieving fare information.</div>");
            }
        }
    %>
</div>
<footer>&copy; Group 07 Train Reservation System. All Rights Reserved.</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
