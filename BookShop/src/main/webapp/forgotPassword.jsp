<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>Forgot Password</title>
</head>
<body>
	<h1>Forgot Password</h1>
    <form action="forgotPassword" method="post">
        <label for="email">Enter your registered email:</label><br>
        <input type="email" id="email" name="email" required><br><br>
        <input type="submit" value="Send OTP">
    </form>
</body>
</html>