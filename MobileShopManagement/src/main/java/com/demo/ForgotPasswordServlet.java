package com.demo;


import java.io.IOException;
import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        RequestDispatcher dispatcher = null;
        int otpvalue = 0;
        HttpSession mySession = request.getSession();

        if (email != null && !email.trim().isEmpty()) {
            // Generating OTP
            Random rand = new Random();
            otpvalue = rand.nextInt(1255650);

            // Configuring mail properties
            String to = email;
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.socketFactory.port", "465");
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.port", "465");

            // Authenticating the email session
            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("prasadshenavi1444@gmail.com", "owqkwlwbulvotafv");
                }
            });

            // Composing and sending the email
            try {
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress("your_email@gmail.com")); // Sender's email
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(email)); // Recipient's email
                message.setSubject("OTP Verification");
                message.setText("Your OTP is: " + otpvalue);

                Transport.send(message);
                System.out.println("Message sent successfully");

                dispatcher = request.getRequestDispatcher("EnterOtp.jsp");
                request.setAttribute("message", "OTP is sent to your email ID");
                mySession.setAttribute("otp", otpvalue);
                mySession.setAttribute("email", email);

                dispatcher.forward(request, response);

            } catch (MessagingException e) {
                e.printStackTrace();
                throw new ServletException("Error while sending email", e);
            }
        } else {
            dispatcher = request.getRequestDispatcher("ForgotPassword.jsp");
            request.setAttribute("error", "Please enter a valid email address");
            dispatcher.forward(request, response);
        }
    }
}
