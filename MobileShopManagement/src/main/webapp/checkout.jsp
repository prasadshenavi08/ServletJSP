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
        .table th, .table td {
            vertical-align: middle;
        }
        .btn-remove {
            background-color: red;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
        }
        .btn-remove:hover {
            background-color: darkred;
        }
    </style>
</head>
<body>

    <div class="header">
        Checkout - Mobile Universe
        <a href="dashboard.jsp" class="btn btn-light">Back to Shop</a>
    </div>

    <div class="container">
        <h2 class="text-center">Your Cart</h2>

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

                    String cartItemsQuery = "SELECT id, name, brand, price FROM mobiles WHERE id = ?";
                    PreparedStatement ps = con.prepareStatement(cartItemsQuery);
        %>

        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Mobile Name</th>
                    <th>Brand</th>
                    <th>Price</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
        <%
                    for (int mobileId : cart) {
                        ps.setInt(1, mobileId);
                        ResultSet rs = ps.executeQuery();

                        if (rs.next()) {
                            double price = rs.getDouble("price");
                            totalPrice += price;
        %>
                <tr>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("brand") %></td>
                    <td>₹<%= price %></td>
                    <td>
                        <form action="RemoveFromCartServlet" method="post">
                            <input type="hidden" name="mobile_id" value="<%= rs.getInt("id") %>">
                            <button type="submit" class="btn-remove">Remove</button>
                        </form>
                    </td>
                </tr>
        <%
                        }
                    }
                    con.close();
        %>
            </tbody>
        </table>

        <div class="text-end">
            <h4>Total: ₹<%= totalPrice %></h4>
            <a href="processCheckout.jsp" class="btn btn-success">Proceed to Checkout</a>
        </div>

        <%
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>

</body>
</html>
