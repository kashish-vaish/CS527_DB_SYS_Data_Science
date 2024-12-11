<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.cs527.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Representative - Reservations</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        form {
            margin-bottom: 20px;
            display: flex;
            gap: 20px;
            justify-content: center;
        }
        form select, form input[type="date"], form button {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        form button {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            transition: 0.2s;
        }
        form button:hover {
            background-color: #0056b3;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        th {
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
<button onclick="window.location.href='customer_rep_dashboard.jsp'" style="background-color: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px;">
    Back to Dashboard
</button>
    <div class="container">
        <h1>Reservations by Transit Line and Reserved Date</h1>
        <!-- 筛选表单 -->
        <form method="get">
            <select id="transit_line" name="transit_line">
                <option value="">All Transit Lines</option>
                <option value="NE">Northeast Corridor</option>
                <option value="AC">Atlantic City Line</option>
                <option value="NJC">North Jersey Coast Line</option>
                <option value="PB">Princeton Branch</option>
                <option value="PV">Pascack Valley</option>
                <option value="RV">Raritan Valley Line</option>
            </select>

            <input type="date" id="date_reserved" name="date_reserved">

            <button type="submit">Search</button>
        </form>

        <%
            String transitLine = request.getParameter("transit_line");
            String selectedDate = request.getParameter("date_reserved");

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                ApplicationDB db = new ApplicationDB();
                conn = db.getConnection();

                StringBuilder query = new StringBuilder(
                    "SELECT r.username, u.fname, u.lname, r.total_cost, s1.name as origin, s2.name as destination, " +
                    "r.schedule_num, r.date_reserved, r.date_ticket, tsa.tl_id, tl.tl_name, " +
                    "r.class, r.trip, r.discount " +
                    "FROM reservations r " +
                    "JOIN users u ON r.username = u.username " +
                    "JOIN train_schedule_assignment tsa ON r.schedule_num = tsa.schedule_num " +
                    "JOIN transit_line tl ON tsa.tl_id = tl.tl_id " +
                    "JOIN station s1 ON s1.station_id = r.origin " +
                    "JOIN station s2 ON s2.station_id = r.destination " +
                    "WHERE 1=1 "
                );

                if (transitLine != null && !transitLine.isEmpty()) {
                    query.append("AND tl.tl_id = ? ");
                }
                if (selectedDate != null && !selectedDate.isEmpty()) {
                    query.append("AND DATE(r.date_reserved) = ? ");
                }
                query.append("ORDER BY r.date_reserved DESC");

                pstmt = conn.prepareStatement(query.toString());

                int index = 1;
                if (transitLine != null && !transitLine.isEmpty()) {
                    pstmt.setString(index++, transitLine);
                }
                if (selectedDate != null && !selectedDate.isEmpty()) {
                    pstmt.setString(index++, selectedDate);
                }

                rs = pstmt.executeQuery();

                if (!rs.isBeforeFirst()) {
        %>
                    <div class="no-results">No reservations found for the selected filters.</div>
        <%
                } else {
        %>
                    <table>
                        <thead>
                            <tr>
                                <th>Username</th>
                                <th>First Name</th>
                                <th>Last Name</th>
                                <th>Total Cost</th>
                                <th>Origin</th>
                                <th>Destination</th>
                                <th>Schedule Number</th>
                                <th>Reserved Date</th>
                                <th>Ticket Date</th>
                                <th>Transit Line</th>
                                <th>Transit Line Name</th>
                                <th>Class</th>
                                <th>Trip Type</th>
                                <th>Discount</th>
                            </tr>
                        </thead>
                        <tbody>
        <%
                    while (rs.next()) {
        %>
                            <tr>
                                <td><%= rs.getString("username") %></td>
                                <td><%= rs.getString("fname") %></td>
                                <td><%= rs.getString("lname") %></td>
                                <td><%= rs.getDouble("total_cost") %></td>
                                <td><%= rs.getString("origin") %></td>
                                <td><%= rs.getString("destination") %></td>
                                <td><%= rs.getInt("schedule_num") %></td>
                                <td><%= rs.getDate("date_reserved") %></td>
                                <td><%= rs.getDate("date_ticket") %></td>
                                <td><%= rs.getString("tl_id") %></td>
                                <td><%= rs.getString("tl_name") %></td>
                                <td><%= rs.getString("class") %></td>
                                <td><%= rs.getString("trip") %></td>
                                <td><%= rs.getString("discount") %></td>
                            </tr>
        <%
                    }
        %>
                        </tbody>
                    </table>
        <%
                }
            } catch (SQLException e) {
                out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
            }
        %>
    </div>
</body>
</html>