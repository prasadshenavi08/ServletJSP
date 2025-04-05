package com.demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/BuyServlet")
public class BuyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int mobileId = Integer.parseInt(request.getParameter("mobile_id"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mobileshopfinal", "root", "root");

            String query = "SELECT id, name, price, brand, ram, manufacture_date FROM mobiles WHERE id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, mobileId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("mobileId", rs.getInt("id"));
                request.setAttribute("mobileName", rs.getString("name"));
                request.setAttribute("brand", rs.getString("brand"));
                request.setAttribute("price", rs.getBigDecimal("price"));
                request.setAttribute("ram", rs.getString("ram"));
                request.setAttribute("manufactureDate", rs.getDate("manufacture_date"));
                request.getRequestDispatcher("buy.jsp").forward(request, response);
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
