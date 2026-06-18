import java.util.ArrayList;

public class InventoryManagement {
    private ArrayList<Product> inventory;

    public InventoryManagement() {
        this.inventory = new ArrayList<>();
    }

    public void addProduct(Product product) {
        inventory.add(product);
        System.out.println("Product added: " + product.getProductName());
    }

    public void updateProduct(int productId, int newQuantity, double newPrice) {
        for (Product product : inventory) {
            if (product.getProductId() == productId) {
                product.setQuantity(newQuantity);
                product.setPrice(newPrice);
                System.out.println("Product updated: " + product.getProductName());
                return;
            }
        }
        System.out.println("Product with ID " + productId + " not found.");
    }

    public void deleteProduct(int productId) {
        for (int i = 0; i < inventory.size(); i++) {
            if (inventory.get(i).getProductId() == productId) {
                String productName = inventory.get(i).getProductName();
                inventory.remove(i);
                System.out.println("Product deleted: " + productName);
                return;
            }
        }
        System.out.println("Product with ID " + productId + " not found.");
    }

    public Product searchProduct(int productId) {
        for (Product product : inventory) {
            if (product.getProductId() == productId) {
                return product;
            }
        }
        return null;
    }

    public void displayAllProducts() {
        if (inventory.isEmpty()) {
            System.out.println("Inventory is empty.");
            return;
        }
        System.out.println("\n=== Current Inventory ===");
        for (Product product : inventory) {
            System.out.println(product);
        }
        System.out.println();
    }

    public int getInventorySize() {
        return inventory.size();
    }
}
