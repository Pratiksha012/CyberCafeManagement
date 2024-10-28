<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.SQLException" %>
<%@ page import="cybercafe.DatabaseConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Computer</title>
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

        input[type="text"], select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1em;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus, select:focus {
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

        .message {
            margin-top: 15px;
            text-align: center;
            font-weight: bold;
        }

        .success {
            color: green;
        }

        .error {
            color: red;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Add New Computer</h1>

        <%
            String message = "";
            String messageType = "";

            if(request.getMethod().equalsIgnoreCase("POST")) {
                String computerName = request.getParameter("computer_name");
                String status = request.getParameter("status");

                Connection conn = null;
                PreparedStatement pstmt = null;

                try {
                    conn = DatabaseConnection.getConnection();
                    String sql = "INSERT INTO computers (computer_name, status) VALUES (?, ?)";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, computerName);
                    pstmt.setString(2, status);

                    int rowsAffected = pstmt.executeUpdate();

                    if (rowsAffected > 0) {
                        message = "Computer added successfully!";
                        messageType = "success";
                    } else {
                        message = "Error adding computer. Please try again.";
                        messageType = "error";
                    }
                } catch (SQLException e) {
                    message = "SQL Error: " + e.getMessage();
                    messageType = "error";
                } catch (ClassNotFoundException e) {
                    message = "Database driver not found.";
                    messageType = "error";
                } finally {
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                }
            }
        %>

        <form action="add_computer.jsp" method="post">
            <label for="computer_name">Computer Name:</label>
            <input type="text" id="computer_name" name="computer_name" required>

            <label for="status">Status:</label>
            <select id="status" name="status" required>
                <option value="Available">Available</option>
                <option value="In Use">In Use</option>
                <option value="Maintenance">Maintenance</option>
            </select>

            <input type="submit" value="Add Computer">
        </form>

        <a class="back-link" href="manage_computers.jsp">Back to Manage Computers</a>

        <% if (!message.isEmpty()) { %>
            <p class="message <%= messageType %>"><%= message %></p>
        <% } %>
    </div>
</body>
</html>
