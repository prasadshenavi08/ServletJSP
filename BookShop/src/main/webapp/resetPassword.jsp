<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
</head>
<body>
    <div class="container">
        <h2>Reset Your Password</h2>
        <form action="resetPasswordController" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="newPassword">New Password:</label>
                <input type="password" id="newPassword" name="newPassword" required>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>

            <div class="form-group">
                <input type="submit" value="Reset Password">
            </div>

            <div id="error-message" style="color: red;">
                <c:if test="${param.error == 'passwordMismatch'}">
                    <p>Passwords do not match.</p>
                </c:if>
                <c:if test="${param.error == 'updateFailed'}">
                    <p>Failed to update password. Please try again.</p>
                </c:if>
                <c:if test="${param.error == 'databaseError'}">
                    <p>There was an error connecting to the database. Please try again later.</p>
                </c:if>
            </div>
        </form>
    </div>

    <script>
        function validateForm() {
            var newPassword = document.getElementById("newPassword").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            
            if (newPassword !== confirmPassword) {
                document.getElementById("error-message").innerText = "Passwords do not match!";
                return false;
            }
            return true;
        }
    </script>
</body>
</html>