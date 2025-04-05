package com.demo;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int mobileId = Integer.parseInt(request.getParameter("mobile_id"));

        HttpSession session = request.getSession();
        List<Integer> cart = (List<Integer>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        // Check if the item is already in the cart
        if (!cart.contains(mobileId)) {
            cart.add(mobileId);
            session.setAttribute("cartMessage", "Item added to cart successfully!");
        } else {
            session.setAttribute("cartMessage", "Item is already in the cart!");
        }

        response.sendRedirect("dashboard.jsp"); // Redirect back to the dashboard
    }
}
