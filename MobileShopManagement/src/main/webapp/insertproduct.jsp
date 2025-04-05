<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.nio.file.Files"%>
<%@page import="jakarta.servlet.http.Part"%> <!-- Corrected Import for Part -->
<%@page import="jakarta.servlet.annotation.MultipartConfig"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert Product</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .form-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 500px;
        }
        label {
            font-weight: bold;
            color: #333;
        }
        input, textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn-container {
            display: flex;
            gap: 10px;
        }
        button {
            background: #4facfe;
            color: white;
            border: none;
            padding: 12px;
            width: 100%;
            border-radius: 5px;
            cursor: pointer;
        }
        .cancel-btn {
            background: #ff4b5c;
        }
    </style>
</head>

<body>
    <div class="form-container">
        <h2>Insert New Product</h2>
       <form action="InsertProductServlet" method="post" enctype="multipart/form-data">

            <div class="row">
                <div class="col-md-6">
                    <label for="name">Product Name:</label>
                    <input type="text" id="name" name="name" required>

                    <label for="price">Price:</label>
                    <input type="number" id="price" name="price" step="0.01" required>

                    <label for="brand">Brand:</label>
                    <input type="text" id="brand" name="brand" required>
                </div>

                <div class="col-md-6">
                    <label for="ram">RAM:</label>
                    <input type="text" id="ram" name="ram" required>

                    <label for="manufacture_date">Manufacture Date:</label>
                    <input type="date" id="manufacture_date" name="manufacture_date" required>

                    <label for="image">Product Image:</label>
                    <input type="file" id="image" name="image" accept="image/*" required>
                </div>
            </div>

            <label for="description">Description:</label>
            <textarea id="description" name="description" required></textarea>

            <div class="btn-container">
                <button type="submit">Insert Product</button>
                <button type="button" class="cancel-btn" onclick="window.location.href='admindashboard.jsp'">Cancel</button>
            </div>
        </form>
    </div>

    <%
        if (request.getMethod().equalsIgnoreCase("post")) {
            String name = request.getParameter("name");
            String price = request.getParameter("price");
            String brand = request.getParameter("brand");
            String ram = request.getParameter("ram");
            String manufactureDate = request.getParameter("manufacture_date");
            String description = request.getParameter("description");
            Part filePart = request.getPart("image"); // Corrected

            String fileName = filePart.getSubmittedFileName();
            String uploadPath = application.getRealPath("images") + File.separator + fileName;

            try (InputStream fileContent = filePart.getInputStream()) {
                File file = new File(uploadPath);
                Files.copy(fileContent, file.toPath());

                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mobileshopfinal", "root", "root");
                PreparedStatement ps = con.prepareStatement("INSERT INTO mobiles (name, price, brand, ram, manufacture_date, description, image) VALUES (?, ?, ?, ?, ?, ?, ?)");
                ps.setString(1, name);
                ps.setDouble(2, Double.parseDouble(price));
                ps.setString(3, brand);
                ps.setString(4, ram);
                ps.setString(5, manufactureDate);
                ps.setString(6, description);
                ps.setString(7, "images/" + fileName);

                int i = ps.executeUpdate();
                con.close();

                if (i > 0) {
                    response.sendRedirect("admindashboard.jsp");
                }
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
