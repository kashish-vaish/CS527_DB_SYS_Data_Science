<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Group 7</title>
		<!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    
    <style>
        body {
            background: linear-gradient(120deg, #2980b9, #8e44ad);
            height: 100vh;
        }
        
        .login-container {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            padding: 2rem;
            max-width: 400px;
            width: 90%;
            margin: auto;
            position: relative;
            top: 50%;
            transform: translateY(-50%);
        }
        
        .train-icon {
            font-size: 3rem;
            color: #2980b9;
            margin-bottom: 1rem;
        }
        
        .form-control {
            border-radius: 25px;
            padding: 0.75rem 1.5rem;
            margin-bottom: 1rem;
            border: 2px solid #e3e3e3;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: #2980b9;
            box-shadow: 0 0 10px rgba(41, 128, 185, 0.2);
        }
        
        .btn-login {
            border-radius: 25px;
            padding: 0.75rem 2rem;
            font-weight: bold;
            background: linear-gradient(to right, #2980b9, #3498db);
            border: none;
            transition: all 0.3s;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(41, 128, 185, 0.4);
        }
        
        .register-link {
            color: #2980b9;
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .register-link:hover {
            color: #8e44ad;
        }
        
        .input-group-text {
            border-radius: 25px 0 0 25px;
            background: transparent;
            border-right: none;
        }
        
        .input-group .form-control {
            border-radius: 0 25px 25px 0;
            border-left: none;
        }
        
        .alert {
            border-radius: 25px;
            padding: 1rem;
            margin-bottom: 1rem;
        }
    </style>
		
	</head>
	
	<body>
		<center><h1>Login</h1>	  
		<br>
		<form method="post" action="credCheck.jsp">
		<h2>
		<label>Username</label>
		<input type ="textbox" name="username"></h2>
		<br>
		<br>
		<h2>
		<label>Password</label>
		<input type ="password" name="password"></h2>
		<br>
		<br>
		  <input type="submit" value="Submit" />
		  <% if (request.getParameter("error") != null) { %>
                <div class="error-message">
                    Incorrect username/password, Login failed!
                </div>
            <% } %>
		</form>
		<br>
		</center>
		</form>

</body>
</html>