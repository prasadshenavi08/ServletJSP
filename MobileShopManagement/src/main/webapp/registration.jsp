<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Page</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        .registration-container {
            width: 100%;
            max-width: 500px;
            background: #ffffff;
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .registration-container h1 {
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
            text-align: center;
            color: #343a40;
        }

        .form-control {
            font-size: 1rem;
            padding: 0.75rem;
            border-color: #dee2e6;
        }

        .btn {
            font-size: 1rem;
            padding: 0.5rem;
        }

        .text-center a {
            font-size: 0.9rem;
            color: #007bff;
        }

        .text-center a:hover {
            color: #0056b3;
            text-decoration: underline;
        }
    </style>
    <script>
    function showAlert() {
        const alertDiv = document.getElementById('alert-container');
        alertDiv.innerHTML = `<div class="alert alert-success alert-dismissible fade show" role="alert">
            Registration successful! Redirecting to login page...
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>`;
        setTimeout(() => {
            window.location.href = "login.jsp";
        }, 2000);
    }
</script>
</head>
<body>
    <div class="registration-container">
        <div id="alert-container"></div>
        <h1><strong>Mobile Shop Registration</strong></h1>
        
        <!-- ✅ REMOVE onsubmit="return showAlertAndRedirect()" -->
        <form action="RegisterServlet" method="POST">
            <div class="form-group mb-3">
                <label for="fullname" class="form-label">Full Name:</label>
                <input type="text" id="fullname" name="fullname" class="form-control" required>
            </div>

            <div class="form-group mb-3">
                <label for="mobileno" class="form-label">Mobile No:</label>
                <input type="tel" id="mobileno" name="mobileno" class="form-control" pattern="[0-9]{10}" required>
            </div>

            <div class="form-group mb-3">
                <label for="email" class="form-label">Email:</label>
                <input type="email" id="email" name="email" class="form-control" required>
            </div>

            <div class="form-group mb-3">
                <label for="username" class="form-label">Username:</label>
                <input type="text" id="username" name="username" class="form-control" required>
            </div>

            <div class="form-group mb-3">
                <label for="password" class="form-label">Password:</label>
                <input type="password" id="password" name="password" class="form-control" required>
            </div>

            <div class="form-group mb-3">
                <label class="form-label">Gender:</label><br>
                <div class="form-check form-check-inline">
                    <input type="radio" id="male" name="gender" value="Male" class="form-check-input" required>
                    <label for="male" class="form-check-label">Male</label>
                </div>
                <div class="form-check form-check-inline">
                    <input type="radio" id="female" name="gender" value="Female" class="form-check-input" required>
                    <label for="female" class="form-check-label">Female</label>
                </div>
            </div>

            <div>
                <button type="submit" class="btn btn-primary">Register</button>
                <a href="login.jsp" class="btn btn-danger">Cancel</a>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
