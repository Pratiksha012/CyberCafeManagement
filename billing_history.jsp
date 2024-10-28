<%@page import="cybercafe.DatabaseConnection"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*, java.util.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Billing History</title>
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

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #007BFF;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #ddd;
        }

        .pay-now {
            background-color: #007BFF;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
        }

        .pay-now:hover {
            background-color: #0056b3;
        }

        footer {
            text-align: center;
            margin-top: 20px;
            font-size: 0.9em;
            color: #777;
        }
        .button {
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
            margin-top: 10px;
            display: inline-block;
        }
        .button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <header>
        <h1>Billing History for <%= request.getSession().getAttribute("username") != null ? request.getSession().getAttribute("username") : "Guest" %></h1>
    </header>

    <h2>Your Billing Details</h2>

    <table>
        <tr>
            <th>Date</th>
            <th>Duration (Hours)</th>
            <th>Amount (₹)</th>
        </tr>
        <%
            double totalAmount = 0.0;
            Integer userId = (Integer) request.getSession().getAttribute("user_id");
            if (userId == null) {
                out.println("<tr><td colspan='3'>You must be logged in to view billing history.</td></tr>");
            } else {
                try {
                    Connection conn = DatabaseConnection.getConnection();
                    String sql = "SELECT start_time, end_time FROM sessions WHERE user_id = ?";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, userId);
                    ResultSet rs = pstmt.executeQuery();

                    while (rs.next()) {
                        Timestamp startTime = rs.getTimestamp("start_time");
                        Timestamp endTime = rs.getTimestamp("end_time");

                        if (endTime != null) {
                            long durationInMillis = endTime.getTime() - startTime.getTime();
                            double durationInHours = (double) durationInMillis / (1000 * 60 * 60);
                            double amount = durationInHours * 20; // Assuming 20₹ per hour
                            totalAmount += amount;

                            %>
                            <tr>
                                <td><%= startTime.toLocalDateTime().toLocalDate() %></td>
                                <td><%= String.format("%.2f", durationInHours) %></td>
                                <td>₹ <%= String.format("%.2f", amount) %></td>
                            </tr>
                            <%
                        }
                    }
                    conn.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='3'>Error fetching billing history: " + e.getMessage() + "</td></tr>");
                }
            }
        %>
        <tr>
            <td colspan="2"><strong>Total Amount</strong></td>
            <td><strong>₹ <%= String.format("%.2f", totalAmount) %></strong></td>
        </tr>
    </table>

    <button class="pay-now" onclick="window.location.href='payment.jsp'">Pay Now</button>
    <a href="userDashboard.jsp" class="button">Home</a>

    <footer>
        <p>&copy; Pixel Hub 2024</p>
    </footer>
</body>
</html>
