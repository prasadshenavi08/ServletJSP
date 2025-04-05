<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Receipt</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .receipt-container {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            background: #fff;
            text-align: center;
        }
        .receipt-container h3 {
            margin-bottom: 20px;
        }
        .btn-print {
            background: #28a745;
            color: #fff;
        }
        .btn-print:hover {
            background: #218838;
        }
        .btn-home {
            background: #007bff;
            color: #fff;
        }
        .btn-home:hover {
            background: #0056b3;
        }
       h1 {
    font-size: 40px;
    font-weight: bold;
    background: linear-gradient(45deg, #ff0000, #ff7300, #ffeb00, #47ff00, #00e1ff, #3700ff, #ae00ff);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    text-align: center;
    animation: rainbowText 5s infinite linear;
}

@keyframes rainbowText {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
}

    </style>
</head>
<body>
    <div class="container mt-4">
        <div class="receipt-container">
        	<h1>Mobile Universe</h1>
            <h3>Payment Receipt</h3>
            <p><strong>Mobile Name:</strong> <%= request.getAttribute("mobileName") %></p>
            <p><strong>Brand:</strong> <%= request.getAttribute("brand") %></p>
            <p><strong>Price:</strong> ₹<%= request.getAttribute("price") %></p>
            <p><strong>RAM:</strong> <%= request.getAttribute("ram") %></p>
            <p><strong>Manufacture Date:</strong> <%= request.getAttribute("manufactureDate") %></p>

            <h5>Payment Method</h5>
            <select class="form-control mb-3">
                <option>Credit Card</option>
                <option>Debit Card</option>
                <option>UPI</option>
                <option>Cash on Delivery</option>
            </select>

            <button class="btn btn-success w-100 mb-2" onclick="printReceipt()">Print Receipt</button>
            <a href="dashboard.jsp" class="btn btn-primary w-100">Back to Home</a>
        </div>
    </div>

    <script>
        function printReceipt() {
            window.print();
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
