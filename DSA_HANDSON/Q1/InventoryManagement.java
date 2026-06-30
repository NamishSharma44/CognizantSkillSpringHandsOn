import java.util.*;
class Product {

    int productId;
    String productName;
    int quantity;
    double price;

    public Product(int productId, String productName, int quantity, double price) {
        this.productId = productId;
        this.productName = productName;
        this.quantity = quantity;
        this.price = price;
    }

    public void display() {
        System.out.println("Product ID : " + productId);
        System.out.println("Name       : " + productName);
        System.out.println("Quantity   : " + quantity);
        System.out.println("Price      : " + price);
        System.out.println("------------------------");
    }
}

// import java.util.HashMap;

public class InventoryManagement {

    HashMap<Integer, Product> inventory = new HashMap<>();

    // Add Product
    public void addProduct(Product product) {

        inventory.put(product.productId, product);

        System.out.println("Product Added Successfully.");
    }

    

    public void updateProduct(int id, int quantity, double price) {

        if (inventory.containsKey(id)) {

            Product p = inventory.get(id);

            p.quantity = quantity;
            p.price = price;

            System.out.println("Product Updated.");
        } else {

            System.out.println("Product Not Found.");
        }
    }

    
    public void deleteProduct(int id) {

        if (inventory.containsKey(id)) {

            inventory.remove(id);

            System.out.println("Product Deleted.");

        } else {

            System.out.println("Product Not Found.");
        }
    }

    

    public void displayInventory() {

        for (Product p : inventory.values()) {

            p.display();
        }
    }

    public static void main(String[] args) {

        InventoryManagement obj = new InventoryManagement();

        obj.addProduct(new Product(101, "Laptop", 10, 55000));

        obj.addProduct(new Product(102, "Mouse", 50, 500));

        obj.addProduct(new Product(103, "Keyboard", 25, 1000));

        System.out.println("\nInventory");

        obj.displayInventory();

        obj.updateProduct(102, 80, 450);

        obj.deleteProduct(103);

        System.out.println("\nUpdated Inventory");

        obj.displayInventory();
    }
}