<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.cs527.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Train Schedule</title>
</head>
<body>
	<%
	// Check for stations  equal to each other 
	
	// check if the stations are on the same transit line
	// check direction
	// check route_id
	// query for route_id in schedule timings
	    String referer = (String) session.getAttribute("referer");
	if (request.getParameter("clear") != null && request.getParameter("clear").equals("true")){
		session.removeAttribute("data");
		session.removeAttribute("direction");
		session.removeAttribute("origin");
		session.removeAttribute("destination");
		session.removeAttribute("direction");
		session.removeAttribute("date");
		session.removeAttribute("t_error");
		response.sendRedirect("index.jsp");
	}
	else if (request.getParameter("clear") != null && request.getParameter("clear").equals("manage")){
		session.removeAttribute("data");
		session.removeAttribute("direction");
		session.removeAttribute("origin");
		session.removeAttribute("destination");
		session.removeAttribute("direction");
		session.removeAttribute("date");
		session.removeAttribute("t_error");
		response.sendRedirect("myBookings.jsp");
	}

	else if (request.getParameter("trip") != null){
		session.removeAttribute("data");
		session.removeAttribute("direction");
		session.setAttribute("discount", request.getParameter("discount"));
		session.setAttribute("trip", request.getParameter("trip"));
		session.setAttribute("class", request.getParameter("class"));
		session.setAttribute("username", request.getParameter("username"));
		response.sendRedirect("reserve.jsp");
	}
	else{
	if (request.getParameter("date") == null || request.getParameter("origin") == null || request.getParameter("destination") == null || request.getParameter("date") == "" || request.getParameter("origin") == "" || request.getParameter("destination") == ""){
			session.setAttribute("t_error", "Please select a date, origin, and destination.");
			System.out.println("invalid");
		}
		else{		
        String date = request.getParameter("date");
		String origin = request.getParameter("origin").replace("+", " ");
		String destination = request.getParameter("destination").replace("+", " ");
		/* String sort = request.getParameter("sort"); */
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		String statement = "SELECT distinct tl1.tl_name from transit_line tl1, transit_line_route r, station s"
				+" where tl1.tl_id = r.tl_id and r.start_station_id = s.station_id and s.name= ?"
			+" AND EXISTS ("
			+" SELECT tl2.tl_name"
			+" from transit_line tl2, transit_line_route r, station s"
				+" where tl2.tl_id = r.tl_id and r.start_station_id = s.station_id and s.name=? and tl2.tl_name=tl1.tl_name);";
		PreparedStatement ps = con.prepareStatement(statement);
		ps.setString(1,origin);
		ps.setString(2,destination);
	    ResultSet rs = ps.executeQuery();

	    if (!rs.next()){
	    	session.setAttribute("t_error", "No results found");
	    }
	    else {
	    	String line = rs.getString("tl_name");
	    	if (origin.equals(destination)){
	    		statement = "Select t1.route_id, tl.tl_name, s1.name start, s2.name end, tsm1.departure_time departure, tsm2.arrival_time arrival, ABS(t2.hop_number - t1.hop_number + 1)*tl.fare cost, tsm1.schedule_num, SUBTIME(tsm2.arrival_time, tsm2.departure_time) travel_time from transit_line_route t1, transit_line_route t2, transit_line tl, station s1, station s2, train_schedule_timings tsm1, train_schedule_timings tsm2"
	    				+" where  tl.tl_id = t1.tl_id and tl.tl_id = t2.tl_id and s1.station_id = t1.start_station_id and s2.station_id = t2.end_station_id and tsm1.route_id = t1.route_id and tsm2.route_id = t2.route_id and tsm1.schedule_num = tsm2.schedule_num and"
	    				+ " t1.direction = t2.direction and t2.route_id >= t1.route_id and (s1.name = ? or s2.name = ?);";
	    		ps = con.prepareStatement(statement);
				ps.setString(1,origin);
				ps.setString(2,destination);
			    rs = ps.executeQuery();
	    	}
	    	else {
	    		statement = "select * from transit_line tl, station s1, station s2 where tl.origin_station_id = s1.station_id  and tl.termin_station_id = s2.station_id and s2.name = ? and s1.name= ?;";
	    		ps = con.prepareStatement(statement);
				ps.setString(1,origin);
				ps.setString(2,destination);
			    rs = ps.executeQuery();
				String direction = "";
				if (rs.next()){
					direction = "down";
				}
				else{
					statement = "SELECT min(r.hop_number) min from transit_line_route r, station s, transit_line tl where r.start_station_id = s.station_id and s.name = ? and tl.tl_name = ? and tl.tl_id = r.tl_id";
					ps = con.prepareStatement(statement);
					ps.setString(1,origin);
					ps.setString(2,line);
				    rs = ps.executeQuery();
				    int start = -1;
					if (rs.next()){
						start = rs.getInt("min");
					}
					statement = "SELECT min(r.hop_number) min from transit_line_route r, station s, transit_line tl where r.end_station_id = s.station_id and s.name = ? and tl.tl_name = ? and tl.tl_id = r.tl_id";
					ps = con.prepareStatement(statement);
					ps.setString(1,destination);
					ps.setString(2,line);
				    rs = ps.executeQuery();
				    int end = -1;
					if (rs.next()){
						end = rs.getInt("min");
					}
					if (start <= end){
				
						direction = "up";
					}
					else {
						direction = "down";
					}
				}
				session.setAttribute("direction", direction);
				System.out.println(line);
				System.out.println(origin);
				System.out.println(destination);
				//System.out.println(start);
				//System.out.println(end);
				System.out.println(direction);
				//out.println(direction);
				
				/*statement = "SELECT min(r.hop_number) min from transit_line_route r, station s where r.end_station_id = s.station_id and s.name = ?";
				ps = con.prepareStatement(statement);
				ps.setString(1,origin);
			    rs = ps.executeQuery();*/
			    
			    statement = "select route_id, tl_name, schedule_num, min(departure_time) as departure, max(arrival_time) as arrival, ? start, ? end, SUBTIME(max(arrival_time), min(departure_time)) as travel_time,"
			    		+" min(fare)*(max(hop_number) - min(hop_number)+1) as cost"
			    		 +" from ("
			    		+" SELECT tl.tl_name, r.route_id, ts.schedule_num, t.train_id, "
			    		+" ts.departure_time, ts.arrival_time, tl.fare, r.hop_number from transit_line_route r," 
			    		+" station s1, station s2, train_schedule_timings ts, transit_line tl, train_schedule_assignment ta, train t"
			    		+" where r.start_station_id = s1.station_id and r.end_station_id = s2.station_id and ts.route_id = r.route_id" 
			    		+" and r.tl_id = tl.tl_id and ta.schedule_num = ts.schedule_num and ta.train_id = t.train_id "
			    		+" and (s1.name = ? or s2.name = ?)"
			    		+" and direction = ?"
			    		+" and t.number_of_seats > ( Select count(*) from reservations rr where ta.schedule_num = rr.schedule_num)"
			    		+" and tl.tl_name in ("
			    		+" SELECT distinct tl1.tl_name from transit_line tl1, transit_line_route r, station s where tl1.tl_id = r.tl_id and r.start_station_id = s.station_id and s.name=?"
			    		+" AND EXISTS ("
			    		+" SELECT tl2.tl_name from transit_line tl2, transit_line_route r, station s where tl2.tl_id = r.tl_id and r.start_station_id = s.station_id and s.name=? and tl2.tl_name=tl1.tl_name)"
			    		+" ))a"
			    		+  " group by route_id, tl_name, schedule_num order by min(departure_time), max(arrival_time);";
			
			    		 
			    ps = con.prepareStatement(statement);		 
			    ps.setString(1,origin);
			    ps.setString(2,destination);
			    ps.setString(3,origin);
			    ps.setString(4,destination);
			    ps.setString(5,direction);
			    ps.setString(6,origin);
			    ps.setString(7,destination);
			    rs = ps.executeQuery();
	    	}
			ArrayList<TrainScheduleObject> list = new ArrayList<TrainScheduleObject>();
			while (rs.next()){
				list.add(new TrainScheduleObject(
						rs.getString("tl_name"),
						rs.getInt("schedule_num"),
						rs.getInt("route_id"),
						rs.getString("departure"),
						rs.getString("arrival"),
						rs.getString("start"),
						rs.getString("end"),
						rs.getString("travel_time"),
						rs.getInt("cost")
						)); 

			}
			if (list.size() == 0){
				session.setAttribute("t_error", "No results found");
			}
			else{
				session.setAttribute("data", list);
			}
	    }
			session.setAttribute("origin", origin);
			session.setAttribute("destination", destination);
			session.setAttribute("date", date);
			db.closeConnection(con);
        }
			response.sendRedirect("reserve.jsp");  
	}

	%>
</body>
</html>