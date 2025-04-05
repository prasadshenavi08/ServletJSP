<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Mobile Universe</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .header {
            background: linear-gradient(90deg, #007bff, #6610f2);
            color: white;
            padding: 15px;
            text-align: center;
            font-size: 1.5rem;
            font-weight: bold;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            position: relative;
        }
        .container {
            margin-top: 30px;
        }
    </style>
</head>
<body>

    <div class="header">
        Final Checkout - Mobile Universe
        <a href="checkout.jsp" class="btn btn-light">Back to Cart</a>
    </div>

    <div class="container">
        <h2 class="text-center">Complete Your Order</h2>

        <%
            HttpSession userSession = request.getSession();
            List<Integer> cart = (List<Integer>) userSession.getAttribute("cart");
            double totalPrice = 0;

            if (cart == null || cart.isEmpty()) {
        %>
            <div class="alert alert-warning text-center">Your cart is empty! <a href="dashboard.jsp">Go shopping</a></div>
        <%
            } else {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mobileshopfinal", "root", "root");

                    String cartItemsQuery = "SELECT price FROM mobiles WHERE id = ?";
                    PreparedStatement ps = con.prepareStatement(cartItemsQuery);

                    for (int mobileId : cart) {
                        ps.setInt(1, mobileId);
                        ResultSet rs = ps.executeQuery();
                        if (rs.next()) {
                            totalPrice += rs.getDouble("price");
                        }
                    }
                    con.close();
        %>

        <form action="OrderServlet" method="post" class="mt-4">
            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <input type="text" name="fullName" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Delivery Address</label>
                <textarea name="address" class="form-control" required></textarea>
            </div>
            <div class="mb-3">
                <label class="form-label">Payment Method</label>
                <select name="paymentMethod" class="form-control">
                    <option value="Cash on Delivery">Cash on Delivery</option>
                    <option value="Credit/Debit Card">Credit/Debit Card</option>
                    <option value="UPI">UPI</option>
                </select>
            </div>
            <div class="mb-3">
                <h4>Total Amount: ₹<%= totalPrice %></h4>
            </div>
            <button type="submit" class="btn btn-success">Place Order</button>
        </form>

        <%
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>

</body>
</html>
