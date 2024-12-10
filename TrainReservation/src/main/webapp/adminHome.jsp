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
            <h3 class="card-title text-center">Register Customer Representative</h3>

            <!-- Backend Logic -->
            <%
                if (request.getMethod().equalsIgnoreCase("POST")) {
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    String email = request.getParameter("email");
                    String fname = request.getParameter("fname");
                    String lname = request.getParameter("lname");
                    String telephone = request.getParameter("telephone");
                    String zipcode = request.getParameter("zipcode");
                    String city = request.getParameter("city");
                    String state = request.getParameter("state");
                    String role = "customer_service_rep"; 
                    String ssn = request.getParameter("ssn");

                    try {
                        // Database connection
                        ApplicationDB db = new ApplicationDB();
                        Connection con = db.getConnection();
                        // SQL query
                        String query = "INSERT INTO users (username, password, email, fname, lname, telephone, zipcode, city, state, role, ssn) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        PreparedStatement pstmt = con.prepareStatement(query);
                        pstmt.setString(1, username);
                        pstmt.setString(2, password);
                        pstmt.setString(3, email);
                        pstmt.setString(4, fname);
                        pstmt.setString(5, lname);
                        pstmt.setString(6, telephone);
                        pstmt.setString(7, zipcode);
                        pstmt.setString(8, city);
                        pstmt.setString(9, state);
                        pstmt.setString(10, role);
                        pstmt.setString(11, ssn);

                        int result = pstmt.executeUpdate();

                        if (result > 0) {
                            out.println("<div class='alert alert-success'>User registered successfully!</div>");
                        } else {
                            out.println("<div class='alert alert-danger'>Failed to register the user.</div>");
                        }

                        pstmt.close();
                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<div class='alert alert-danger'>An error occurred: " + e.getMessage() + "</div>");
                    }
                }
            %>

            <!-- Form -->
            <form method="post">
                <div class="mb-4">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="Enter username" required>
                </div>
                <div class="mb-4">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required>
                </div>
                <div class="mb-4">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Enter email address">
                </div>
                <div class="mb-4">
                    <label for="fname" class="form-label">First Name</label>
                    <input type="text" class="form-control" id="fname" name="fname" placeholder="Enter first name">
                </div>
                <div class="mb-4">
                    <label for="lname" class="form-label">Last Name</label>
                    <input type="text" class="form-control" id="lname" name="lname" placeholder="Enter last name">
                </div>
                <div class="mb-4">
                    <label for="telephone" class="form-label">Telephone</label>
                    <input type="text" class="form-control" id="telephone" name="telephone" placeholder="Enter telephone number">
                </div>
                <div class="mb-4">
                    <label for="zipcode" class="form-label">Zip Code</label>
                    <input type="text" class="form-control" id="zipcode" name="zipcode" placeholder="Enter zip code">
                </div>
                <div class="mb-4">
                    <label for="city" class="form-label">City</label>
                    <input type="text" class="form-control" id="city" name="city" placeholder="Enter city">
                </div>
                <div class="mb-4">
                    <label for="state" class="form-label">State</label>
                    <input type="text" class="form-control" id="state" name="state" placeholder="Enter state (2 letters)">
                </div>
                <div class="mb-4">
                    <label for="role" class="form-label">Role</label>
                    <select class="form-select" id="role" name="role" required>
                        <option value="customer_service_rep">Customer Service Representative</option>
                        <option value="customer" disabled>Customer</option>
                        <option value="administrator" disabled>Administrator</option>
                    </select>
                </div>
                <div class="mb-4">
                    <label for="ssn" class="form-label">SSN</label>
                    <input type="text" class="form-control" id="ssn" name="ssn" placeholder="Enter SSN">
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Register</button><br><br><br>
                </div>
            </form>
        </div>
    </div>
</div>
<footer>&copy; Group 07 Train Reservation System. All Rights Reserved.</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>