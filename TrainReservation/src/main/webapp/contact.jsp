<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
    String username = (String) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rutgers Train System</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@400;500&display=swap" rel="stylesheet">
	
	<link href="css/styles.css" rel="stylesheet">

</head>
<body>
       <%@ include file="header.jsp" %>
   <div class="container my-5">
    <div class="row text-center">
        <!-- First pair of cards -->
        <div class="col-md-6">
            <div class="card feature-card">
                <div class="card-body">
                    <h5 class="card-title">Kashish Vaish</h5>
                    <p class="card-text">kv401@scarletmail.rutgers.edu</p>
                </div>
            </div>
        </div>
        
        <div class="col-md-6">
            <div class="card feature-card">
                <div class="card-body">
                    <h5 class="card-title">Pranika Massey</h5>
                    <p class="card-text">pranika@scarletmail.rutgers.edu</p>
                </div>
            </div>
        </div>

        <!-- Second pair of cards -->
        <div class="col-md-6">
            <div class="card feature-card">
                <div class="card-body">
                    <h5 class="card-title">Weihao Song</h5>
                    <p class="card-text">ws479@scarletmail.rutgers.edu</p>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card feature-card">
                <div class="card-body">
                    <h5 class="card-title">Ziyu Lin</h5>
                    <p class="card-text">zl711a@scarletmail.rutgers.edu</p>
                </div>
            </div>
        </div>
    </div>
</div>
    <!-- Include the footer -->
    <%@ include file="footer.jsp" %>
</body>
</html>
