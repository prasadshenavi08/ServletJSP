<%@ page import="java.sql.*, java.util.*, jakarta.servlet.http.HttpSession" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Cart</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-center mb-4">Your Shopping Cart</h2>

        <%-- Display Cart Message --%>
        <%
            String cartMessage = (String) session.getAttribute("cartMessage");
            if (cartMessage != null) {
        %>
            <div class="alert alert-success alert-dismissible fade show text-center" role="alert">
                <%= cartMessage %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <%
                session.removeAttribute("cartMessage");
            }
        %>

        <table class="table table-bordered text-center">
            <thead class="table-dark">
                <tr>
                    <th>Mobile Name</th>
                    <th>Brand</th>
                    <th>Price</th>
                    <th>RAM</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    HttpSession userSession = request.getSession();
                    List<Integer> cart = (List<Integer>) userSession.getAttribute("cart");

                    if (cart == null || cart.isEmpty()) {
                        out.println("<tr><td colspan='5' class='text-center'>Your cart is empty.</td></tr>");
                    } else {
                        Connection con = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mobileshopfinal", "root", "root");

                            for (int mobileId : cart) {
                                String query = "SELECT name, brand, price, ram FROM mobiles WHERE id = ?";
                                ps = con.prepareStatement(query);
                                ps.setInt(1, mobileId);
                                rs = ps.executeQuery();

                                if (rs.next()) {
                %>
                                    <tr>
                                        <td><%= rs.getString("name") %></td>
                                        <td><%= rs.getString("brand") %></td>
                                        <td>₹<%= rs.getString("price") %></td>
                                        <td><%= rs.getString("ram") %></td>
                                        <td>
                                            <form action="RemoveFromCartServlet" method="post">
                                                <input type="hidden" name="mobile_id" value="<%= mobileId %>">
                                                <button type="submit" class="btn btn-danger">Remove</button>
                                            </form>
                                        </td>
                                    </tr>
                <%
                                }
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                            if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
                            if (con != null) try { con.close(); } catch (SQLException ignored) {}
                        }
                    }
                %>
            </tbody>
        </table>

        <div class="text-center">
            <a href="dashboard.jsp" class="btn btn-primary">Continue Shopping</a>
            <a href="checkout.jsp" class="btn btn-success">Proceed to Checkout</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
