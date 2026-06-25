
interface Image {

    void display();

}



class RealImage implements Image {

    private String fileName;

    public RealImage(String fileName) {

        this.fileName = fileName;
        loadFromServer();

    }

    private void loadFromServer() {

        System.out.println("Loading " + fileName + " from Remote Server...");

    }

    @Override
    public void display() {

        System.out.println("Displaying " + fileName);

    }

}



class ProxyImage implements Image {

    private RealImage realImage;
    private String fileName;

    public ProxyImage(String fileName) {

        this.fileName = fileName;

    }

    @Override
    public void display() {

        if (realImage == null) {

            realImage = new RealImage(fileName);

        }

        realImage.display();

    }

}

public class TestProxy {

    public static void main(String[] args) {

        Image image = new ProxyImage("Nature.jpg");

        System.out.println("Image Object Created");

        System.out.println();

        image.display();

        System.out.println();

        image.display();

    }

}