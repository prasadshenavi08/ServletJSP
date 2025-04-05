package com.demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("paymentMethod");

        HttpSession session = request.getSession();
        List<Integer> cart = (List<Integer>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            session.setAttribute("orderMessage", "Your cart is empty!");
            response.sendRedirect("checkout.jsp");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mobileshopfinal", "root", "root");

            String insertOrderQuery = "INSERT INTO orders (user_name, address, payment_method, mobile_id) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(insertOrderQuery);

            for (int mobileId : cart) {
                ps.setString(1, fullName);
                ps.setString(2, address);
                ps.setString(3, paymentMethod);
                ps.setInt(4, mobileId);
                ps.executeUpdate();
            }

            con.close();

            // Clear cart after order
            session.removeAttribute("cart");
            session.setAttribute("orderMessage", "Order placed successfully!");

            response.sendRedirect("orderSuccess.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("orderMessage", "Something went wrong. Please try again!");
            response.sendRedirect("checkout.jsp");
        }
    }
}
