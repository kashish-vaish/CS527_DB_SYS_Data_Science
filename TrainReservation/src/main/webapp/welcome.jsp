<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    
    <style>
        body {
            background: linear-gradient(120deg, #2980b9, #8e44ad);
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }
        
        .navbar {
            background: rgba(255, 255, 255, 0.9);
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .welcome-text {
            color: #2980b9;
            font-size: 1.5rem;
            font-weight: bold;
            margin: 0;
        }
        
        .btn-logout {
            background: linear-gradient(to right, #e74c3c, #c0392b);
            color: white;
            border: none;
            padding: 0.5rem 1.5rem;
            border-radius: 25px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .btn-logout:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.4);
            color: white;
        }
        
        .container-fluid {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="container-fluid">
            <span class="welcome-text">
                Welcome, <%= session.getAttribute("user") %>!
            </span>
            <form action="logout.jsp" method="post">
                <button type="submit" class="btn btn-logout">
                    <i class="fas fa-sign-out-alt me-2"></i>Logout
                </button>
            </form>
        </div>
    </nav>
    
    <div class="container mt-5">
		<h2>You're successfully logged in, this is Group 7 submission.</h2>
    </div>
</body>
</html>