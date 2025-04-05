<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %> 
<%@ page session="true" %> <!-- Ensures session is enabled -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Success - Mobile Universe</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            text-align: center;
            padding: 50px;
        }
        .success-box {
            background: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            display: inline-block;
        }
        .success-icon {
            font-size: 50px;
            color: green;
        }
    </style>
</head>
<body>

<%
    String orderMessage = (String) session.getAttribute("orderMessage"); // Use existing session variable
    session.removeAttribute("orderMessage"); // Clear message after displaying
%>

<div class="success-box">
    <div class="success-icon">✅</div>
    <h2>Order Placed Successfully!</h2>
    <p><%= (orderMessage != null) ? orderMessage : "Thank you for shopping with us!" %></p>
    <a href="dashboard.jsp" class="btn btn-primary">Back to Home</a>
</div>

</body>
</html>
