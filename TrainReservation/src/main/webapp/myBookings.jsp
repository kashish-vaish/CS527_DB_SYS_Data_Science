<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>

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
    <title>My Bookings - Rutgers Train System</title>

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

        .table th, .table td {
            text-align: center;
        }

        .filter-form {
            padding: 20px;
        }
    </style>
</head>
<body>
  <div class="banner">
    <h1>Rutgers Train System</h1>
            <h2>Group 7</h2>
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
                <li class="nav-item">
                    <a class="nav-link" href="myBookings.jsp">My Bookings</a>
                </li>
            </ul>
            <!-- Add a flex container to push the username and logout to the right -->
            <ul class="navbar-nav ms-auto">
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

<div class="container">
    <div class="card">
        <div class="card-body">
            <h3 class="card-title text-center mb-4">My Bookings</h3>

            <!-- Tabs for Current and Past Bookings -->
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item" role="presentation">
                    <a class="nav-link active" id="current-bookings-tab" data-bs-toggle="tab" href="#current-bookings" role="tab" aria-controls="current-bookings" aria-selected="true">Current Bookings</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="past-bookings-tab" data-bs-toggle="tab" href="#past-bookings" role="tab" aria-controls="past-bookings" aria-selected="false">Past Bookings</a>
                </li>
            </ul>
            <div class="tab-content mt-3" id="myTabContent">
                
                <!-- Current Bookings Tab -->
                <div class="tab-pane fade show active" id="current-bookings" role="tabpanel" aria-labelledby="current-bookings-tab">
                    <% 
                        // Fetch current bookings for the logged-in user (future bookings)
                        ApplicationDB db = new ApplicationDB();
                        Connection con = db.getConnection();
                        Statement stmt = con.createStatement();

                        String queryCurrent = "SELECT r.rid, r.username, r.total_cost, s1.name AS origin, s2.name AS destination, r.schedule_num, "
                                                + "r.class, r.date_ticket, r.discount, t.train_id "
                                                + "FROM reservations r, train_schedule_assignment t, station s1, station s2 "
                                                + "WHERE r.schedule_num = t.schedule_num AND r.origin = s1.station_id AND r.destination = s2.station_id "
                                                + "AND username = '" + username + "' AND r.date_ticket >= CURDATE();";
                        ResultSet rsCurrent = stmt.executeQuery(queryCurrent);

                        if (!rsCurrent.next()) {
                            out.println("<div class='alert alert-warning'>You have no current reservations.</div>");
                        } else {
                    %>

                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Reservation ID</th>
                                    <th>Train Number</th>
                                    <th>Origin</th>
                                    <th>Destination</th>
                                    <th>Departure Date</th>
                                    <th>Seat Class</th>
                                    <th>Ticket Type</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    // Loop through all the current bookings
                                    do {
                                        int rid = rsCurrent.getInt("rid");
                                        String trainNumber = rsCurrent.getString("train_id");
                                        String origin = rsCurrent.getString("origin");
                                        String destination = rsCurrent.getString("destination");
                                        String departureDate = rsCurrent.getString("date_ticket");
                                        String seatClass = rsCurrent.getString("class");
                                        String ticketType = rsCurrent.getString("discount");
                                %>
                                <tr>
                                    <td><%= rid %></td>
                                    <td><%= trainNumber %></td>
                                    <td><%= origin %></td>
                                    <td><%= destination %></td>
                                    <td><%= departureDate %></td>
                                    <td><%= seatClass %></td>
                                    <td><%= ticketType %></td>
<td>
    <a href="javascript:void(0);" class="btn btn-danger btn-sm" onclick="confirmCancellation(<%= rid %>)">Cancel</a>
</td>

<script>
    function confirmCancellation(rid) {
        // Show confirmation dialog
        if (confirm("Are you sure you want to cancel this reservation?")) {
            // Redirect to the cancelBooking.jsp page with the reservation ID
            window.location.href = "cancelBooking.jsp?rid=" + rid;
        }
    }
</script>
                                </tr>
                                <% } while (rsCurrent.next()); %>
                            </tbody>
                        </table>
                    </div>
                    <% } %>
                </div>

                <!-- Past Bookings Tab -->
                <div class="tab-pane fade" id="past-bookings" role="tabpanel" aria-labelledby="past-bookings-tab">
                    <% 
                        // Fetch past bookings for the logged-in user (past bookings)
                        String queryPast = "SELECT r.rid, r.username, r.total_cost, s1.name AS origin, s2.name AS destination, r.schedule_num, "
                                           + "r.class, r.date_ticket, r.discount, t.train_id "
                                           + "FROM reservations r, train_schedule_assignment t, station s1, station s2 "
                                           + "WHERE r.schedule_num = t.schedule_num AND r.origin = s1.station_id AND r.destination = s2.station_id "
                                           + "AND username = '" + username + "' AND r.date_ticket < CURDATE();";
                        ResultSet rsPast = stmt.executeQuery(queryPast);

                        if (!rsPast.next()) {
                            out.println("<div class='alert alert-warning'>You have no past reservations.</div>");
                        } else {
                    %>

                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Reservation ID</th>
                                    <th>Train Number</th>
                                    <th>Origin</th>
                                    <th>Destination</th>
                                    <th>Departure Date</th>
                                    <th>Seat Class</th>
                                    <th>Ticket Type</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    // Loop through all the past bookings
                                    do {
                                        int rid = rsPast.getInt("rid");
                                        String trainNumber = rsPast.getString("train_id");
                                        String origin = rsPast.getString("origin");
                                        String destination = rsPast.getString("destination");
                                        String departureDate = rsPast.getString("date_ticket");
                                        String seatClass = rsPast.getString("class");
                                        String ticketType = rsPast.getString("discount");
                                %>
                                <tr>
                                    <td><%= rid %></td>
                                    <td><%= trainNumber %></td>
                                    <td><%= origin %></td>
                                    <td><%= destination %></td>
                                    <td><%= departureDate %></td>
                                    <td><%= seatClass %></td>
                                    <td><%= ticketType %></td>
                                </tr>
                                <% } while (rsPast.next()); %>
                            </tbody>
                        </table>
                    </div>
                    <% } %>
                </div>

            </div>
        </div>
    </div>
</div>

<footer class="text-center py-3">&copy; Group 07 Train Reservation System. All Rights Reserved.</footer>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>
