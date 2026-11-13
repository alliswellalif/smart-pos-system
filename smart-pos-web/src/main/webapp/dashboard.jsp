<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, org.example.DatabaseConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Smart POS - Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f6f9; margin: 0; padding: 0; }
        .header { background-color: #007bff; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .header h2 { margin: 0; }
        .logout-btn { background-color: #dc3545; color: white; border: none; padding: 8px 15px; border-radius: 4px; cursor: pointer; text-decoration: none; }
        .container { padding: 30px; max-width: 1250px; margin: auto; }
        table { width: 100%; border-collapse: collapse; background: white; margin-top: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        th, td { padding: 12px 15px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #007bff; color: white; }
        .low-stock { background-color: #f8d7da; color: #721c24; font-weight: bold; }
        .nav-btn { background-color: #28a745; color: white; padding: 10px 20px; border-radius: 4px; text-decoration: none; font-weight: bold; display: inline-block; margin-bottom: 20px; }
        .form-card { background: white; padding: 20px; border-radius: 8px; margin-bottom: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .action-btn { padding: 5px 10px; border: none; border-radius: 3px; cursor: pointer; color: white; font-weight: bold; }
        .update-btn { background-color: #ffc107; color: black; }
        .delete-btn { background-color: #dc3545; }
    </style>
</head>
<body>

    <div class="header">
        <h2>Smart POS Dashboard</h2>
        <a href="index.jsp" class="logout-btn">Logout</a>
    </div>

    <div class="container">
        <a href="pos.jsp" class="nav-btn">Go to POS / Billing</a>

        <!-- Add Product Form -->
        <div class="form-card">
            <h3>Add New Product</h3>
            <form action="productAction" method="POST" style="display: flex; gap: 10px; flex-wrap: wrap;">
                <input type="hidden" name="action" value="add">
                <input type="text" name="name" placeholder="Product Name" required style="padding: 8px; flex: 1;">
                <input type="text" name="category" placeholder="Category" required style="padding: 8px; flex: 1;">
                <input type="number" step="0.01" name="price" placeholder="Price (BDT)" required style="padding: 8px; width: 120px;">
                <input type="number" name="stock_quantity" placeholder="Stock Qty" required style="padding: 8px; width: 100px;">
                <input type="number" name="low_stock_threshold" placeholder="Threshold" value="5" required style="padding: 8px; width: 100px;">
                <button type="submit" style="background-color: #007bff; color: white; border: none; padding: 8px 15px; border-radius: 4px; cursor: pointer;">Add Product</button>
            </form>
        </div>

        <h3>Product Inventory & Stock List (10+ Items Support)</h3>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Product Name</th>
                    <th>Category</th>
                    <th>Price (BDT)</th>
                    <th>Stock</th>
                    <th>Status</th>
                    <th>Actions (Edit / Delete)</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try (Connection conn = DatabaseConnection.getConnection();
                         Statement stmt = conn.createStatement();
                         ResultSet rs = stmt.executeQuery("SELECT * FROM products")) {

                        boolean hasProducts = false;
                        while (rs.next()) {
                            hasProducts = true;
                            int id = rs.getInt("product_id");
                            String name = rs.getString("name");
                            String category = rs.getString("category");
                            double price = rs.getDouble("price");
                            int stock = rs.getInt("stock_quantity");
                            int threshold = rs.getInt("low_stock_threshold");
                            boolean isLowStock = stock <= threshold;
                %>
                <tr class="<%= isLowStock ? "low-stock" : "" %>">
                    <td><%= id %></td>
                    <td><%= name %></td>
                    <td><%= category %></td>
                    <td><%= price %></td>
                    <td><%= stock %></td>
                    <td>
                        <% if (isLowStock) { %>
                            ⚠️ Warning: Stock is running low!
                        <% } else { %>
                            Available
                        <% } %>
                    </td>
                    <td>
                        <!-- Inline Update Form -->
                        <form action="productAction" method="POST" style="display:inline-flex; gap:5px; align-items:center;">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="product_id" value="<%= id %>">
                            <input type="text" name="name" value="<%= name %>" style="width:90px; padding:3px;" required>
                            <input type="text" name="category" value="<%= category %>" style="width:80px; padding:3px;" required>
                            <input type="number" step="0.01" name="price" value="<%= price %>" style="width:70px; padding:3px;" required>
                            <input type="number" name="stock_quantity" value="<%= stock %>" style="width:50px; padding:3px;" required>
                            <button type="submit" class="action-btn update-btn">Save</button>
                        </form>

                        <!-- Delete Form -->
                        <form action="productAction" method="POST" style="display:inline; margin-left: 5px;" onsubmit="return confirm('Are you sure you want to delete this product?');">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="product_id" value="<%= id %>">
                            <button type="submit" class="action-btn delete-btn">Delete</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                        if (!hasProducts) {
                %>
                <tr>
                    <td colspan="7" style="text-align: center;">No products found in database.</td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                %>
                <tr>
                    <td colspan="7" style="text-align: center; color: red;">Error loading products: <%= e.getMessage() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

</body>
</html>