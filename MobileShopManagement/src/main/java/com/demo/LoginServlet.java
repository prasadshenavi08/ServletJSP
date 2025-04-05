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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Retrieve form data
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Database connection parameters
        String jdbcURL = "jdbc:mysql://localhost:3306/mobileshopfinal"; // Replace with your database URL
        String dbUser = "root"; // Replace with your database username
        String dbPassword = "root"; // Replace with your database password

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection
            Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // SQL query to validate login
            String query = "SELECT * FROM users WHERE username = ? AND password = ?";

            // Create a prepared statement
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);

            // Execute query
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                // Login successful
                out.println("<script type='text/javascript'>");
                out.println("alert('Login successful! Redirecting to the dashboard.');");
                out.println("window.location.href = 'dashboard.jsp';");
                out.println("</script>");
            } else {
                // Login failed
                out.println("<script type='text/javascript'>");
                out.println("alert('Invalid username or password. Please try again.');");
                out.println("window.location.href = 'login.jsp';");
                out.println("</script>");
            }

            // Close connections
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script type='text/javascript'>");
            out.println("alert('An error occurred. Please try again later.');");
            out.println("window.location.href = 'login.jsp';");
            out.println("</script>");
        }
    }
}

