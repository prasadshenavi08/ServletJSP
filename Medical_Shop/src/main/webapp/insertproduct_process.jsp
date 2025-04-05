<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="jakarta.servlet.*, jakarta.servlet.http.*" %>

<%
    // Retrieve form data
    String title = request.getParameter("title");
    String description = request.getParameter("description");
    double price = Double.parseDouble(request.getParameter("price"));
    String expirationDate = request.getParameter("expirationDate");
    String category = request.getParameter("category");
    int qty = Integer.parseInt(request.getParameter("qty"));
    String location = request.getParameter("location");

    try {
        // Database connection details
        String dbUrl = "jdbc:mysql://localhost:3306/medicalshop";
        String dbUsername = "root";
        String dbPassword = "root";  // Replace with your database password
        Connection connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

        // SQL query to insert product data
        String insertSQL = "INSERT INTO products (title, description, price, expiration_date, category, qty, location) VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement statement = connection.prepareStatement(insertSQL);
        statement.setString(1, title);
        statement.setString(2, description);
        statement.setDouble(3, price);
        statement.setString(4, expirationDate);
        statement.setString(5, category);
        statement.setInt(6, qty);
        statement.setString(7, location);

        int rowsInserted = statement.executeUpdate();

        if (rowsInserted > 0) {
            // Redirect to dashboard or display a success message
            response.sendRedirect("dashboard.jsp?message=Product inserted successfully.");
        } else {
            // Handle failure if no rows were inserted
            request.setAttribute("errorMessage", "Failed to insert the product.");
            request.getRequestDispatcher("insertproduct.jsp").forward(request, response);
        }
    } catch (SQLException e) {
        e.printStackTrace();
        request.setAttribute("errorMessage", "An error occurred while inserting the product. Please try again.");
        request.getRequestDispatcher("insertproduct.jsp").forward(request, response);
    }
%>
