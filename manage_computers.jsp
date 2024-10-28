<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cybercafe.DatabaseConnection"%>
<%@ page import="java.sql.*, java.util.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Computers</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 20px;
            background: linear-gradient(to right, #f0f4f8, #d9e7f2);
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
            font-size: 2.5em;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #007bff;
            margin-top: 20px;
            font-size: 1.8em;
            text-align: center;
        }
        .container {
            max-width: 1200px;
            width: 100%;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd;
            transition: background-color 0.3s, transform 0.2s;
        }
        th {
            background-color: #007bff;
            color: white;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        tr {
            transition: background-color 0.3s;
        }
        tr:hover {
            background-color: #e9f5ff;
            transform: scale(1.01);
        }
        .button {
            display: inline-block;
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
            margin-top: 10px;
            transition: background-color 0.3s, transform 0.2s;
        }
        .button:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
        }
        .delete-button {
            background-color: #dc3545;
        }
        .delete-button:hover {
            background-color: #c82333;
        }
        form {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin: 10px 0 5px;
            font-weight: bold;
        }
        input[type="text"], select {
            width: calc(100% - 22px);
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1em;
            transition: border-color 0.3s;
        }
        input[type="text"]:focus, select:focus {
            border-color: #007bff;
            outline: none;
        }
        @media (max-width: 768px) {
            h1 {
                font-size: 2em;
            }
            h2 {
                font-size: 1.5em;
            }
        }
    </style>
</head>
<body>
    <h1>Manage Computers</h1>
    
    <div class="container">
        <!-- Form to Add New Computer -->
        <form action="AddComputerServlet" method="post">
            <h2>Add New Computer</h2>
            
            <label for="computer_name">Computer Name:</label>
            <input type="text" name="computer_name" required><br>
            
            <label for="status">Status:</label>
            <select name="status" required>
                <option value="available">Available</option>
                <option value="in_use">In Use</option>
            </select><br>
            
            <input type="submit" class="button" value="Add Computer">
            <a class="button" href="adminDashboard.jsp">Home</a>
        </form>

        <table>
            <tr>
                <th>Computer ID</th>
                <th>Computer Name</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    conn = DatabaseConnection.getConnection();
                    String sql = "SELECT * FROM computers";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(sql);
                    while (rs.next()) {
            %>
                <tr>
                    <td><%= rs.getInt("computer_id") %></td> <!-- Fetching computer_id as int -->
                    <td><%= rs.getString("computer_name") %></td> <!-- Updated to match table -->
                    <td><%= rs.getString("status") %></td>
                    <td>
                        <a href="delete_computer.jsp?computer_id=<%= rs.getInt("computer_id") %>" class="button delete-button">Delete</a>
                    </td>
                </tr>
            <%
                    }
                } catch (SQLException e) {
                    out.println("<p>Error fetching computers: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </table>
    </div>
</body>
</html>
