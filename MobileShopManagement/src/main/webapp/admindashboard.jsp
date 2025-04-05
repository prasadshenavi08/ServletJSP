<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Mobile Shop Management</title>
    <link rel="stylesheet" href="styles.css"> <!-- Add CSS file if needed -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
            display: flex;
            flex-direction: column;
            align-items: center;
            margin: 0;
            padding: 20px;
        }
        .dashboard-container {
            width: 90%;
            max-width: 1200px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
            animation: fadeIn 1.5s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        button {
            padding: 10px;
            margin: 5px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            background: #4facfe;
            color: white;
            font-size: 14px;
            transition: background 0.3s;
        }
        button:hover {
            background: #00c3ff;
        }
        .logout-btn {
            background: #ff4b5c;
            font-size: 18px;
            padding: 6px 10px;
        }
        .logout-btn:hover {
            background: #d43f50;
        }
        .product-list {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-top: 20px;
        }
		.search-sort-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 100%;
        margin-bottom: 10px;
    }
    .search-input, .sort-dropdown, .logout-btn {
        flex: 1;
        max-width: 30%;
    }
    .search-input {
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 14px;
    }.full-width-button {
        width: 100%;
        padding: 12px;
        background: #4facfe;
        color: white;
        font-size: 16px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background 0.3s;
    }
    .full-width-button:hover {
        background: #00c3ff;
    }
			        
        .product-card {
            background: white;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
            animation: fadeIn 1s ease-in-out;
            position: relative;
        }
        .button-group {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 10px;
        }
        .delete-btn {
            background: red;
            color: white;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 5px;
        }
        .delete-btn:hover {
            background: darkred;
        }
        .edit-btn {
            background: green;
            color: white;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 5px;
        }
        .edit-btn:hover {
            background: darkgreen;
        }
        
    </style>
</head>
<body>
    <div class="dashboard-container">
        <h2>Admin Dashboard</h2>
        <div class="search-sort-container">
            <input type="text" class="search-input" id="search" placeholder="Search products..." onkeyup="searchProducts()">
            <select class="sort-dropdown" id="sort" onchange="sortProducts()">
                <option value="">Sort by</option>
                <option value="price">Price</option>
                <option value="brand">Brand</option>
            </select>
            <button class="logout-btn" onclick="window.location.href='adminlogin.jsp'">Logout</button>
        </div>
        <button class="full-width-button" onclick="window.location.href='insertproduct.jsp'">Insert New Product</button>
        
        <div class="product-list" id="product-list">
            <% 
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mobileshopfinal", "root", "root");
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM mobiles");
                    while (rs.next()) {
            %>
            <div class="product-card" id="product-<%= rs.getInt("id") %>">
			    <img src="<%= rs.getString("image") %>" alt="Product Image" style="width: 80%; height: 200px; object-fit: cover; border-top-left-radius: 10px; border-top-right-radius: 10px; margin: 10px;">
			    <h3><%= rs.getString("name") %></h3>
			    <p>Price: $<%= rs.getDouble("price") %></p>
			    <p>Brand: <%= rs.getString("brand") %></p>
			    <p>RAM: <%= rs.getString("ram") %></p>
			    <p>Manufacture Date: <%= rs.getString("manufacture_date") %></p>
			    <p>Description: <%= rs.getString("description") %></p>
			
			    <div class="button-group">
			        <button class="edit-btn" onclick="window.location.href='editproduct.jsp?id=<%= rs.getInt("id") %>'">Edit</button>
			        <button class="delete-btn" onclick="deleteProduct(<%= rs.getInt("id") %>)">Delete</button>
			    </div>
			</div>

            <%
                    }
                    con.close();
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                }
            %>
        </div>
    </div>

    <script>
        function deleteProduct(productId) {
            if (confirm("Are you sure you want to delete this product?")) {
                fetch("deleteproduct.jsp?id=" + productId, { method: "GET" })
                .then(response => response.text())
                .then(data => {
                    document.getElementById("product-" + productId).remove();
                })
                .catch(error => console.error("Error deleting product:", error));
            }
        }
        function searchProducts() {
            let input = document.getElementById("search").value.toLowerCase();
            let products = document.getElementsByClassName("product-card");
            for (let product of products) {
                product.style.display = product.innerText.toLowerCase().includes(input) ? "block" : "none";
            }
        }
        function sortProducts() {
            let sortType = document.getElementById("sort").value;
            let products = Array.from(document.getElementsByClassName("product-card"));
            let container = document.getElementById("product-list");
            if (sortType === "price") {
                products.sort((a, b) => parseFloat(a.children[1].innerText.replace("Price: $", "")) - parseFloat(b.children[1].innerText.replace("Price: $", "")));
            } else if (sortType === "brand") {
                products.sort((a, b) => a.children[2].innerText.localeCompare(b.children[2].innerText));
            }
            products.forEach(product => container.appendChild(product));
        }
    </script>
</body>
</html>