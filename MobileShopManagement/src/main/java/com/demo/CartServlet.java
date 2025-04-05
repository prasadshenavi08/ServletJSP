package com.demo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Integer> cart = (List<Integer>) session.getAttribute("cart");

        List<String[]> cartItems = new ArrayList<>();

        if (cart != null && !cart.isEmpty()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mobileshopfinal", "root", "root");

                String query = "SELECT id, name, brand, price FROM mobiles WHERE id = ?";
                PreparedStatement ps = con.prepareStatement(query);

                for (int id : cart) {
                    ps.setInt(1, id);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        String[] item = {
                            rs.getString("id"),
                            rs.getString("name"),
                            rs.getString("brand"),
                            rs.getString("price")
                        };
                        cartItems.add(item);
                    }
                }

                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        request.setAttribute("cartItems", cartItems);
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }
}
