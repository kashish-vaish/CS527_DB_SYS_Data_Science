<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fare and Route Details</title>
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
            <h3 class="card-title text-center">Fare and Route Details</h3>
            <%
                String origin = request.getParameter("origin");
                String destination = request.getParameter("destination");
                if (origin == null || destination == null || origin.isEmpty() || destination.isEmpty()) {
                    out.println("<div class='mt-4 alert alert-warning'>Invalid input. Please select both origin and destination.</div>");
                } else {
                    try {
                        ApplicationDB db = new ApplicationDB();
                        Connection con = db.getConnection();

                        // Query to fetch fare and transit line ID
                        String fareQuery = "SELECT tl_id, fare FROM transit_line WHERE tl_name = ?";
                        PreparedStatement pstmtFare = con.prepareStatement(fareQuery);
                        pstmtFare.setString(1, origin); // Assuming origin corresponds to a transit line
                        ResultSet rsFare = pstmtFare.executeQuery();

                        String tlId = null;
                        double fare = 0;
                        if (rsFare.next()) {
                            tlId = rsFare.getString("tl_id");
                            fare = rsFare.getDouble("fare");

                            out.println("<div class='mt-4 alert alert-info'>");
                            out.println("<h4>Fare for the selected route:</h4>");
                            out.println("<p><strong>Origin:</strong> " + origin + "</p>");
                            out.println("<p><strong>Destination:</strong> " + destination + "</p>");
                            out.println("<p><strong>Fare:</strong> $" + fare + "</p>");
                            out.println("</div>");
                        } else {
                            out.println("<div class='mt-4 alert alert-warning'>No fare data found for the selected route.</div>");
                        }

                        rsFare.close();
                        pstmtFare.close();

                        // Query to fetch route information with station names
                        if (tlId != null) {
                            String routeQuery = 
                                "SELECT r.hop_number, r.direction, " +
                                "s1.name AS start_station_name, s2.name AS end_station_name " +
                                "FROM transit_line_route r " +
                                "JOIN station s1 ON r.start_station_id = s1.station_id " +
                                "JOIN station s2 ON r.end_station_id = s2.station_id " +
                                "WHERE r.tl_id = ? ORDER BY r.hop_number";
                            PreparedStatement pstmtRoute = con.prepareStatement(routeQuery);
                            pstmtRoute.setString(1, tlId);
                            ResultSet rsRoute = pstmtRoute.executeQuery();

                            out.println("<div class='mt-4 alert alert-success'>");
                            out.println("<h4>Route Information:</h4>");
                            out.println("<table class='table table-bordered'>");
                            out.println("<thead><tr><th>Hop</th><th>Direction</th><th>Start Station</th><th>End Station</th></tr></thead>");
                            out.println("<tbody>");

                            while (rsRoute.next()) {
                                int hopNumber = rsRoute.getInt("hop_number");
                                String direction = rsRoute.getString("direction");
                                String startStation = rsRoute.getString("start_station_name");
                                String endStation = rsRoute.getString("end_station_name");

                                out.println("<tr>");
                                out.println("<td>" + hopNumber + "</td>");
                                out.println("<td>" + direction + "</td>");
                                out.println("<td>" + startStation + "</td>");
                                out.println("<td>" + endStation + "</td>");
                                out.println("</tr>");
                            }

                            out.println("</tbody>");
                            out.println("</table>");
                            out.println("</div>");

                            rsRoute.close();
                            pstmtRoute.close();
                        }

                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<div class='mt-4 alert alert-danger'>An error occurred while fetching the fare and route details.</div>");
                    }
                }
            %>
            <div class="text-center mt-4">
                <a href="homepage3.jsp" class="btn btn-primary">Go Back</a>
            </div>
        </div>
    </div>
</div>
<footer>&copy; Group 07 Train Reservation System. All Rights Reserved.</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
