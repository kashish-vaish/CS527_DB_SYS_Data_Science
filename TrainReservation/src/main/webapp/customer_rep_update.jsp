<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.cs527.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Train Schedules</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        .btn {
            padding: 10px 20px;
            margin: 5px;
            border: none;
            cursor: pointer;
        }
        .save-btn {
            background-color: #28a745;
            color: white;
        }
        .delete-btn {
            background-color: #dc3545;
            color: white;
        }
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            text-align: center;
        }
        .back-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <!-- Back to Dashboard Button -->
    
<button onclick="window.location.href='customer_rep_dashboard.jsp'" style="background-color: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px;">
    Back to Dashboard
</button>

    <h1>Manage Train Schedules</h1>

    <%
        ApplicationDB db = new ApplicationDB();
        Connection conn = null;
        PreparedStatement pstmt = null;

        // Handle POST actions (Edit/Delete)
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String action = request.getParameter("action");
            try {
                conn = db.getConnection();
                conn.setAutoCommit(false); // Start transaction
                if ("save".equals(action)) {
                    int scheduleNum = Integer.parseInt(request.getParameter("schedule_num"));
                    String tlId = request.getParameter("tl_id");
                    int trainId = Integer.parseInt(request.getParameter("train_id"));
                    int routeId = Integer.parseInt(request.getParameter("route_id"));
                    String departureTime = request.getParameter("departure_time");
                    String arrivalTime = request.getParameter("arrival_time");

                    // Ensure time format is HH:mm:ss
                    if (departureTime != null && !departureTime.contains(":00")) {
                        departureTime += ":00";
                    }
                    if (arrivalTime != null && !arrivalTime.contains(":00")) {
                        arrivalTime += ":00";
                    }

                    // Update train_schedule_assignment
                    String updateAssignment = "UPDATE train_schedule_assignment SET tl_id = ?, train_id = ? WHERE schedule_num = ?";
                    pstmt = conn.prepareStatement(updateAssignment);
                    pstmt.setString(1, tlId);
                    pstmt.setInt(2, trainId);
                    pstmt.setInt(3, scheduleNum);
                    pstmt.executeUpdate();
                    
                    // Update train_schedule_timings
                    String updateTimings = "UPDATE train_schedule_timings SET departure_time = ?, arrival_time = ? WHERE schedule_num = ? AND route_id = ?";
                    pstmt = conn.prepareStatement(updateTimings);
                    pstmt.setTime(1, Time.valueOf(departureTime));
                    pstmt.setTime(2, Time.valueOf(arrivalTime));
                    pstmt.setInt(3, scheduleNum);
                    pstmt.setInt(4, routeId);
                    pstmt.executeUpdate();

                    conn.commit();
                    out.println("<p style='color: green;'>Schedule updated successfully for Schedule Number: " + scheduleNum + "</p>");
                } else if ("delete".equals(action)) {
                    // Deleting a specific row based on schedule_num and route_id
                    int scheduleNum = Integer.parseInt(request.getParameter("schedule_num"));
                    int routeId = Integer.parseInt(request.getParameter("route_id"));

                    // Delete specific row from train_schedule_timings
                    String deleteTimings = "DELETE FROM train_schedule_timings WHERE schedule_num = ? AND route_id = ?";
                    pstmt = conn.prepareStatement(deleteTimings);
                    pstmt.setInt(1, scheduleNum);
                    pstmt.setInt(2, routeId);
                    pstmt.executeUpdate();

                    conn.commit();
                    out.println("<p style='color: green;'>Row deleted successfully for Schedule Number: " + scheduleNum + ", Route ID: " + routeId + "</p>");
                }
            } catch (SQLException e) {
                if (conn != null) conn.rollback();
                out.println("<p style='color: red;'>Error processing request: " + e.getMessage() + "</p>");
            } finally {
                if (pstmt != null) pstmt.close();
                if (conn != null) db.closeConnection(conn);
            }
        }
    %>

    <%
        // Fetch and display train schedule data
        try {
            conn = db.getConnection();
            String query = "SELECT tsa.schedule_num, tsa.tl_id, tsa.train_id, tst.route_id, tst.departure_time, tst.arrival_time " +
                           "FROM train_schedule_assignment tsa " +
                           "JOIN train_schedule_timings tst ON tsa.schedule_num = tst.schedule_num";
            pstmt = conn.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
    %>

    <table>
        <thead>
            <tr>
                <th>Schedule Number</th>
                <th>Transit Line ID</th>
                <th>Train ID</th>
                <th>Route ID</th>
                <th>Departure Time</th>
                <th>Arrival Time</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% while (rs.next()) { %>
            <form method="POST">
                <tr>
                    <td><input type="text" name="schedule_num" value="<%= rs.getInt("schedule_num") %>" readonly></td>
                    <td><input type="text" name="tl_id" value="<%= rs.getString("tl_id") %>"></td>
                    <td><input type="number" name="train_id" value="<%= rs.getInt("train_id") %>"></td>
                    <td><input type="number" name="route_id" value="<%= rs.getInt("route_id") %>" readonly></td>
                    <td><input type="time" name="departure_time" value="<%= rs.getTime("departure_time").toString() %>"></td>
                    <td><input type="time" name="arrival_time" value="<%= rs.getTime("arrival_time").toString() %>"></td>
                    <td>
                        <button type="submit" name="action" value="save" class="btn save-btn">Save</button>
                        <input type="hidden" name="route_id" value="<%= rs.getInt("route_id") %>">
                        <button type="submit" name="action" value="delete" class="btn delete-btn">Delete</button>
                    </td>
                </tr>
            </form>
            <% } %>
        </tbody>
    </table>

    <%
        } catch (SQLException e) {
            out.println("<p>Error fetching train schedules: " + e.getMessage() + "</p>");
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) db.closeConnection(conn);
        }
    %>
</body>
</html>


