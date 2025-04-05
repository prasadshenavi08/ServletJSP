<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login Page</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        .login-container {
            width: 100%;
            max-width: 450px;
            background: #ffffff;
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .login-container h1 {
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

        .placeicon {
            font-family: fontawesome;
        }

        .custom-control-label::before {
            background-color: #dee2e6;
            border: #dee2e6;
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
</head>
<body>
    <div class="login-container">
        <!-- Bootstrap Alert Placeholder -->
        <div id="alert-container">
            <!-- Example Alert -->
            <!-- Uncomment the line below to display an alert -->
            <!-- <div class="alert alert-success alert-dismissible fade show" role="alert">
                 Login successful!
                 <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
             </div> -->
        </div>

        <h1><strong>Login</strong></h1>
        <form action="LoginServlet" method="POST" class="mt-4">
            <!-- Username Input -->
            <div class="form-group">
                <input type="text" name="username" placeholder="&#xf007; &nbsp; Username" class="form-control placeicon" required>
            </div>

            <!-- Password Input -->
            <div class="form-group">
                <input type="password" name="password" placeholder="&#xf084; &nbsp; Password" class="form-control placeicon" required>
            </div>

            <!-- Submit Button -->
            <div class="form-group text-center">
                <button type="submit" class="btn btn-info btn-block">Login</button>
            </div>

            <!-- Cancel Button -->
            <div class="form-group text-center">
                <button type="reset" class="btn btn-danger btn-block">Cancel</button>
            </div>

            <!-- Forgot Password and Registration Links -->
            <div class="text-center mt-3">
                <a href="forgot_password.jsp">Forgot Password?</a>
            </div>
            <div class="text-center mt-2">
                <a href="registration.jsp">New User? Register here</a>
            </div>
        </form>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js"></script>
</body>
</html>
