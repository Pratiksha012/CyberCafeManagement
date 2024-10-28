<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>View Transactions</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 20px;
        }

        h1 {
            color: #007BFF;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #007BFF;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        footer {
            text-align: center;
            margin-top: 20px;
            font-size: 0.9em;
            color: #777;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 15px;
            background-color: #007BFF;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h1>Transaction History</h1>

    <table>
        <thead>
            <tr>
                <th>Transaction ID</th>
                <th>User ID</th>
                <th>Computer ID</th>
                <th>Start Time</th>
                <th>End Time</th>
                <th>Total Amount</th>
            </tr>
        </thead>
        <tbody>
            <%
                String url = "jdbc:postgresql://localhost:5433/cyber_cafe_management";
                String username = "postgres";
                String password = "Dragoon8870!";
                try {
                    Class.forName("org.postgresql.Driver");
                    Connection conn = DriverManager.getConnection(url, username, password);
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM transaction");

                    while (rs.next()) {
                        int transactionId = rs.getInt("transaction_id");
                        int userId = rs.getInt("user_id");
                        int computerId = rs.getInt("computer_id");
                        Timestamp startTime = rs.getTimestamp("start_time");
                        Timestamp endTime = rs.getTimestamp("end_time");
                        double totalAmount = rs.getDouble("total_amount");

                        out.println("<tr>");
                        out.println("<td>" + transactionId + "</td>");
                        out.println("<td>" + userId + "</td>");
                        out.println("<td>" + computerId + "</td>");
                        out.println("<td>" + startTime + "</td>");
                        out.println("<td>" + endTime + "</td>");
                        out.println("<td>" + totalAmount + "</td>");
                        out.println("</tr>");
                    }
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<tr><td colspan='6'>Error retrieving transactions</td></tr>");
                }
            %>
        </tbody>
    </table>

    <a href="adminDashboard.jsp">Back to Dashboard</a>

    <footer>
        <p>&copy; Pixel Hub 2024</p>
    </footer>
</body>
</html>
