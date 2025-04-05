<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
	int id = Integer.parseInt(request.getParameter("id"));
	String name = request.getParameter("name");
	double price = Double.parseDouble(request.getParameter("price"));
	String brand = request.getParameter("brand");
	String ram = request.getParameter("ram");
	String manufacture_date = request.getParameter("manufacture_date");
	String description = request.getParameter("description"); // New field
	
	try {
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mobileshopfinal", "root", "root");
	    PreparedStatement ps = con.prepareStatement("UPDATE mobiles SET name=?, price=?, brand=?, ram=?, manufacture_date=?, description=? WHERE id=?");
	    
	    ps.setString(1, name);
	    ps.setDouble(2, price);
	    ps.setString(3, brand);
	    ps.setString(4, ram);
	    ps.setString(5, manufacture_date);
	    ps.setString(6, description); // Set the description field
	    ps.setInt(7, id);
	    
	    int rowsUpdated = ps.executeUpdate();
	    con.close();
		
        
        if (rowsUpdated > 0) {
            response.sendRedirect("admindashboard.jsp"); // Redirect back to dashboard
        } else {
            out.println("Error updating product.");
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
