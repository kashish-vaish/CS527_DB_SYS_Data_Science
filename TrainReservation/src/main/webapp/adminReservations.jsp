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
    <a class="navbar-brand" href="#">RU Train System</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
      <ul class="navbar-nav">

        <li class="nav-item dropdown">
          <a class="nav-link active dropdown-toggle" href="#" id="customerRepDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Customer Rep
          </a>
          <ul class="dropdown-menu" aria-labelledby="customerRepDropdown">
            <li><a class="dropdown-item" href="adminHome.jsp">Add</a></li>
            <li><a class="dropdown-item" href="adminEditDelUserFunc.jsp">Edit</a></li>
            <li><a class="dropdown-item" href="adminEditDelUserFunc.jsp">Delete</a></li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="adminSalesReport.jsp">Sales Report</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link active dropdown-toggle" href="#" id="reservationsDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Reservations
          </a>
          <ul class="dropdown-menu" aria-labelledby="reservationsDropdown">
            <li><a class="dropdown-item" href="adminReservations.jsp">By Transit Line</a></li>
            <li><a class="dropdown-item" href="adminReservations.jsp">By Customer Name</a></li>
          </ul>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link active dropdown-toggle" href="#" id="revenueDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Revenue
          </a>
          <ul class="dropdown-menu" aria-labelledby="revenueDropdown">
            <li><a class="dropdown-item" href="adminRevenueReportByTransit.jsp">By Transit Line</a></li>
            <li><a class="dropdown-item" href="adminRevenueReportByCust.jsp">By Customer Name</a></li>
            <li><a class="dropdown-item" href="adminBestCustomer.jsp">Best Customer</a></li>
            <li><a class="dropdown-item" href="adminTopFiveTransit.jsp">Top 5 Transit Lines</a></li>
          </ul>
        </li>
      </ul>
    </div>
    <div class="admin-portal">
      Hi Admin
    </div>
  </div>
</nav>
<div class="container">
    <div class="card">
        <div class="card-body">
            <h3 class="card-title text-center">View Reservations</h3>
            
            <!-- Form to filter reservations -->
            <form method="post">
                <div class="mb-4">
                    <label for="transitLine" class="form-label">Filter by Transit Line</label>
                    <select class="form-select" id="transitLine" name="transitLine">
                        <option value="">-- Select Transit Line --</option>
                        <%
                            try {
                                ApplicationDB db = new ApplicationDB();
                                Connection con = db.getConnection();
                                String query = "SELECT tl_id, tl_name FROM transit_line";
                                PreparedStatement pstmt = con.prepareStatement(query);
                                ResultSet rs = pstmt.executeQuery();

                                while (rs.next()) {
                                    String tlId = rs.getString("tl_id");
                                    String tlName = rs.getString("tl_name");
                                    out.println("<option value='" + tlId + "'>" + tlName + "</option>");
                                }
                                rs.close();
                                pstmt.close();
                                con.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                                out.println("<option value=''>Error fetching transit lines</option>");
                            }
                        %>
                    </select>
                </div>
                <div class="mb-4">
                    <label for="customer" class="form-label">Filter by Customer</label>
                    <select class="form-select" id="customer" name="customer">
                        <option value="">-- Select Customer --</option>
                        <%
                            try {
                                ApplicationDB db = new ApplicationDB();
                                Connection con = db.getConnection();
                                String query = "SELECT username FROM users WHERE role = 'customer'";
                                PreparedStatement pstmt = con.prepareStatement(query);
                                ResultSet rs = pstmt.executeQuery();

                                while (rs.next()) {
                                    String username = rs.getString("username");
                                    out.println("<option value='" + username + "'>" + username + "</option>");
                                }
                                rs.close();
                                pstmt.close();
                                con.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                                out.println("<option value=''>Error fetching customers</option>");
                            }
                        %>
                    </select>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Filter</button>
                </div>
            </form>

            <!-- Display Results -->
            <%
                String selectedTransitLine = request.getParameter("transitLine");
                String selectedCustomer = request.getParameter("customer");

                if (selectedTransitLine != null && !selectedTransitLine.isEmpty()) {
                    // Query reservations by transit line
                    try {
                        ApplicationDB db = new ApplicationDB();
                        Connection con = db.getConnection();

                        String query = 
                            "SELECT r.rid, r.username, r.total_cost, r.date_ticket, s1.name AS origin_name, s2.name AS destination_name " +
                            "FROM reservations r " +
                            "JOIN station s1 ON r.origin = s1.station_id " +
                            "JOIN station s2 ON r.destination = s2.station_id " +
                            "JOIN transit_line tl ON r.origin = tl.origin_station_id AND r.destination = tl.termin_station_id " +
                            "WHERE tl.tl_id = ?";
                        PreparedStatement pstmt = con.prepareStatement(query);
                        pstmt.setString(1, selectedTransitLine);
                        ResultSet rs = pstmt.executeQuery();

                        out.println("<h4 class='mt-4'>Reservations for Transit Line</h4>");
                        out.println("<table class='table table-bordered'>");
                        out.println("<thead><tr><th>Reservation ID</th><th>Username</th><th>Total Cost</th><th>Origin</th><th>Destination</th><th>Date</th></tr></thead>");
                        out.println("<tbody>");
                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getInt("rid") + "</td>");
                            out.println("<td>" + rs.getString("username") + "</td>");
                            out.println("<td>$" + rs.getDouble("total_cost") + "</td>");
                            out.println("<td>" + rs.getString("origin_name") + "</td>");
                            out.println("<td>" + rs.getString("destination_name") + "</td>");
                            out.println("<td>" + rs.getDate("date_ticket") + "</td>");
                            out.println("</tr>");
                        }
                        out.println("</tbody></table>");

                        rs.close();
                        pstmt.close();
                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<div class='mt-4 alert alert-danger'>Error fetching reservations by transit line.</div>");
                    }
                } else if (selectedCustomer != null && !selectedCustomer.isEmpty()) {
                    // Query reservations by customer name
                    try {
                        ApplicationDB db = new ApplicationDB();
                        Connection con = db.getConnection();

                        String query = 
                            "SELECT r.rid, r.total_cost, r.date_ticket, s1.name AS origin_name, s2.name AS destination_name " +
                            "FROM reservations r " +
                            "JOIN station s1 ON r.origin = s1.station_id " +
                            "JOIN station s2 ON r.destination = s2.station_id " +
                            "WHERE r.username = ?";
                        PreparedStatement pstmt = con.prepareStatement(query);
                        pstmt.setString(1, selectedCustomer);
                        ResultSet rs = pstmt.executeQuery();

                        out.println("<h4 class='mt-4'>Reservations for Customer</h4>");
                        out.println("<table class='table table-bordered'>");
                        out.println("<thead><tr><th>Reservation ID</th><th>Total Cost</th><th>Origin</th><th>Destination</th><th>Date</th></tr></thead>");
                        out.println("<tbody>");
                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getInt("rid") + "</td>");
                            out.println("<td>$" + rs.getDouble("total_cost") + "</td>");
                            out.println("<td>" + rs.getString("origin_name") + "</td>");
                            out.println("<td>" + rs.getString("destination_name") + "</td>");
                            out.println("<td>" + rs.getDate("date_ticket") + "</td>");
                            out.println("</tr>");
                        }
                        out.println("</tbody></table>");

                        rs.close();
                        pstmt.close();
                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<div class='mt-4 alert alert-danger'>Error fetching reservations by customer.</div>");
                    }
                }
            %>
        </div>
    </div>
</div>
<footer>&copy; Group 07 Train Reservation System. All Rights Reserved.</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
