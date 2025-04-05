package com.demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/resetPasswordController")
public class ResetPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the parameters from the form
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate the password
        if (newPassword != null && confirmPassword != null && newPassword.equals(confirmPassword)) {
            // Hash the password for security (you should use a strong hashing algorithm like bcrypt or PBKDF2)
            String hashedPassword = hashPassword(newPassword);
            
            // Update the password in the database
            try {
                boolean isUpdated = updatePasswordInDatabase(request, hashedPassword);
                
                if (isUpdated) {
                    response.sendRedirect("passwordResetSuccess.jsp");
                } else {
                    response.sendRedirect("resetPassword.jsp?error=updateFailed");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("resetPassword.jsp?error=databaseError");
            }
        } else {
            response.sendRedirect("resetPassword.jsp?error=passwordMismatch");
        }
    }

    // Example method for password hashing
    private String hashPassword(String password) {
        // Here you can use a library for password hashing like BCrypt
        return password; // Replace with actual hashing logic
    }

    // Example method to update the password in the database
    private boolean updatePasswordInDatabase(HttpServletRequest request, String hashedPassword) throws SQLException {
        // You need to get the user from the session or request (e.g., user ID or email)
        // For example, assume you get the userId from the session
        String userId = (String) request.getSession().getAttribute("userId");

        if (userId != null) {
            // Database connection logic
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookshop", "username", "password")) {
                String sql = "UPDATE users SET password = ? WHERE user_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, hashedPassword);
                    stmt.setString(2, userId);
                    int rowsUpdated = stmt.executeUpdate();
                    return rowsUpdated > 0;
                }
            }
        }
        return false;
    }
}
