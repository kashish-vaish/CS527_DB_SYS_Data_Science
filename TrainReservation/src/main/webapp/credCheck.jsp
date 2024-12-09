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

	        Statement stmt = con.createStatement();
	        ResultSet rs = stmt.executeQuery("select * from users where username='" + user + "' and password='" + pass + "'");

	        
	        if (rs.next()) {
           
	             System.out.println("Username: " + rs.getString("username"));
				System.out.println("User's Role: " + rs.getString("role"));
					
					//storing information into session
			        session.setAttribute("user", rs.getString("username"));
			        session.setAttribute("role", rs.getString("role"));
			        
			        ArrayList<String> transitLines = new ArrayList<String>();
			        ArrayList<Integer> scheduleNums = new ArrayList<Integer>();
			        ArrayList<String> startTimes = new ArrayList<String>();
			        
			        ResultSet res = stmt.executeQuery("SELECT t.schedule_num, t.arrival_time, tl.tl_name FROM `train_schedule_timings` t, `reservations` r, `transit_line` tl, `train_schedule_assignment` tsa WHERE tsa.schedule_num = t.schedule_num AND tsa.tl_id = tl.tl_id AND t.schedule_num = r.schedule_num AND r.username='" + session.getAttribute("user") + "' ORDER BY t.arrival_time");
 			        while(res.next()) {
 			        	if(!(scheduleNums.contains(res.getInt("t.schedule_num")) && startTimes.contains(res.getString("t.arrival_time")))) {
 			        		System.out.println("transitLine: " + res.getString("tl.tl_name"));
     			        	transitLines.add(res.getString("tl.tl_name"));
     			        	
     			        	System.out.println("scheduleNum: " + res.getInt("t.schedule_num"));
     			        	scheduleNums.add(res.getInt("t.schedule_num"));
     			        	
     			        	System.out.println("startTimes: " + res.getString("t.arrival_time"));
     			        	startTimes.add(res.getString("t.arrival_time"));
 			        	}
 			        	
 			        }
 			      	
 			        session.setAttribute("transitLinesInit", transitLines);
 			        session.setAttribute("scheduleNumsInit", scheduleNums);
 			        session.setAttribute("startTimesInit", startTimes);
 			       session.setAttribute("user", user);
	                session.setMaxInactiveInterval(30*60); 
	                

	                String referer = (String) session.getAttribute("referer");

	                if (referer != null) {
	                    // If a referer URL exists, redirect the user back to that page (e.g., reserve.jsp)
	                    session.removeAttribute("referer"); // Optionally remove the referer after redirecting
	                    response.sendRedirect(referer);
	                } else {
	                    // If no referer URL exists, redirect to the home page
	                    response.sendRedirect("index.jsp");
	                }


	            
	            
	        } else {

	            response.sendRedirect("login.jsp?error=invalid");
	        }
	        

	        rs.close();
	        stmt.close();
	        con.close();

		} catch (Exception e) {
		}
	%>

</body>
</html>