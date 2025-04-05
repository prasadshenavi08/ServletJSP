<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="jakarta.servlet.*, jakarta.servlet.http.*" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        /* Custom styles */
        .container {
            margin-top: 30px;
        }
        .product-card {
            margin-top: 20px;
        }
        .navbar-custom {
            background-color: #343a40;
        }
        .navbar-brand {
            color: #ffffff;
        }
        .navbar-nav .nav-item .nav-link {
            color: #ffffff;
        }
        .navbar-nav .nav-item .nav-link:hover {
            color: #ddd;
        }
        .light-mode {
            background-color: #f8f9fa;
            color: black;
        }
        .dark-mode {
            background-color: #343a40;
            color: white;
        }
        .dark-mode .navbar-brand,
        .dark-mode .navbar-nav .nav-item .nav-link {
            color: white;
        }
        .dark-mode .card-title,
        .dark-mode .card-text {
            color: white;
            background-color: #343a40;
        }
        .full-width-btn {
            width: 100%;
        }
        .insert-btn-container {
            margin-top: 15px;
        }

        h1.text-center {
            font-size: 4rem; /* Large and bold for emphasis */
            font-weight: 900; /* Extra-bold font */
            margin-bottom: 2rem; /* Add spacing below */
            color: #2c3e50; /* Dark shade for a professional look */
            text-transform: uppercase; /* Make the text all uppercase */
            text-align: center; /* Center the text */
            text-shadow: 2px 4px 6px rgba(0, 0, 0, 0.3), 
                         0 0 10px rgba(255, 255, 255, 0.8); /* Glowing and shadow effect */
            letter-spacing: 0.1rem; /* Add some spacing between letters */
            background: linear-gradient(90deg, #ffffff, #6dd47e); /* White to light green gradient */
        }
    </style>
</head>

<body class="light-mode" id="body">
    <h1 class="text-center">Welcome To Medical Shop</h1>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container">
            <a class="navbar-brand" href="#">Dashboard</a>
            <div class="d-flex ml-auto">
                <!-- Mode Toggle Button -->
                <button class="btn btn-outline-light mr-2" id="mode-toggle">Switch to Dark Mode</button>
                
                <!-- Logout Button (styled as Danger) -->
                <button class="btn btn-outline-danger mr-2" id="logout-button">Logout</button>
            </div>
        </div>
    </nav>

    <!-- Dashboard Content -->
    <div class="container">
        <div class="row mb-3">
            <!-- Search Bar -->
            <div class="col-md-3">
                <input type="text" class="form-control" id="search-bar" placeholder="Search Products by Title">
            </div>

            <!-- Search Button -->
            <div class="col-md-1">
                <button class="btn btn-primary" id="search-button">Search</button>
            </div>

            <!-- Microphone Button -->
            <button class="btn btn-secondary" id="mic-button">
                <i class="fa fa-microphone"></i> Microphone
            </button>

            <!-- Categories Dropdown -->
            <div class="col-md-3">
                <select class="form-control" id="category-dropdown" onchange="filterProducts()">
                    <option value="">All Categories</option>
                    <option value="tablet">Tablet</option>
                    <option value="antibiotic">Antibiotic</option>
                    <option value="supplement">Supplement</option>
                </select>
            </div>

            <!-- Sort By Dropdown -->
            <div class="col-md-3">
                <select class="form-control" id="sort-dropdown" onchange="sortProducts()">
                    <option value="name">Sort by Name</option>
                    <option value="price">Sort by Price</option>
                    <option value="expiration_date">Sort by Expiration Date</option>
                </select>
            </div>
        </div>

        <!-- Insert New Product Button (Full-width) -->
        <div class="row insert-btn-container">
            <div class="col-md-12">
                <a href="insertproduct.jsp" class="btn btn-success full-width-btn">Insert New Product</a>
            </div>
        </div>

        <h2>Product List</h2>

        <!-- Products Display Section -->
        <div class="row" id="product-list">
            <%
                // Database connection details
                String dbUrl = "jdbc:mysql://localhost:3306/medicalshop";
                String dbUsername = "root";
                String dbPassword = "root";  // Replace with your database password
                
                try {
                    // Create a connection to the database
                    Connection connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
                    System.out.println("Connected to the database!");
                    
                    String selectSQL = "SELECT * FROM products";  // SQL query to fetch all products
                    Statement stmt = connection.createStatement();
                    ResultSet rs = stmt.executeQuery(selectSQL);

                    if (!rs.next()) {
                        out.println("<p>No products found!</p>");
                    } else {
                        do {
                            // Fetch product details from result set
                            int id = rs.getInt("id");
                            String title = rs.getString("title");
                            String description = rs.getString("description");
                            double price = rs.getDouble("price");
                            String expirationDate = rs.getString("expiration_date");
                            String category = rs.getString("category");
                            int qty = rs.getInt("qty");
                            String location = rs.getString("location");

                            // Display product in a card
            %>
                <div class="col-sm-4 product-card" data-category="<%= category %>" data-title="<%= title %>" data-price="<%= price %>" data-expiration="<%= expirationDate %>" data-location="<%= location %>">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title"><%= title %></h5>
                            <p class="card-text">Description: <%= description %></p>
                            <p class="card-text">Price: $<%= price %></p>
                            <p class="card-text">Expiration Date: <%= expirationDate %></p>
                            <p class="card-text">Category: <%= category %></p>
                            <p class="card-text">Quantity: <%= qty %></p>
                            <p class="card-text">Location: <%= location %></p>
                        </div>
                    </div>
                </div>
            <%
                        } while (rs.next());  // Ensure you are using a do-while loop for correct iteration
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- Custom JavaScript -->
    <script>
        // Toggle Light/Dark Mode
        document.getElementById('mode-toggle').addEventListener('click', function() {
            let body = document.getElementById('body');
            let button = document.getElementById('mode-toggle');

            if (body.classList.contains('light-mode')) {
                body.classList.remove('light-mode');
                body.classList.add('dark-mode');
                button.textContent = 'Switch to Light Mode';
            } else {
                body.classList.remove('dark-mode');
                body.classList.add('light-mode');
                button.textContent = 'Switch to Dark Mode';
            }
        });

        // Logout Button (Redirect to Login Page)
        document.getElementById('logout-button').addEventListener('click', function() {
            // Redirect to login page
            window.location.href = "login.jsp";  // Make sure the login page is named correctly
        });

        // Search Products
        document.getElementById('search-button').addEventListener('click', function() {
            searchProducts();
        });

        function searchProducts() {
            let input = document.getElementById('search-bar').value.toLowerCase();
            let cards = document.querySelectorAll('.product-card');
            let found = false;

            cards.forEach(function(card) {
                let title = card.getAttribute('data-title').toLowerCase();
                let location = card.getAttribute('data-location').toLowerCase();
                if (title.includes(input)) {
                    card.style.display = '';
                    if (!found) {
                        readProductDetails(title, location); // Read the first matching product aloud
                        found = true; // Prevent multiple readings
                    }
                } else {
                    card.style.display = 'none';
                }
            });

            if (!found) {
                // If no product matches, read "No products found"
                let speech = new SpeechSynthesisUtterance('No products found.');
                speech.lang = 'en-US';
                window.speechSynthesis.speak(speech);
            }
        }

        function readProductDetails(title, location) {
            // Construct the message to read aloud
            let message = "medicine " + title + " present in " + location;

            // Use the Web Speech API to read the message aloud
            let speech = new SpeechSynthesisUtterance(message);
            speech.lang = 'en-US';
            speech.rate = 1; // Adjust speech rate (1 is normal)
            speech.pitch = 1; // Adjust pitch (1 is normal)
            window.speechSynthesis.speak(speech);
        }

        // Microphone input functionality (Voice Search for Product)
        document.getElementById('mic-button').addEventListener('click', function() {
            let recognition = new (window.SpeechRecognition || window.webkitSpeechRecognition)();
            recognition.lang = 'en-US';
            recognition.start();

            recognition.onresult = function(event) {
                let productName = event.results[0][0].transcript.toLowerCase();
                document.getElementById('search-bar').value = productName;
                searchProducts();  // Trigger search based on voice input
            };
        });

        // Filter Products based on selected category
        function filterProducts() {
            let selectedCategory = document.getElementById('category-dropdown').value.toLowerCase();
            let cards = document.querySelectorAll('.product-card');

            cards.forEach(function(card) {
                let category = card.getAttribute('data-category').toLowerCase();
                if (selectedCategory === '' || category === selectedCategory) {
                    card.style.display = '';
                } else {
                    card.style.display = 'none';
                }
            });
        }

        // Sort Products based on selected criteria
        function sortProducts() {
            let sortBy = document.getElementById('sort-dropdown').value;
            let productContainer = document.getElementById('product-list');
            let cards = Array.from(document.querySelectorAll('.product-card'));

            cards.sort(function (a, b) {
                let aValue, bValue;

                switch (sortBy) {
                    case 'name':
                        aValue = a.getAttribute('data-title').toLowerCase();
                        bValue = b.getAttribute('data-title').toLowerCase();
                        break;
                    case 'price':
                        aValue = parseFloat(a.getAttribute('data-price'));
                        bValue = parseFloat(b.getAttribute('data-price'));
                        break;
                    case 'expiration_date':
                        aValue = new Date(a.getAttribute('data-expiration'));
                        bValue = new Date(b.getAttribute('data-expiration'));
                        break;
                }

                if (aValue < bValue) return -1;
                if (aValue > bValue) return 1;
                return 0;
            });

            // Rearrange the cards in the DOM
            cards.forEach(function (card) {
                productContainer.appendChild(card);
            });
        }
    </script>
</body>

</html>
