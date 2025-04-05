package com.demo;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ValidateOtpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userOtp = request.getParameter("otp");
        String sessionOtp = (String) request.getSession().getAttribute("otp");
        String email = (String) request.getSession().getAttribute("email");

        if (sessionOtp != null && userOtp != null && sessionOtp.equals(userOtp)) {
            // OTP validated successfully
            request.getSession().removeAttribute("otp"); // Clear OTP after successful validation
            response.getWriter().println("OTP validated successfully for email: " + email);
            // Redirect to reset password page or another appropriate action
        } else {
            // OTP validation failed
            response.getWriter().println("Invalid OTP. Please try again.");
        }
    }
}
