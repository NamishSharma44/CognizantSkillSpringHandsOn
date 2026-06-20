class Product {

    int productId;
    String productName;
    String category;

    public Product(int productId, String productName, String category) {
        this.productId = productId;
        this.productName = productName;
        this.category = category;
    }

    public void display() {
        System.out.println(productId + " " + productName + " " + category);
    }
}

public class SearchProduct {

    public static Product linearSearch(Product[] products, int id) {

        for (Product p : products) {

            if (p.productId == id) {
                return p;
            }

        }

        return null;
    }

    public static Product binarySearch(Product[] products, int id) {

        int low = 0;
        int high = products.length - 1;

        while (low <= high) {

            int mid = (low + high) / 2;

            if (products[mid].productId == id)

                return products[mid];

            else if (id < products[mid].productId)

                high = mid - 1;

            else

                low = mid + 1;

        }

        return null;
    }

    public static void main(String[] args) {

        Product[] products = {

                new Product(101, "Laptop", "Electronics"),
                new Product(102, "Mouse", "Electronics"),
                new Product(103, "Keyboard", "Electronics"),
                new Product(104, "Monitor", "Electronics"),
                new Product(105, "Speaker", "Electronics")

        };

        System.out.println("Linear Search");

        Product p1 = linearSearch(products, 103);

        if (p1 != null)
            p1.display();

        System.out.println("\nBinary Search");

        Product p2 = binarySearch(products, 104);

        if (p2 != null)
            p2.display();

    }
}