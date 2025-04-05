<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login - Mobile Shop Management</title>
    <link rel="stylesheet" href="styles.css"> <!-- External CSS file -->
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
        .login-container {
            background: white;
            padding: 150px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
            animation: fadeIn 1.5s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        h2 {
            color: #333;
        }
        label {
            display: block;
            margin: 10px 0 5px;
        }
        input {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            background: #4facfe;
            color: white;
            border: none;
            padding: 10px;
            width: 100%;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s;
        }
        button:hover {
            background: #00c3ff;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Admin Login</h2>
        <form action="admindashboard.jsp" method="post" onsubmit="return validateLogin()">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" value="admin" required>
            
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" value="admin" required>
            
            <button type="submit">Login</button>
        </form>
    </div>
    
    <script>
        function validateLogin() {
            var username = document.getElementById("username").value;
            var password = document.getElementById("password").value;
            
            if (username === "admin" && password === "admin") {
                return true; // Redirect to admindashboard.jsp
            } else {
                alert("Invalid Credentials! Please enter the correct username and password.");
                return false;
            }
        }
    </script>
</body>
</html>
