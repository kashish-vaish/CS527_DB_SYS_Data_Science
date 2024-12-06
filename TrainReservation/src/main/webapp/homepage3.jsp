<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Train Reservation System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
    body { background-color: #f4f4f9; font-family: 'Arial', sans-serif; }
    .container { margin-top: 50px; }
    .card { box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); border-radius: 8px; margin-top: 20px; }
    .navbar-brand { font-weight: bold; }
    footer { background-color: #343a40; color: white; padding: 10px 0; position: fixed; width: 100%; bottom: 0; text-align: center; }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Train</a>
    </div>
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
