public class InventoryTest {
    public static void main(String[] args) {
        InventoryManagement inventory = new InventoryManagement();

        System.out.println("=== Inventory Management System ===\n");

        System.out.println("--- Adding Products ---");
        inventory.addProduct(new Product(101, "Laptop", 50, 799.99));
        inventory.addProduct(new Product(102, "Mouse", 200, 25.99));
        inventory.addProduct(new Product(103, "Keyboard", 150, 79.99));
        inventory.addProduct(new Product(104, "Monitor", 80, 299.99));

        inventory.displayAllProducts();

        System.out.println("--- Updating Product ---");
        inventory.updateProduct(102, 250, 29.99);
        inventory.displayAllProducts();

        System.out.println("--- Searching Product ---");
        Product found = inventory.searchProduct(103);
        if (found != null) {
            System.out.println("Found: " + found);
        }
        System.out.println();

        System.out.println("--- Deleting Product ---");
        inventory.deleteProduct(104);
        inventory.displayAllProducts();

        System.out.println("Total products in inventory: " + inventory.getInventorySize());

        System.out.println("\n=== Time Complexity Analysis ===");
        System.out.println("Using ArrayList Data Structure:");
        System.out.println("1. Add Product: O(1) - Constant time");
        System.out.println("2. Update Product: O(n) - Linear time (need to search for product)");
        System.out.println("3. Delete Product: O(n) - Linear time (need to search and remove)");
        System.out.println("4. Search Product: O(n) - Linear time (linear search required)");
        System.out.println("5. Display All: O(n) - Linear time (iterate through all products)");

        System.out.println("\n=== Optimization Notes ===");
        System.out.println("To optimize search, update, and delete operations:");
        System.out.println("- Use HashMap with productId as key for O(1) average time complexity");
        System.out.println("- This would improve update and delete operations to O(1)");
    }
}
