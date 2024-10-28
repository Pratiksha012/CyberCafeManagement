<%@page import="cybercafe.DatabaseConnection"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add User</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        h1 {
            color: #007bff;
            text-align: center;
        }

        .form-container {
            width: 100%;
            max-width: 400px;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin: 10px 0 5px;
            font-weight: bold;
        }

        input[type="text"], input[type="password"], input[type="email"], select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1em;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus, input[type="password"]:focus, input[type="email"]:focus, select:focus {
            border-color: #007bff;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            font-size: 1em;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
        }

        .back-link {
            display: block;
            margin-top: 15px;
            text-align: center;
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }

        .back-link:hover {
            color: #0056b3;
            text-decoration: underline;
        }

        .error-message {
            color: red;
            margin-top: 10px;
            text-align: center;
        }

        .success-message {
            color: green;
            margin-top: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Add New User</h1>

        <%
            String message = "";
            if(request.getMethod().equalsIgnoreCase("POST")) {
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String role = request.getParameter("role");

                Connection conn = null;
                PreparedStatement pstmt = null;
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DatabaseConnection.getConnection();

                    String sql = "INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?)";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, username);
                    pstmt.setString(2, email);
                    pstmt.setString(3, password);
                    pstmt.setString(4, role);
                    int rowsInserted = pstmt.executeUpdate();

                    if (rowsInserted > 0) {
                        message = "User added successfully!";
                    }
                } catch (SQLException e) {
                    message = "Error adding user: " + e.getMessage();
                } catch (ClassNotFoundException e) {
                    message = "Database driver not found.";
                } finally {
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                }
            }
        %>

        <form action="add_user.jsp" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <label for="role">Role:</label>
            <select id="role" name="role" required>
                <option value="admin">Admin</option>
                <option value="user">User</option>
            </select>

            <input type="submit" value="Add User">
        </form>

        <a class="back-link" href="view_users.jsp">Back to User List</a>

        <!-- Display message -->
        <% if (!message.isEmpty()) { %>
            <p class="<%= message.contains("Error") ? "error-message" : "success-message" %>"><%= message %></p>
        <% } %>
    </div>
</body>
</html>
