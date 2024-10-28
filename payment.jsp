<%@ page import="cybercafe.DatabaseConnection" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String paymentMethod = request.getParameter("method");
    if (paymentMethod != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DatabaseConnection.getConnection();
            
            // Increment the transaction count
            String sql = "UPDATE transactions SET transaction_count = transaction_count + 1 WHERE id = 1";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();

            // Redirect to the logout page after incrementing the transaction count
            response.sendRedirect("logout.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Error processing payment");
        } finally {
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Options</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            color: #333;
            padding: 20px;
        }

        h1 {
            color: #007BFF;
        }

        .payment-option {
            margin: 15px 0;
            padding: 10px;
            border: 1px solid #007BFF;
            border-radius: 5px;
            background-color: #fff;
            cursor: pointer;
        }

        .payment-option:hover {
            background-color: #007BFF;
            color: white;
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
    <h1>Select Payment Method</h1>

    <div class="payment-option" onclick="window.location.href='payment.jsp?method=UPI'">UPI</div>
    <div class="payment-option" onclick="window.location.href='payment.jsp?method=Credit/Debit'">Credit/Debit Card</div>
    <div class="payment-option" onclick="window.location.href='payment.jsp?method=Cash'">Cash</div>

    <footer>
        <p>&copy; Pixel Hub 2024</p>
    </footer>
</body>
</html>
