class Book {

    int bookId;
    String title;
    String author;

    public Book(int bookId, String title, String author) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
    }

    public void display() {
        System.out.println(bookId + " " + title + " " + author);
    }
}
public class LibraryManagement {

    public static Book linearSearch(Book[] books, String title) {

        for (Book b : books) {

            if (b.title.equalsIgnoreCase(title))

                return b;

        }

        return null;
    }

    public static Book binarySearch(Book[] books, String title) {

        int low = 0;
        int high = books.length - 1;

        while (low <= high) {

            int mid = (low + high) / 2;

            int result = books[mid].title.compareToIgnoreCase(title);

            if (result == 0)

                return books[mid];

            else if (result > 0)

                high = mid - 1;

            else

                low = mid + 1;

        }

        return null;
    }

    public static void main(String[] args) {

        // Array must be sorted by title for Binary Search
        Book[] books = {

                new Book(104, "Database Systems", "Alice"),
                new Book(102, "Data Structures", "Mark"),
                new Book(101, "Java Programming", "James"),
                new Book(103, "Operating Systems", "John")

        };

        System.out.println("Linear Search:");

        Book b1 = linearSearch(books, "Java Programming");

        if (b1 != null)

            b1.display();

        System.out.println("\nBinary Search:");

        Book b2 = binarySearch(books, "Java Programming");

        if (b2 != null)

            b2.display();

    }

}