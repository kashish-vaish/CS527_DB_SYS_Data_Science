<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.security.MessageDigest"%>
<%@ page import="java.nio.charset.StandardCharsets"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>
	<%
		
		try {

			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			String user = request.getParameter("username");
			String pass = request.getParameter("password");
			
			if (user == null || pass == null || user.trim().isEmpty() || pass.trim().isEmpty()) {
	            response.sendRedirect("login.jsp");
	            return;
	        }
			/* String query = "SELECT password_hash, salt FROM users WHERE username = ?"; */
			String query = "SELECT password FROM users WHERE username = ?";
	        PreparedStatement pstmt = con.prepareStatement(query);
	        pstmt.setString(1, user);
	        
	        ResultSet result = pstmt.executeQuery();
	        
	        if (result.next()) {
/* 	            String storedHash = result.getString("password_hash");
	            String salt = result.getString("salt");
	            

	            String hashedPassword = hashPassword(pass, salt);
	             */
	             String passw = result.getString("password");
	            /* if (hashedPassword.equals(storedHash)) */
	            if(passw.equals(pass))
	            {

	                HttpSession sess = request.getSession();
	                sess.setAttribute("user", user);
	                sess.setMaxInactiveInterval(30*60); 
	                
	                response.sendRedirect("welcome.jsp");
	            } else {
	            	/* response.sendRedirect("error.jsp"); */
	            	response.sendRedirect("login.jsp?error=true");
	                /* response.sendRedirect("login.jsp?error=invalid"); */
	            }
	        } else {

	            response.sendRedirect("login.jsp?error=invalid");
	        }
	        

	        result.close();
	        pstmt.close();
	        con.close();

		} catch (Exception e) {
		}
	%>

</body>
</html>