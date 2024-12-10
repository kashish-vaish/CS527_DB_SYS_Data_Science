<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Portal - Register Customer Representative</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
    body { background-color: #f4f4f9; font-family: 'Arial', sans-serif; }
    .container { margin-top: 50px; }
    .card { box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); border-radius: 8px; margin-top: 20px; }
    .navbar-brand { font-weight: bold; }
    .admin-portal { text-align: right; margin-top: 10px; margin-right: 20px; }
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
            <h3 class="card-title text-center">Edit/Delete Customer Representative</h3>
            <!-- Dropdown to select a user -->
            <form method="post">
                <div class="mb-4">
                    <label for="userSelect" class="form-label">Select Customer Representative</label>
                    <select class="form-select" id="userSelect" name="selectedUser" onchange="this.form.submit()">
                        <option value="">-- Select User --</option>
                        <%
                            try {
                                // Database connection
                                ApplicationDB db = new ApplicationDB();
                                Connection con = db.getConnection();
                                String query = "SELECT username, fname, lname, email, telephone FROM users WHERE role = 'customer_service_rep'";
                                PreparedStatement pstmt = con.prepareStatement(query);
                                ResultSet rs = pstmt.executeQuery();

                                while (rs.next()) {
                                    String username = rs.getString("username");
                                    String fname = rs.getString("fname");
                                    String lname = rs.getString("lname");
                                    String email = rs.getString("email");
                                    String telephone = rs.getString("telephone");
                                    String display = username + " - " + fname + " " + lname + " (" + email + ", " + telephone + ")";
                                    out.println("<option value='" + username + "'>" + display + "</option>");
                                }

                                rs.close();
                                pstmt.close();
                                con.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                                out.println("<option value=''>Error fetching users</option>");
                            }
                        %>
                    </select>
                </div>
            </form>

            <!-- Form to edit selected user -->
            <%
                if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("selectedUser") != null) {
                    String selectedUser = request.getParameter("selectedUser");
                    try {
                    	ApplicationDB db = new ApplicationDB();
                        Connection con = db.getConnection();
                    	String fetchQuery = "SELECT * FROM users WHERE username = ?";
                        PreparedStatement pstmt = con.prepareStatement(fetchQuery);
                        pstmt.setString(1, selectedUser);
                        ResultSet rs = pstmt.executeQuery();

                        if (rs.next()) {
            %>
            <form method="post">
                <input type="hidden" name="username" value="<%= rs.getString("username") %>">
                <div class="mb-4">
                    <label for="fname" class="form-label">First Name</label>
                    <input type="text" class="form-control" id="fname" name="fname" value="<%= rs.getString("fname") %>" required>
                </div>
                <div class="mb-4">
                    <label for="lname" class="form-label">Last Name</label>
                    <input type="text" class="form-control" id="lname" name="lname" value="<%= rs.getString("lname") %>" required>
                </div>
                <div class="mb-4">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="<%= rs.getString("email") %>" required>
                </div>
                <div class="mb-4">
                    <label for="telephone" class="form-label">Telephone</label>
                    <input type="text" class="form-control" id="telephone" name="telephone" value="<%= rs.getString("telephone") %>" required>
                </div>
                <div class="mb-4">
                    <label for="zipcode" class="form-label">Zip Code</label>
                    <input type="text" class="form-control" id="zipcode" name="zipcode" value="<%= rs.getString("zipcode") %>" required>
                </div>
                <div class="mb-4">
                    <label for="city" class="form-label">City</label>
                    <input type="text" class="form-control" id="city" name="city" value="<%= rs.getString("city") %>" required>
                </div>
                <div class="mb-4">
                    <label for="state" class="form-label">State</label>
                    <input type="text" class="form-control" id="state" name="state" value="<%= rs.getString("state") %>" required>
                </div>
                <div class="mb-4">
                    <label for="ssn" class="form-label">SSN</label>
                    <input type="text" class="form-control" id="ssn" name="ssn" value="<%= rs.getString("ssn") %>" required>
                </div>
                <div class="mb-4">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" value="<%= rs.getString("password") %>" required>
                </div>
                <div class="text-center">
                    <button type="submit" name="action" value="edit" class="btn btn-primary">Edit</button>
                    <button type="submit" name="action" value="delete" class="btn btn-danger">Delete</button>
                </div>
                <br><br><br>
            </form>
            <%
                        }
                        rs.close();
                        pstmt.close();
                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<div class='alert alert-danger'>Error fetching user details: " + e.getMessage() + "</div>");
                    }
                }

                if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("action") != null) {
                    String action = request.getParameter("action");
                    String username = request.getParameter("username");
                    try {
                        ApplicationDB db = new ApplicationDB();
                        Connection con = db.getConnection();

                        if ("edit".equalsIgnoreCase(action)) {
                            String updateQuery = "UPDATE users SET fname = ?, lname = ?, email = ?, telephone = ?, zipcode = ?, city = ?, state = ?, ssn = ?, password = ? WHERE username = ?";
                            PreparedStatement pstmt = con.prepareStatement(updateQuery);
                            pstmt.setString(1, request.getParameter("fname"));
                            pstmt.setString(2, request.getParameter("lname"));
                            pstmt.setString(3, request.getParameter("email"));
                            pstmt.setString(4, request.getParameter("telephone"));
                            pstmt.setString(5, request.getParameter("zipcode"));
                            pstmt.setString(6, request.getParameter("city"));
                            pstmt.setString(7, request.getParameter("state"));
                            pstmt.setString(8, request.getParameter("ssn"));
                            pstmt.setString(9, request.getParameter("password"));
                            pstmt.setString(10, username);
                            int result = pstmt.executeUpdate();
                            out.println(result > 0 ? "<div class='alert alert-success'>User updated successfully!</div>" : "<div class='alert alert-danger'>Failed to update user.</div>");
                            pstmt.close();
                        } else if ("delete".equalsIgnoreCase(action)) {
                            String deleteQuery = "DELETE FROM users WHERE username = ?";
                            PreparedStatement pstmt = con.prepareStatement(deleteQuery);
                            pstmt.setString(1, username);
                            int result = pstmt.executeUpdate();
                            out.println(result > 0 ? "<div class='alert alert-success'>User deleted successfully!</div>" : "<div class='alert alert-danger'>Failed to delete user.</div>");
                            pstmt.close();
                        }
                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<div class='alert alert-danger'>An error occurred: " + e.getMessage() + "</div>");
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
