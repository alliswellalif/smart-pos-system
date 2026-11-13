<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.Product" %>
<%@ page import="org.example.ProductDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Smart POS - Billing & Sales</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 25px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: bold;
        }
        .form-group select, .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn-sale {
            width: 100%;
            padding: 12px;
            background-color: #28a745;
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
        .btn-sale:hover {
            background-color: #218838;
        }
        .discount-info {
            background-color: #e2f0d9;
            color: #385723;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
            font-size: 14px;
            text-align: center;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Smart POS - Complete Sale / Billing</h2>

    <div class="discount-info">
        🎉 Special Offer: Orders above 5,000 BDT will automatically get a 10% Dynamic Discount!
    </div>

    <form action="completeSaleServlet" method="post">
        <div class="form-group">
            <label for="productId">Select Product</label>
            <select id="productId" name="productId" required>
                <option value="">-- Choose a Product --</option>
                <%
                    ProductDAO productDAO = new ProductDAO();
                    List<Product> products = productDAO.getAllProducts();
                    if (products != null) {
                        for (Product p : products) {
                %>
                <option value="<%= p.getId() %>"><%= p.getName() %> - Price: BDT <%= p.getPrice() %> (Stock: <%= p.getStockQuantity() %>)</option>
                <%
                        }
                    }
                %>
            </select>
        </div>

        <div class="form-group">
            <label for="quantity">Quantity</label>
            <input type="number" id="quantity" name="quantity" min="1" value="1" required>
        </div>

        <button type="submit" class="btn-sale">Complete Sale & Update Stock</button>
    </form>
</div>

</body>
</html>