<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="cybercafe.DatabaseConnection" %>

<html>
<head>
    <title>User List</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .button {
            background-color: #007bff; /* Blue */
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
        }

        .button:hover {
            background-color: #0056b3; /* Darker Blue */
        }

        .add-user-button {
            display: inline-block;
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <h1>User List</h1>
    <table border="1">
        <tr>
            <th>User ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Actions</th>
        </tr>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                // Database connection and fetching user data
                conn = DatabaseConnection.getConnection(); // Make sure DatabaseConnection is properly imported
                String sql = "SELECT * FROM users";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);
                while (rs.next()) {
        %>
                    <tr>
                        <td><%= rs.getString("user_id") %></td>
                        <td><%= rs.getString("username") %></td>
                        <td><%= rs.getString("email") %></td>
                        <td>
                            <a href="delete_user.jsp?user_id=<%= rs.getString("user_id") %>">Delete</a>
                        </td>
                    </tr>
        <%
                }
            } catch (SQLException e) {
                out.println("<p>Error fetching users: " + e.getMessage() + "</p>");
                e.printStackTrace(); // Good for debugging
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
    <a class="button" href="add_user.jsp">Add User</a>
    <a class="button" href="adminDashboard.jsp">Home</a>
</body>
</html>