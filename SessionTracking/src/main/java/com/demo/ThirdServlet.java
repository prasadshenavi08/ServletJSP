package com.demo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/ThirdServlet")
public class ThirdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ThirdServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//String un = request.getParameter("txtusername");
		  PrintWriter out = response.getWriter();  
		  HttpSession session = request.getSession();
		  String un = (String)session.getAttribute("user");  
		  out.println("Good Morning " + un);
		  //RequestDispatcher rd = request.getRequestDispatcher("ThirdServlet");  //rd.forward(request, response);
		  response.sendRedirect("https://www.flipkart.com");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
