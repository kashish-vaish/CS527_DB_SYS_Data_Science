<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rutgers Train System</title>

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

        .card {
            margin-top: 20px;
            margin-bottom: 20px;
        }

        .table th, .table td {
            text-align: center;
        }

        .filter-form {
            padding: 20px;
        }

        .overlay {
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            background: rgba(0, 0, 0, 0.7);
            visibility: visible;
            opacity: 1;
        }

        .popup {
            margin: 70px auto;
            padding: 20px;
            background: #fff;
            border-radius: 5px;
            width: 80%;
            position: relative;
            max-width: 600px;
        }
    </style>
</head>
<body>
    <div class="banner">
        <h1>Rutgers Train System</h1>
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
                        <a class="nav-link" href="logout.jsp">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="card">
            <div class="card-body">
                <h3 class="card-title text-center mb-4">Train Schedule</h3>
                
                <%
                    String personType = (String)session.getAttribute("role");
                    ApplicationDB db = new ApplicationDB();
                    Connection con = db.getConnection();
                    Statement stmt = con.createStatement();

                    ResultSet rs = stmt.executeQuery("SELECT * from station;");
                    ArrayList<String> stations = new ArrayList<String>();
                    while (rs.next()) {
                        stations.add(rs.getString("name"));
                    }
                    
                    rs = stmt.executeQuery("Select username from users where role='customer';");
                    ArrayList<String> users = new ArrayList<String>();
                    while (rs.next()) {
                        users.add(rs.getString("username"));
                    }
                    
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    Date date = new Date();
                    db.closeConnection(con);
                %>

                <div class="filter-form">
                    <form method="get" action="TrainScheduleBackEnd.jsp" class="row g-3 justify-content-center">
                        <div class="col-md-3">
                            <input type="date" class="form-control" id="date" name="date" 
                                min="<%=dateFormat.format(date)%>" 
                                value="<%= session.getAttribute("date") != null ? session.getAttribute("date") : "" %>">
                        </div>
                        <div class="col-md-3">
                            <select name="origin" id="origin" class="form-select">
                                <option disabled <%= session.getAttribute("origin") == null ? "selected" : "" %>>Select Your Origin Station</option>
                                <% for (String s : stations) {
                                    String s_temp = s.replace(" ", "+");
                                    boolean isSelected = session.getAttribute("origin") != null && session.getAttribute("origin").equals(s);
                                %>
                                <option value="<%= s_temp %>" <%= isSelected ? "selected" : "" %>><%= s %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <select name="destination" id="destination" class="form-select">
                                <option disabled <%= session.getAttribute("destination") == null ? "selected" : "" %>>Select Your Destination Station</option>
                                <% for (String s : stations) {
                                    String s_temp = s.replace(" ", "+");
                                    boolean isSelected = session.getAttribute("destination") != null && session.getAttribute("destination").equals(s);
                                %>
                                <option value="<%= s_temp %>" <%= isSelected ? "selected" : "" %>><%= s %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary w-100">Filter</button>
                        </div>
                    </form>
                </div>

                <% if (session.getAttribute("t_error") != null) { %>
                    <div class="alert alert-danger">
                        <%= session.getAttribute("t_error") %>
                        <% session.removeAttribute("t_error"); %>
                    </div>
                <% } else if (session.getAttribute("data") != null) { %>
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Transit Line</th>
                                    <th>Schedule Number</th>
                                    <th>Departure Time</th>
                                    <th>Arrival Time</th>
                                    <th>Start Station</th>
                                    <th>End Station</th>
                                    <th>Travel Time</th>
                                    <th>Cost</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (TrainScheduleObject t: (ArrayList<TrainScheduleObject>)session.getAttribute("data")) { %>
                                    <tr>
                                        <%= t.getData(personType) %>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } %>

                <% if (request.getParameter("fare") != null) { %>
                    <div id="popup1" class="overlay">
                        <div class="popup">
                            <% 
                                session.setAttribute("r_fare", request.getParameter("fare"));
                                session.setAttribute("schedule", request.getParameter("schedule"));
                            %>
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="mb-0">Select Ticket Information</h3>
                                </div>
                                <div class="card-body">
                                    <p><strong>Date:</strong> <%= session.getAttribute("date") %></p>
                                    <p><strong>Train Number:</strong> <%= request.getParameter("schedule") %></p>
                                    <p><strong>Origin:</strong> <%= session.getAttribute("origin") %></p>
                                    <p><strong>Destination:</strong> <%= session.getAttribute("destination") %></p>

                                    <form action=TrainScheduleBackEnd.jsp" class="mt-4">
                                        <% if (!personType.equals("customer")) { %>
                                            <div class="mb-3">
                                                <label class="form-label"><strong>Select User:</strong></label>
                                                <select name="username" class="form-select">
                                                    <% for (String s : users) { %>
                                                        <option value="<%= s %>"><%= s %></option>
                                                    <% } %>
                                                </select>
                                            </div>
                                        <% } %>

                                        <div class="mb-3">
                                            <label class="form-label"><strong>Ticket Type:</strong></label>
                                            <div class="form-check">
                                                <input type="radio" id="one" name="trip" value="One" checked class="form-check-input">
                                                <label class="form-check-label" for="one">One-Way</label>
                                            </div>
                                            <div class="form-check">
                                                <input type="radio" id="two" name="trip" value="Round" class="form-check-input">
                                                <label class="form-check-label" for="two">Round-Trip</label>
                                            </div>
                                            <div class="form-check">
                                                <input type="radio" id="weekly" name="trip" value="Weekly" class="form-check-input">
                                                <label class="form-check-label" for="weekly">Weekly</label>
                                            </div>
                                            <div class="form-check">
                                                <input type="radio" id="monthly" name="trip" value="Monthly" class="form-check-input">
                                                <label class="form-check-label" for="monthly">Monthly</label>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label"><strong>Discount Type:</strong></label>
                                            <div class="form-check">
                                                <input type="radio" id="normal" name="discount" value="Normal" checked class="form-check-input">
                                                <label class="form-check-label" for="normal">Normal</label>
                                            </div>
                                            <div class="form-check">
                                                <input type="radio" id="senior/child" name="discount" value="Senior/Child" class="form-check-input">
                                                <label class="form-check-label" for="senior/child">Senior/Child</label>
                                            </div>
                                            <div class="form-check">
                                                <input type="radio" id="disabled" name="discount" value="Disabled" class="form-check-input">
                                                <label class="form-check-label" for="disabled">Disabled</label>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label"><strong>Class:</strong></label>
                                            <div class="form-check">
                                                <input type="radio" id="Business" name="class" value="Business" checked class="form-check-input">
                                                <label class="form-check-label" for="Business">Business</label>
                                            </div>
                                            <div class="form-check">
                                                <input type="radio" id="First" name="class" value="First" class="form-check-input">
                                                <label class="form-check-label" for="First">First</label>
                                            </div>
                                            <div class="form-check">
                                                <input type="radio" id="Economy" name="class" value="Economy" class="form-check-input">
                                                <label class="form-check-label" for="Economy">Economy</label>
                                            </div>
                                        </div>

                                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                            <button type="submit" class="btn btn-primary me-md-2">Submit</button>
                                            <a href="#" class="btn btn-secondary">Close</a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        </div>
    </div>

    <footer class="text-center py-3">&copy; Group 07 Train Reservation System. All Rights Reserved.</footer>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>