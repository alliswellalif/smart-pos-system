package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import org.example.Product;
import org.example.ProductDAO;

@WebServlet("/completesaleServlet")
public class CompleteSaleServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productId);

        if (product != null && product.getStockQuantity() >= quantity) {
            double unitPrice = product.getPrice();
            double totalPrice = unitPrice * quantity;

            if (totalPrice > 5000) {
                totalPrice = totalPrice - (totalPrice * 0.10);
            }
        }
    }
}