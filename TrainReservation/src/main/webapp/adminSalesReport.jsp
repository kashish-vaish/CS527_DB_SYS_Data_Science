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
            <h3 class="card-title text-center">Sales Report</h3>
            <%
                try {
                    ApplicationDB db = new ApplicationDB();
                    Connection con = db.getConnection();

                    // Query to calculate total sales
                    String query = "SELECT SUM(total_cost) AS total_sales FROM reservations";
                    PreparedStatement pstmt = con.prepareStatement(query);
                    ResultSet rs = pstmt.executeQuery();

                    if (rs.next()) {
                        double totalSales = rs.getDouble("total_sales");
                        out.println("<div class='alert alert-info text-center'>");
                        out.println("<h4>Total Sales</h4>");
                        out.println("<p><strong>Total Revenue:</strong> $" + totalSales + "</p>");
                        out.println("</div>");
                    } else {
                        out.println("<div class='alert alert-warning text-center'>No sales data available.</div>");
                    }

                    rs.close();
                    pstmt.close();
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<div class='alert alert-danger text-center'>An error occurred while fetching the sales report.</div>");
                }
            %>
            <div class="text-center mt-4">
                <a href="adminHome.jsp" class="btn btn-primary">Go Back</a>
            </div>
        </div>
    </div>
</div>
<footer>&copy; Group 07 Train Reservation System. All Rights Reserved.</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
