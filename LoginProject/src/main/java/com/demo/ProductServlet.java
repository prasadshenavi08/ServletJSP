package com.demo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ProductServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // JDBC functionality
        PrintWriter out = response.getWriter();
        out.println("<html>");
        out.println("<head>");
        out.println("<link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css\" rel=\"stylesheet\" integrity=\"sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH\" crossorigin=\"anonymous\">");
        out.println("</head>");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/servletdemo", "root", "root");
            PreparedStatement pstmt = con.prepareStatement("SELECT * FROM product");
            ResultSet rs = pstmt.executeQuery();
            out.println("<body>");
            out.println("<table class='table' border='2'>");

            String pn, pc;
            int id, pr;
            while (rs.next()) {
                id = rs.getInt(1);
                pn = rs.getString(2);
                pc = rs.getString(3);
                pr = rs.getInt(4);

                out.println("<tr>");
                out.println("<td>" + id + "</td>");
                out.println("<td>" + pn + "</td>");
                out.println("<td>" + pc + "</td>");
                out.println("<td>" + pr + "</td></tr>");
                
                String ur="DeleteServlet?id=" +id; 
                out.println("<td> <a href='#'>Edit</a><a href=" +ur+ ">Delete</a></td></tr>");  
            }
            out.println("</table></body></html>");
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
