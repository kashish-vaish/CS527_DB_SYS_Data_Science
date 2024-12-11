<%@ page language="java" contentType="text/html; charset=UTF-8"     pageEncoding="UTF-8" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %><!DOCTYPE html>

<%

    String referer = (String) session.getAttribute("referer");
String refererroute = (String) session.getAttribute("refererroute");
%>
<html>
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
    </nav><body>
	<%
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
	String origin = (String) session.getAttribute("origin");
	String dest = (String) session.getAttribute("destination");
	String transitLine = (String) request.getParameter("transit");
	String scheduleNum = (String) request.getParameter("num");
	String statement = "Select s1.name start, s2.name end, s1.state_name, s1.city_name, s2.state_name twoS, s2.city_name twoC, tsm.departure_time, tsm.arrival_time"
			+" from transit_line_route tr, train_schedule_timings tsm, station s1, station s2" 
			+" where tsm.schedule_num=? and tsm.route_id = tr.route_id and tr.start_station_id = s1.station_id and tr.end_station_id = s2.station_id;";

	PreparedStatement ps = con.prepareStatement(statement);
	ps.setInt(1,Integer.parseInt(scheduleNum));
    ResultSet rs = ps.executeQuery();
    ArrayList<Stations> stationsList = new ArrayList<Stations> ();
	while (rs.next()){
		stationsList.add(new Stations(
				rs.getString("start"),
				rs.getString("state_name"),
				rs.getString("city_name"),
				rs.getString("departure_time"),
				rs.getString("arrival_time"),
				rs.getString("end"),
				rs.getString("twoS"),
				rs.getString("twoC")
				));
	}
	stationsList.add(new Stations(
			stationsList.get(stationsList.size()-1).getEnd(), 
			stationsList.get(stationsList.size()-1).getEState(),
			stationsList.get(stationsList.size()-1).getECity(),
			stationsList.get(stationsList.size()-1).getArrival(),
			"",
			"",
			"",
			""
			));
	db.closeConnection(con);
	%>
	<h3 style="text-align:center"> Station Schedule for <%=transitLine%> #<%=scheduleNum%></h3>
	<div style="display: flex; justify-content:center;" >
	<table style="border: 1px solid black; border-collapse: collapse;" >
		<tr>
		<th style="border: 1px solid black;">Name</th>
		<th style="border: 1px solid black;">State</th>
		<th style="border: 1px solid black;">City</th>
		<th style="border: 1px solid black;">Time</th>
		</tr>
		<% for (Stations t: stationsList){
				%>
				<tr>
				<% if (t.getName().equals(origin) || t.getName().equals(dest)) {%>
				<%= t.getRow(true) %>
				<%} else{ %>
				<%= t.getRow(false) %>
				<%} %>
				</tr>
				<% 
			}
		%>
	</table>
	</div>
	<br>
	<br>
	<div style="display: flex; justify-content:center;" >
	<%
	if (refererroute != null && refererroute.equalsIgnoreCase("/TrainReservation/routes.jsp")) {
	%>
		<button><a href="routes.jsp">Back to Schedules</a></button>
	<%
	} else  {
	%>
		<button><a href="reserve.jsp">Back to Schedules</a></button>
	<% }; %>	
	
	
	</div>
 <!-- Include the footer --> 
    <%@ include file="footer.jsp" %>

    <!-- Bootstrap JS (optional for interactive elements) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>