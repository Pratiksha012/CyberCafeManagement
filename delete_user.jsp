<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="cybercafe.DatabaseConnection" %>

<html>
<head>
    <title>Delete User</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        
        .message {
            background-color: #ffffff;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        a {
            color: #007bff;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <h1>Delete User</h1>
    <%
        String userId = request.getParameter("user_id");
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "DELETE FROM users WHERE user_id = ?";
            pstmt = conn.prepareStatement(sql);
            int id = Integer.parseInt(userId);
            pstmt.setInt(1, id);
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
    %>
                <div class="message">
                    <p>User deleted successfully.</p>
                    <a href="view_users.jsp">Go back to user list</a>
                </div>
    <%
            } else {
    %>
                <div class="message">
                    <p>Error deleting user: User ID not found.</p>
                    <a href="view_users.jsp">Go back to user list</a>
                </div>
    <%
            }
        } catch (NumberFormatException e) {
    %>
            <div class="message">
                <p>Error: Invalid user ID format.</p>
                <a href="view_users.jsp">Go back to user list</a>
            </div>
    <%
        } catch (SQLException e) {
    %>
            <div class="message">
                <p>Error deleting user: <%= e.getMessage() %></p>
                <a href="view_users.jsp">Go back to user list</a>
            </div>
    <%
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
