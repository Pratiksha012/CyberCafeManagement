<%@ page import="cybercafe.DatabaseConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

        nav {
            background-color: #007BFF;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            flex-direction: column; 
            align-items: flex-start;
        }

        nav ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        nav ul li {
            margin-bottom: 10px; 
        }

        nav ul li a {
            color: white;
            text-decoration: none;
            font-weight: bold;
            padding: 10px 15px; 
            border-radius: 5px; 
            transition: background-color 0.3s, transform 0.2s; 
        }

        nav ul li a:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
        }

        .dashboard-content {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .overview {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            background-color: #007BFF;
            padding: 10px;
            border-radius: 5px;
        }

        .overview div {
            flex: 1;
            background-color: white;
            border: none;
            border-radius: 5px;
            padding: 15px;
            margin-right: 20px;
            text-align: center;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .overview div:last-child {
            margin-right: 0;
        }

        .overview div:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        footer {
            text-align: center;
            margin-top: 20px;
            font-size: 0.9em;
            color: #777;
        }

        .chart-container {
            width: 100%;
            height: 400px;
            margin-top: 30px;
        }

        .logout-button {
            background-color: #FF5733;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 15px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
            margin-top: 20px;
        }

        .logout-button:hover {
            background-color: #C70039;
            transform: translateY(-2px);
        }
        @media (max-width: 600px) {
            .overview {
                flex-direction: column;
            }

            .overview div {
                margin-right: 0;
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>
    <h1>Admin Dashboard</h1>
    <h2>Welcome, Admin!</h2>
    <div class="dashboard-content">
        <h3>Overview</h3>
        <div class="overview">
            <div onclick="location.href='view_users.jsp'" title="Manage Users">
                <h4>Total Users</h4>
                <p>
                    <%
                        int totalUsers = 0;
                        try {
                            Connection conn = DatabaseConnection.getConnection();
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS count FROM users");
                            if (rs.next()) {
                                totalUsers = rs.getInt("count");
                            }
                            conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    %>
                    <%= totalUsers %>
                </p>
            </div>
            <div onclick="location.href='manage_computers.jsp'" title="Manage Computers">
                <h4>Total Computers</h4>
                <p>
                    <%
                        int totalComputers = 0;
                        try {
                            Connection conn = DatabaseConnection.getConnection();
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS count FROM computers");
                            if (rs.next()) {
                                totalComputers = rs.getInt("count");
                            }
                            conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    %>
                    <%= totalComputers %>
                </p>
            </div>
            <div onclick="location.href='view_transactions.jsp'" title="View Transactions">
                <h4>Total Reservations</h4>
                <p>
                    <%
                        int totalReservations = 0;
                        try {
                            Connection conn = DatabaseConnection.getConnection();
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS count FROM reservations");
                            if (rs.next()) {
                                totalReservations = rs.getInt("count");
                            }
                            conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    %>
                    <%= totalReservations %>
                </p>
            </div>
        </div>

        <!-- Chart Section -->
        <h3>Usage Statistics</h3>
        <div class="chart-container">
            <canvas id="usageChart"></canvas>
        </div>

        <!-- Logout Button -->
        <form action="logout.jsp" method="post">
            <button type="submit" class="logout-button">Logout</button>
        </form>
    </div>

    <footer>
        <p>&copy; Pixel Hub 2024</p>
    </footer>

    <script>
        const ctx = document.getElementById('usageChart').getContext('2d');
        const usageChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Users', 'Computers', 'Reservations'],
                datasets: [{
                    label: '# of Entries',
                    data: [
                        <%= totalUsers %>,
                        <%= totalComputers %>,
                        <%= totalReservations %>
                    ],
                    backgroundColor: [
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                    ],
                    borderColor: [
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                },
                responsive: true,
                maintainAspectRatio: false
            }
        });
    </script>
</body>
</html>
