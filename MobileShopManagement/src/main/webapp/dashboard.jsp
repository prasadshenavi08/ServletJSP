<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mobile Universe Dashboard</title>
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
        .header .btn {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
        }
        .header .cart-btn {
            right: 120px;
        }
        .header .logout-btn {
            right: 20px;
        }
        .card {
            transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
            border-radius: 10px;
        }
        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }
        .product-image {
            width: 80%;
            height: 200px;
            object-fit: cover;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
           	margin: 30px;
        }
    </style>
</head>
<body>

    <!-- Header Section -->
    <div class="header">
        Mobile Universe
        <a href="cart.jsp" class="btn btn-warning cart-btn">View Cart</a>
        <a href="login.jsp" class="btn btn-danger logout-btn">Logout</a>
    </div>

    <!-- Main Container -->
    <div class="container mt-4">
        
        <!-- Page Title -->
        <h2 class="text-center mb-4">Welcome to Mobile Universe</h2>

        <!-- Display Cart Message -->
        <%
            String cartMessage = (String) session.getAttribute("cartMessage");
            if (cartMessage != null) {
        %>
            <div class="alert alert-success alert-dismissible fade show text-center" role="alert">
                <%= cartMessage %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <%
                session.removeAttribute("cartMessage"); // Remove after displaying
            }
        %>

        <!-- Product Listing -->
        <div class="row">
            <%
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mobileshopfinal", "root", "root");

                    // Fetch mobile details
                    String query = "SELECT id, name, brand, price, ram, manufacture_date, description, image FROM mobiles";
                    ps = con.prepareStatement(query);
                    rs = ps.executeQuery();

                    while (rs.next()) {
            %>
                        <!-- Mobile Card -->
                        <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                            <div class="card h-100">
                                <img src="<%= rs.getString("image") %>" alt="Product Image" class="product-image">
                                <div class="card-body text-center">
                                    <h5 class="card-title"><%= rs.getString("name") %></h5>
                                    <p class="card-text"><strong>Brand:</strong> <%= rs.getString("brand") %></p>
                                    <p class="card-text"><strong>Price:</strong> ₹<%= rs.getString("price") %></p>
                                    <p class="card-text"><strong>RAM:</strong> <%= rs.getString("ram") %></p>
                                    <p class="card-text"><strong>Manufacture Date:</strong> <%= rs.getDate("manufacture_date") %></p>
                                    <p class="card-text"><strong>Description:</strong> <%= rs.getString("description") %></p>
                                    
                                    <!-- Buy and Add to Cart Buttons -->
                                    <div class="d-flex justify-content-center">
                                        <form action="BuyServlet" method="post" class="me-2">
                                            <input type="hidden" name="mobile_id" value="<%= rs.getInt("id") %>">
                                            <button type="submit" class="btn btn-success">Buy Now</button>
                                        </form>
                                        <form action="AddToCartServlet" method="post">
                                            <input type="hidden" name="mobile_id" value="<%= rs.getInt("id") %>">
                                            <button type="submit" class="btn btn-primary">Add to Cart</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    // Close resources
                    if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                    if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
                    if (con != null) try { con.close(); } catch (SQLException ignored) {}
                }
            %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
