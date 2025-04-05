package com.demo;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
@WebServlet("/DeleteServlet")
public class DeleteServlet extends HttpServlet { 
	private static final long serialVersionUID = 1L;

          
    public DeleteServlet() {        
    	super();
        // TODO Auto-generated constructor stub   
    	}
 
 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  
	 int id=Integer.parseInt(request.getParameter("id"));
	 
	 try {   
		 Class.forName("com.mysql.cj.jdbc.Driver");
		 Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/servletdemo","root","root");   
		 PreparedStatement pstmt = con.prepareStatement("delete from product where id=?");
		 pstmt.setInt(1, id);   pstmt.executeUpdate();
		 RequestDispatcher rd = request.getRequestDispatcher("ProductServlet");   
		 rd.forward(request, response);
		 
	 }  
	 catch(Exception e) {
		 System.out.println(e);  }
   }
 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  // TODO Auto-generated method stub  doGet(request, response);
 }
}