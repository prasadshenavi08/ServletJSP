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

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Retrieve form data
        String fullname = request.getParameter("fullname");
        String mobileno = request.getParameter("mobileno");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");

        // Database connection parameters
        String jdbcURL = "jdbc:mysql://localhost:3306/medicalshop"; // Replace with your database URL
        String dbUser = "root"; // Replace with your database username
        String dbPassword = "root"; // Replace with your database password

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection
            Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Insert query
            String query = "INSERT INTO users (fullname, mobileno, email, username, password, gender) VALUES (?, ?, ?, ?, ?, ?)";

            // Create a prepared statement
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, fullname);
            preparedStatement.setString(2, mobileno);
            preparedStatement.setString(3, email);
            preparedStatement.setString(4, username);
            preparedStatement.setString(5, password);
            preparedStatement.setString(6, gender);

            // Execute the query
            int result = preparedStatement.executeUpdate();

            if (result > 0) {
                out.println("<script type='text/javascript'>");
                out.println("alert('Registration successful! Redirecting to login page.');");
                out.println("window.location.href = 'login.jsp';");
                out.println("</script>");
            } else {
                out.println("<script type='text/javascript'>");
                out.println("alert('Registration failed. Please try again.');");
                out.println("window.location.href = 'registration.jsp';");
                out.println("</script>");
            }

            // Close connections
            preparedStatement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script type='text/javascript'>");
            out.println("alert('An error occurred. Please try again later.');");
            out.println("window.location.href = 'registration.jsp';");
            out.println("</script>");
        }
    }
}


