<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cybercafe.DatabaseConnection" %>
<%@ page import="java.sql.*, java.util.*" %>
<html>
<head>
    <title>Delete Computer</title>
</head>
<body>
    <h1>Delete Computer</h1>
    <%
        String computerId = request.getParameter("computer_id");
        Connection conn = null;
        PreparedStatement pstmt = null;

        if (computerId != null) {
            try {
                int compId = Integer.parseInt(computerId);
                conn = DatabaseConnection.getConnection();
                String sql = "DELETE FROM computers WHERE computer_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, compId);

                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
        %>
                    <h3>Computer deleted successfully!</h3>
        <%
                } else {
        %>
                    <h3>Error: Computer not found or could not be deleted.</h3>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
        %>
                <h3>Error: <%= e.getMessage() %></h3>
        <%
            } catch (NumberFormatException e) {
        %>
                <h3>Error: Invalid computer ID format.</h3>
        <%
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
    <a href="manage_computers.jsp">Back to Manage Computers</a>
</body>
</html>
