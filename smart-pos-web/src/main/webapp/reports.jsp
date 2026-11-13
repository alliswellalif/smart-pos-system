<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.example.DatabaseConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Smart POS - Sales Report & History</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 900px;
            margin: auto;
            background: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #333;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #343a40;
            color: white;
        }
        .nav-links {
            text-align: center;
            margin-bottom: 20px;
        }
        .nav-links a {
            text-decoration: none;
            background-color: #007bff;
            color: white;
            padding: 8px 15px;
            border-radius: 4px;
            margin: 0 5px;
        }
        .nav-links a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Smart POS - Sales History & Reports</h2>

    <div class="nav-links">
        <a href="dashboard.jsp">Dashboard</a>
        <a href="pos.jsp">New Sale</a>
    </div>

    <table>
        <thead>
            <tr>
                <th>Sale ID</th>
                <th>Total Amount (BDT)</th>
                <th>Sale Date</th>
            </tr>
        </thead>
        <tbody>
            <%
                try (Connection conn = DatabaseConnection.getConnection();
                     Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery("SELECT * FROM sales ORDER BY sale_date DESC")) {

                    boolean hasData = false;
                    while (rs.next()) {
                        hasData = true;
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getDouble("total_amount") %></td>
                <td><%= rs.getTimestamp("sale_date") %></td>
            </tr>
            <%
                    }
                    if (!hasData) {
            %>
            <tr>
                <td colspan="3">No sales history found.</td>
            </tr>
            <%
                    }
                } catch (Exception e) {
            %>
            <tr>
                <td colspan="3">Error loading sales report: <%= e.getMessage() %></td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

</body>
</html>