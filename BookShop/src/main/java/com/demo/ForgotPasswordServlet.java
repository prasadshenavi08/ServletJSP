package com.demo;

import java.io.IOException;
import java.net.PasswordAuthentication;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.Random;

import com.mysql.cj.Session;
import com.mysql.cj.protocol.Message;

//import jakarta.mail.*;
//import jakarta.mail.internet.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/BookShop")
public class ForgotPasswordServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/bookshop";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String otp = generateOtp();

        if (isEmailRegistered(email)) {
            boolean otpSent = sendOtp(email, otp);
            if (otpSent) {
                request.getSession().setAttribute("email", email);
                request.getSession().setAttribute("otp", otp);
                response.sendRedirect("otpValidation.jsp");
            } else {
                response.getWriter().println("Failed to send OTP. Please try again.");
            }
        } else {
            response.getWriter().println("Email not registered.");
        }
    }

    private boolean isEmailRegistered(String email) {
        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "SELECT * FROM users WHERE email = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private boolean sendOtp(String email, String otp) {
        final String senderEmail = "your_email@example.com";
        final String senderPassword = "your_email_password";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

//        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
//            protected PasswordAuthentication getPasswordAuthentication() {
//                return new PasswordAuthentication(senderEmail, senderPassword);
//            }
//        });
//
//        try {
//            Message message = new MimeMessage(session);
//            message.setFrom(new InternetAddress(senderEmail));
//            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
//            message.setSubject("Your OTP for Password Reset");
//            message.setText("Your OTP is: " + otp);
//
//            Transport.send(message);
//            return true;
//        } catch (MessagingException e) {
//            e.printStackTrace();
//        }
        return false;
    }

    private String generateOtp() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }
}
