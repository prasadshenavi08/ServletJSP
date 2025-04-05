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

        // Debugging: Print values to console
        System.out.println("Received Data: " + fullname + ", " + mobileno + ", " + email + ", " + username + ", " + password + ", " + gender);

        // Database connection parameters
        String jdbcURL = "jdbc:mysql://localhost:3306/mobileshopfinal";
        String dbUser = "root";
        String dbPassword = "root";

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("JDBC Driver Loaded Successfully");

            // Establish connection
            try (Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword)) {
                System.out.println("Database Connected Successfully");

                // Insert query
                String query = "INSERT INTO users (fullname, mobileno, email, username, password, gender) VALUES (?, ?, ?, ?, ?, ?)";

                // Create a prepared statement
                try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                    preparedStatement.setString(1, fullname);
                    preparedStatement.setString(2, mobileno);
                    preparedStatement.setString(3, email);
                    preparedStatement.setString(4, username);
                    preparedStatement.setString(5, password);
                    preparedStatement.setString(6, gender);

                    // Execute the query
                    int result = preparedStatement.executeUpdate();
                    System.out.println("Query Executed, Rows Affected: " + result);

                    if (result > 0) {
                        System.out.println("Registration Successful!");
                        response.sendRedirect("login.jsp");
                    } else {
                        System.out.println("Registration Failed!");
                        response.sendRedirect("register.jsp");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error Occurred: " + e.getMessage());
            response.sendRedirect("register.jsp");
        }
    }
}
