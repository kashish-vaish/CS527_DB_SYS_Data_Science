<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
       .form-group .show-password {
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
       function togglePasswordVisibility(fieldId, iconId) {
           const passwordField = document.getElementById(fieldId);
           const toggleIcon = document.getElementById(iconId);
           if (passwordField.type === 'password') {
               passwordField.type = 'text';
               toggleIcon.classList.remove('fa-eye');
               toggleIcon.classList.add('fa-eye-slash');
           } else {
               passwordField.type = 'password';
               toggleIcon.classList.remove('fa-eye-slash');
               toggleIcon.classList.add('fa-eye');
           }
       }
   </script>
</head>
<body>
   <div class="container">
       <h2>Create Account</h2>
       <form action="registerSuccess.jsp" method="POST">
           <!-- Username -->
           <div class="form-group">
               <label for="username">Username <span class="required">*</span></label>
               <input type="text" id="username" name="username" placeholder="Enter your username" required>
           </div>
           <!-- Password -->
           <div class="form-group">
               <label for="password">Password <span class="required">*</span></label>
               <input type="password" id="password" name="password" placeholder="Enter your password" required>
               <i id="passwordToggleIcon" class="fas fa-eye show-password" onclick="togglePasswordVisibility('password', 'passwordToggleIcon')"></i>
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
   </div>
</body>
</html>






