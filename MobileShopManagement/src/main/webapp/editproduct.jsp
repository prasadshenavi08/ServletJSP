<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Product - Mobile Shop Management</title>
    <link rel="stylesheet" href="styles.css"> <!-- External CSS file if needed -->
    <style>
        /* General Styles */
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        .edit-container {
            width: 40%;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        h2 {
            margin-bottom: 20px;
            color: #333;
        }

        /* Form Styling */
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        label {
            font-weight: bold;
            margin-top: 10px;
            align-self: flex-start;
        }

        input, select, textarea {
            width: 100%;
            padding: 10px;
            margin: 5px 0 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        textarea {
            resize: none;
            height: 80px;
        }

        /* Button Styling */
        .btn-group {
            display: flex;
            justify-content: space-between;
            width: 100%;
        }

        button {
            padding: 12px;
            width: 48%;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: 0.3s;
        }

        .btn-update {
            background: #4facfe;
            color: white;
        }

        .btn-update:hover {
            background: #00c3ff;
        }

        .btn-cancel {
            background: #ff4b5c;
            color: white;
        }

        .btn-cancel:hover {
            background: #ff1e3c;
        }

    </style>
</head>
<body>
    <div class="edit-container">
        <h2>Edit Product</h2>
        <%
            int id = Integer.parseInt(request.getParameter("id"));
            String name = "", brand = "", ram = "", manufacture_date = "", description = "";
            double price = 0;
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mobileshopfinal", "root", "root");
                PreparedStatement ps = con.prepareStatement("SELECT * FROM mobiles WHERE id=?");
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();
                
                if (rs.next()) {
                    name = rs.getString("name");
                    price = rs.getDouble("price");
                    brand = rs.getString("brand");
                    ram = rs.getString("ram");
                    manufacture_date = rs.getString("manufacture_date");
                    description = rs.getString("description"); // Fetch description
                }
                con.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>

        <form action="updateproduct.jsp" method="post">
            <input type="hidden" name="id" value="<%= id %>">
            
            <label for="name">Product Name:</label>
            <input type="text" id="name" name="name" value="<%= name %>" required>

            <label for="price">Price (₹):</label>
            <input type="number" id="price" name="price" value="<%= price %>" required>

            <label for="brand">Brand:</label>
            <input type="text" id="brand" name="brand" value="<%= brand %>" required>

            <label for="ram">RAM:</label>
            <input type="text" id="ram" name="ram" value="<%= ram %>" required>

            <label for="manufacture_date">Manufacture Date:</label>
            <input type="date" id="manufacture_date" name="manufacture_date" value="<%= manufacture_date %>" required>

            <label for="description">Description:</label>
            <textarea id="description" name="description" required><%= description %></textarea>

            <div class="btn-group">
                <button type="submit" class="btn-update">Update Product</button>
                <button type="button" class="btn-cancel" onclick="window.location.href='admindashboard.jsp'">Cancel</button>
            </div>
        </form>
    </div>
</body>
</html>
