package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/productAction")
public class ProductActionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try (Connection conn = DatabaseConnection.getConnection()) {
            if ("add".equals(action)) {
                String name = request.getParameter("name");
                String category = request.getParameter("category");
                double price = Double.parseDouble(request.getParameter("price"));
                int stock = Integer.parseInt(request.getParameter("stock_quantity"));
                int threshold = Integer.parseInt(request.getParameter("low_stock_threshold"));

                String sql = "INSERT INTO products (name, category, price, stock_quantity, low_stock_threshold) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, name);
                    stmt.setString(2, category);
                    stmt.setDouble(3, price);
                    stmt.setInt(4, stock);
                    stmt.setInt(5, threshold);
                    stmt.executeUpdate();
                }
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("product_id"));
                String name = request.getParameter("name");
                String category = request.getParameter("category");
                double price = Double.parseDouble(request.getParameter("price"));
                int stock = Integer.parseInt(request.getParameter("stock_quantity"));

                String sql = "UPDATE products SET name = ?, category = ?, price = ?, stock_quantity = ? WHERE product_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, name);
                    stmt.setString(2, category);
                    stmt.setDouble(3, price);
                    stmt.setInt(4, stock);
                    stmt.setInt(5, id);
                    stmt.executeUpdate();
                }
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("product_id"));

                String sql = "DELETE FROM products WHERE product_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, id);
                    stmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("dashboard.jsp");
    }
}