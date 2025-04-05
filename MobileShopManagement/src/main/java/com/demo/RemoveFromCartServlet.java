package com.demo;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int mobileId = Integer.parseInt(request.getParameter("mobile_id"));

        HttpSession session = request.getSession();
        List<Integer> cart = (List<Integer>) session.getAttribute("cart");

        if (cart != null && cart.contains(mobileId)) {
            cart.remove(Integer.valueOf(mobileId));
            session.setAttribute("cartMessage", "Item removed from cart!");
        }

        response.sendRedirect("cart.jsp");
    }
}
