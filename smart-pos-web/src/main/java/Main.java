package org.example;

import org.example.Product;
import org.example.ProductDAO;
import org.example.SalesDAO;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        System.out.println("Inventory & POS System Started...");

        ProductDAO productDAO = new ProductDAO();
        SalesDAO salesDAO = new SalesDAO();

        System.out.println("\n--- Current Product List & Stock Check ---");
        List<Product> products = productDAO.getAllProducts();
        for (Product p : products) {
            System.out.println("Product: " + p.getName() + " | Price: " + p.getPrice());
        }
    }
}