package org.example;

import org.example.CartItem;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class SalesDAO {

    public void completeSale(int userId, double totalAmount, List<CartItem> cartItems) {
        String insertSale = "INSERT INTO sales (user_id, total_amount) VALUES (?, ?)";
        String insertSaleItem = "INSERT INTO sale_items (sale_id, product_id, quantity, subtotal) VALUES (?, ?, ?, ?)";
        String updateStock = "UPDATE products SET stock_quantity = stock_quantity - ? WHERE id = ?";

        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false); // Transaction start

            // Sale processing logic here...

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}