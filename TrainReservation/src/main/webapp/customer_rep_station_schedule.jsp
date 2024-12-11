<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.cs527.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Train Schedules by Station</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .form-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .form-container label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }
        .form-container select, .form-container button {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }
        .form-container button {
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
        }
        .form-container button:hover {
            background-color: #0056b3;
        }
        .results-container {
            max-width: 1200px;
            margin: 20px auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table th, table td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }
        table th {
            background-color: #007bff;
            color: white;
        }
        .no-results {
            text-align: center;
            color: red;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <button onclick="window.location.href='customer_rep_dashboard.jsp'" 
            style="background-color: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px;">
        Back to Dashboard
    </button>
    <h1>Train Schedules by Station</h1>

    <div class="form-container">
        <form method="GET">
            <label for="station-id">Select Station:</label>
            <select id="station-id" name="station_id">
                <option value="">All Stations</option>
                <% 
                    try (Connection conn = new ApplicationDB().getConnection();
                         PreparedStatement pstmt = conn.prepareStatement("SELECT station_id, name FROM station ORDER BY name");
                         ResultSet stationRs = pstmt.executeQuery()) {

                        while (stationRs.next()) {
                %>
                            <option value="<%= stationRs.getInt("station_id") %>">
                                <%= stationRs.getString("name") %>
                            </option>
                <% 
                        }
                    } catch (SQLException e) {
                        out.println("<p style='color: red;'>Error loading stations: " + e.getMessage() + "</p>");
                    }
                %>
            </select>

            <label for="direction">Choose Direction:</label>
            <select id="direction" name="direction">
                <option value="">Both</option>
                <option value="origin">Origin</option>
                <option value="destination">Destination</option>
            </select>

            <button type="submit">Search</button>
        </form>
    </div>

    <div class="results-container">
        <% 
            String stationId = request.getParameter("station_id");
            String direction = request.getParameter("direction");

            String query = "SELECT a.schedule_num, a.tl_id, tl.tl_name, a.train_id, " +
                           "s1.name AS start_station, s2.name AS end_station, " +
                           "t.departure_time, t.arrival_time " +
                           "FROM train_schedule_assignment a " +
                           "JOIN train_schedule_timings t ON a.schedule_num = t.schedule_num " +
                           "JOIN transit_line_route r ON t.route_id = r.route_id " +
                           "JOIN transit_line tl ON a.tl_id = tl.tl_id " +
                           "JOIN station s1 ON r.start_station_id = s1.station_id " +
                           "JOIN station s2 ON r.end_station_id = s2.station_id ";

            boolean hasCondition = false;

            if (stationId != null && !stationId.isEmpty()) {
                if ("origin".equals(direction)) {
                    query += "WHERE r.start_station_id = ? ";
                    hasCondition = true;
                } else if ("destination".equals(direction)) {
                    query += "WHERE r.end_station_id = ? ";
                    hasCondition = true;
                } else {
                    query += "WHERE (r.start_station_id = ? OR r.end_station_id = ?) ";
                    hasCondition = true;
                }
            }

            query += "ORDER BY t.departure_time";

            try (Connection conn = new ApplicationDB().getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(query)) {

                if (hasCondition) {
                    if ("origin".equals(direction) || "destination".equals(direction)) {
                        pstmt.setInt(1, Integer.parseInt(stationId));
                    } else {
                        pstmt.setInt(1, Integer.parseInt(stationId));
                        pstmt.setInt(2, Integer.parseInt(stationId));
                    }
                }

                try (ResultSet rs = pstmt.executeQuery()) {
                    if (!rs.isBeforeFirst()) {
        %>
                        <div class="no-results">No schedules found for the selected filters.</div>
        <%
                    } else {
        %>
                        <table>
                            <thead>
                                <tr>
                                    <th>Schedule Number</th>
                                    <th>Transit Line ID</th>
                                    <th>Transit Line Name</th>
                                    <th>Train ID</th>
                                    <th>Origin Station</th>
                                    <th>Destination Station</th>
                                    <th>Departure Time</th>
                                    <th>Arrival Time</th>
                                </tr>
                            </thead>
                            <tbody>
        <%
                        while (rs.next()) {
        %>
                                <tr>
                                    <td><%= rs.getInt("schedule_num") %></td>
                                    <td><%= rs.getString("tl_id") %></td>
                                    <td><%= rs.getString("tl_name") %></td>
                                    <td><%= rs.getInt("train_id") %></td>
                                    <td><%= rs.getString("start_station") %></td>
                                    <td><%= rs.getString("end_station") %></td>
                                    <td><%= rs.getTime("departure_time") %></td>
                                    <td><%= rs.getTime("arrival_time") %></td>
                                </tr>
        <%
                        }
        %>
                            </tbody>
                        </table>
        <%
                    }
                }
            } catch (SQLException e) {
                out.println("<p style='color: red;'>Error retrieving schedules: " + e.getMessage() + "</p>");
            }
        %>
    </div>
</body>
</html>