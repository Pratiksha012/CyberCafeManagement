<%@ page import="java.sql.*, javax.servlet.http.*, cybercafe.DatabaseConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Pixel Hub</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background: linear-gradient(120deg, #f0f4f8, #007BFF);
        }

        .registration-container {
            background-color: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            text-align: left;
            animation: fadeIn 0.5s ease-in-out;
            width: 100%;
            max-width: 400px;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        h1 {
            color: #007BFF;
            text-align: center;
            margin-bottom: 20px;
        }

        label {
            font-size: 1.1em;
            margin: 10px 0;
            display: block;
        }

        input {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            font-size: 1em;
            transition: border-color 0.3s;
        }

        input:focus {
            border-color: #007BFF;
            outline: none;
        }

        button {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 15px 25px;
            border-radius: 50px;
            font-size: 1.2em;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
        }

        button:hover {
            background-color: #0056b3;
            transform: translateY(-3px);
        }

        .link {
            margin-top: 15px;
        }

        .link a {
            color: #007bff;
            text-decoration: none;
        }

        .link a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: red;
            margin-top: 10px;
        }

        .success-message {
            color: green;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="registration-container">
        <h1>Register for Pixel Hub</h1>
        <form method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <button type="submit">Register</button>
        </form>

        <div class="link">
            <p>Already have an account? <a href="login.jsp">Login here</a></p>
        </div>

        <c:if test="${not empty param.success}">
            <p class="success-message">${param.success}</p>
        </c:if>
        <c:if test="${not empty param.error}">
            <p class="error-message">${param.error}</p>
        </c:if>

        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String email = request.getParameter("email");
                Connection conn = null;
                PreparedStatement pstmt = null;

                try {
                    conn = DatabaseConnection.getConnection();
                    String sql = "INSERT INTO users (username, password, email) VALUES (?, ?, ?)";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, username);
                    pstmt.setString(2, password);
                    pstmt.setString(3, email);

                    int rowsAffected = pstmt.executeUpdate();

                    if (rowsAffected > 0) {
                        response.sendRedirect("registration.jsp?success=Registration successful! Please log in.");
                    } else {
                        response.sendRedirect("registration.jsp?error=Registration failed. Please try again.");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("registration.jsp?error=A database error occurred. Please try again.");
                } finally {
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
                }
            }
        %>
    </div>
</body>
</html>
