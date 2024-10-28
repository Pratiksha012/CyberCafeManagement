<%@page import="cybercafe.DatabaseConnection"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            color: #333;
            margin: 0;
            padding: 20px;
        }

        header {
            background-color: #007BFF;
            color: white;
            padding: 15px;
            text-align: center;
            border-radius: 8px;
        }

        h1 {
            margin: 0;
        }

        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            margin-top: 20px;
        }

        .card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin: 10px;
            padding: 20px;
            width: 30%;
            transition: transform 0.2s;
        }

        .card:hover {
            transform: scale(1.05);
        }

        .card h2 {
            font-size: 1.5em;
            margin-bottom: 10px;
        }

        .card p {
            margin: 0;
        }

        .button {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 15px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            border-radius: 5px;
            margin-top: 10px;
            cursor: pointer;
        }

        .button:hover {
            background-color: #0056b3;
        }

        footer {
            text-align: center;
            margin-top: 20px;
            font-size: 0.9em;
            color: #777;
        }
    </style>
</head>
<body>
    <header>
        <h1>Welcome, <%= request.getSession().getAttribute("username") %>!</h1>
    </header>

    <div class="container">
        <div class="card">
            <h2>Games Zone</h2>
            <p>Enjoy a variety of games available in our Cyber Café.</p>
            <button class="button" onclick="window.location.href='games.jsp'">Explore Games</button>
        </div>

        <div class="card">
            <h2>Browse the Web</h2>
            <p>Access the latest news, social media, and entertainment.</p>
            <button class="button" onclick="window.location.href='browser.jsp'">Start Browsing</button>
        </div>

        <div class="card">
            <h2>Profile Management</h2>
            <p>Update your profile and view your membership details.</p>
            <button class="button" onclick="window.location.href='edit_user.jsp'">Edit Profile</button>
        </div>

        <div class="card">
            <h2>Support Center</h2>
            <p>Need help? Contact our support team for assistance.</p>
            <button class="button" onclick="window.location.href='support.jsp'">Get Support</button>
        </div>

        <div class="card">
            <h2>Billing History</h2>
            <p>View your billing details and transaction history.</p>
            <button class="button" onclick="window.location.href='billing_history.jsp'">View History</button>
        </div>

        <div class="card">
            <h2>Logout</h2>
            <p>Log out of your account safely.</p>
            <button class="button" onclick="window.location.href='logout.jsp'">Logout</button>
        </div>
    </div>

    <footer>
        <p>&copy; Pixel Hub 2024 </p>
    </footer>
</body>
</html>
