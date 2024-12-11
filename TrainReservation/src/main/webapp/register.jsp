<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rutgers Train System</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
    <style>
        /* Form Styling */
        .register-form {
            max-width: 400px;
            margin: 30px auto;
            background-color: #f8f9fa;
            padding: 70px;
            border-radius: 6px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .register-form h2 {
            margin-bottom: 20px;
            text-align: center;
        }

        .register-form .form-group {
            margin-bottom: 20px;
        }

        .register-form .btn-primary {
            width: 100%;
        }

        .error-message {
            color: red;
            text-align: center;
            font-weight: bold;
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <%@ include file="header.jsp" %>
    <!-- Register Form Section -->
    <div class="register-form">
        <h2>Create Account</h2>
        <form method="POST">
            <!-- Username -->
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" class="form-control" id="username" name="username" placeholder="Enter your username" required>
            </div>
            <!-- Password -->
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
            </div>
            <!-- Email -->
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
            </div>
            <!-- First Name -->
            <div class="form-group">
                <label for="fname">First Name</label>
                <input type="text" class="form-control" id="fname" name="fname" placeholder="Enter your first name" required>
            </div>
            <!-- Last Name -->
            <div class="form-group">
                <label for="lname">Last Name</label>
                <input type="text" class="form-control" id="lname" name="lname" placeholder="Enter your last name" required>
            </div>
            <!-- Telephone -->
            <div class="form-group">
                <label for="telephone">Telephone</label>
                <input type="tel" class="form-control" id="telephone" name="telephone" placeholder="Enter your telephone number" required>
            </div>
            <!-- Zip Code -->
            <div class="form-group">
                <label for="zipcode">Zip Code</label>
                <input type="text" class="form-control" id="zipcode" name="zipcode" placeholder="Enter your zip code" required>
            </div>
            <!-- City -->
            <div class="form-group">
                <label for="city">City</label>
                <input type="text" class="form-control" id="city" name="city" placeholder="Enter your city" required>
            </div>
            <!-- State -->
            <div class="form-group">
                <label for="state">State</label>
                <input type="text" class="form-control" id="state" name="state" placeholder="Enter your state" required>
            </div>
            <!-- SSN -->
            <div class="form-group">
                <label for="ssn">SSN (Optional)</label>
                <input type="text" class="form-control" id="ssn" name="ssn" placeholder="Enter your SSN (optional)">
            </div>
            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary">Sign Up</button>
        </form>

        <%
            // Backend handling for registration
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String telephone = request.getParameter("telephone");
            String zipcode = request.getParameter("zipcode");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
            String ssn = request.getParameter("ssn");

            if (username != null && password != null && email != null) {
                ApplicationDB db = new ApplicationDB();
                Connection conn = null;
                PreparedStatement pstmt = null;
                try {
                    conn = db.getConnection();
                    String sql = "INSERT INTO users (username, password, email, fname, lname, telephone, zipcode, city, state, ssn, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, username);
                    pstmt.setString(2, password);
                    pstmt.setString(3, email);
                    pstmt.setString(4, fname);
                    pstmt.setString(5, lname);
                    pstmt.setString(6, telephone);
                    pstmt.setString(7, zipcode);
                    pstmt.setString(8, city);
                    pstmt.setString(9, state);
                    pstmt.setString(10, ssn);
                    pstmt.setString(11,"customer");
                    pstmt.executeUpdate();
                    // Redirect to success page
                    response.sendRedirect("registerSuccess.jsp");
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p class='error-message'>Error: Unable to register user.</p>");
                } finally {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) db.closeConnection(conn);
                }
            }
        %>
    </div>

    <!-- Include the footer --> 
    <%@ include file="footer.jsp" %>
     
    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>
