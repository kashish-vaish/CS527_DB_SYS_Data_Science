<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Create Account</title>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
   <style>
       body {
           font-family: Arial, sans-serif;
           display: flex;
           justify-content: center;
           align-items: center;
           height: 100vh;
           margin: 0;
           background-color: #f8f9fa;
       }
       .container {
           background: #fff;
           border-radius: 8px;
           padding: 30px;
           box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
           width: 400px;
       }
       .container h2 {
           margin-bottom: 20px;
           text-align: center;
       }
       .form-group {
           margin-bottom: 15px;
           position: relative;
       }
       .form-group label {
           display: block;
           font-weight: bold;
           margin-bottom: 5px;
           font-size: 14px;
       }
       .form-group label .required {
           color: red;
           margin-left: 5px;
       }
       .form-group input {
           width: 100%;
           padding: 10px;
           border: 1px solid #ccc;
           border-radius: 4px;
           font-size: 14px;
       }
       .form-group input:focus {
           border-color: #007bff;
           outline: none;
           box-shadow: 0 0 4px rgba(0, 123, 255, 0.25);
       }
       .form-group .toggle-password {
           position: absolute;
           right: 10px;
           top: 50%;
           transform: translateY(-50%);
           cursor: pointer;
           font-size: 16px;
           color: #007bff;
       }
       .btn {
           display: block;
           width: 100%;
           padding: 12px;
           background: #007bff;
           border: none;
           color: white;
           font-size: 16px;
           border-radius: 4px;
           cursor: pointer;
       }
       .btn:hover {
           background: #0056b3;
       }
   </style>
   <script>
       function togglePasswordVisibility() {
           const passwordField = document.getElementById("password");
           const toggleIcon = document.getElementById("togglePasswordIcon");
           if (passwordField.type === "password") {
               passwordField.type = "text";
               toggleIcon.classList.remove("fa-eye");
               toggleIcon.classList.add("fa-eye-slash");
           } else {
               passwordField.type = "password";
               toggleIcon.classList.remove("fa-eye-slash");
               toggleIcon.classList.add("fa-eye");
           }
       }
   </script>
</head>
<body>
   <div class="container">
       <h2>Create Account</h2>
       <form method="POST">
           <!-- Username -->
           <div class="form-group">
               <label for="username">Username <span class="required">*</span></label>
               <input type="text" id="username" name="username" placeholder="Enter your username" required>
           </div>
           <!-- Password -->
           <div class="form-group">
               <label for="password">Password <span class="required">*</span></label>
               <input type="password" id="password" name="password" placeholder="Enter your password" required>
               <i id="togglePasswordIcon" class="fas fa-eye toggle-password" onclick="togglePasswordVisibility()"></i>
           </div>
           <!-- Email -->
           <div class="form-group">
               <label for="email">Email <span class="required">*</span></label>
               <input type="email" id="email" name="email" placeholder="Enter your email" required>
           </div>
           <!-- First Name -->
           <div class="form-group">
               <label for="fname">First Name <span class="required">*</span></label>
               <input type="text" id="fname" name="fname" placeholder="Enter your first name" required>
           </div>
           <!-- Last Name -->
           <div class="form-group">
               <label for="lname">Last Name <span class="required">*</span></label>
               <input type="text" id="lname" name="lname" placeholder="Enter your last name" required>
           </div>
           <!-- Telephone -->
           <div class="form-group">
               <label for="telephone">Telephone <span class="required">*</span></label>
               <input type="tel" id="telephone" name="telephone" placeholder="Enter your telephone number" required>
           </div>
           <!-- Zip Code -->
           <div class="form-group">
               <label for="zipcode">Zip Code <span class="required">*</span></label>
               <input type="text" id="zipcode" name="zipcode" placeholder="Enter your zip code" required>
           </div>
           <!-- City -->
           <div class="form-group">
               <label for="city">City <span class="required">*</span></label>
               <input type="text" id="city" name="city" placeholder="Enter your city" required>
           </div>
           <!-- State -->
           <div class="form-group">
               <label for="state">State <span class="required">*</span></label>
               <input type="text" id="state" name="state" placeholder="Enter your state" required>
           </div>
           <!-- SSN -->
           <div class="form-group">
               <label for="ssn">SSN (Optional)</label>
               <input type="text" id="ssn" name="ssn" placeholder="Enter your SSN (optional)">
           </div>
           <button type="submit" class="btn">Sign Up</button>
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
                   String sql = "INSERT INTO users (username, password, email, fname, lname, telephone, zipcode, city, state, ssn) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
                   pstmt.executeUpdate();

                   // Redirect to success page
                   response.sendRedirect("registerSuccess.jsp");
               } catch (SQLException e) {
                   e.printStackTrace();
                   out.println("<p style='color:red;'>Error: Unable to register user.</p>");
               } finally {
                   if (pstmt != null) pstmt.close();
                   if (conn != null) db.closeConnection(conn);
               }
           }
       %>
   </div>
</body>
</html>

