<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>OTP Validation</title>
</head>
<body>
	<h1>OTP Validation</h1>
    <form action="validateOtp" method="post">
        <label for="otp">Enter the OTP sent to your email:</label><br>
        <input type="text" id="otp" name="otp" required><br><br>
        <input type="submit" value="Validate OTP">
    </form>
</body>
</html>