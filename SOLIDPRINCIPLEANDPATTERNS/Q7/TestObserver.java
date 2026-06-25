import java.util.ArrayList;
import java.util.List;



interface Observer {

    void update(double price);

}



class MobileApp implements Observer {

    @Override
    public void update(double price) {

        System.out.println("Mobile App : Stock Price Updated = ₹" + price);

    }

}



class WebApp implements Observer {

    @Override
    public void update(double price) {

        System.out.println("Web App : Stock Price Updated = ₹" + price);

    }

}



interface Stock {

    void registerObserver(Observer observer);

    void removeObserver(Observer observer);

    void notifyObservers();

}


class StockMarket implements Stock {

    private List<Observer> observers = new ArrayList<>();

    private double stockPrice;

    @Override
    public void registerObserver(Observer observer) {

        observers.add(observer);

    }

    @Override
    public void removeObserver(Observer observer) {

        observers.remove(observer);

    }

    @Override
    public void notifyObservers() {

        for (Observer observer : observers) {

            observer.update(stockPrice);

        }

    }

    public void setStockPrice(double price) {

        this.stockPrice = price;

        notifyObservers();

    }

}

// ---------------- Main Class ----------------

public class TestObserver {

    public static void main(String[] args) {

        StockMarket stockMarket = new StockMarket();

        Observer mobile = new MobileApp();
        Observer web = new WebApp();

        // Register Observers
        stockMarket.registerObserver(mobile);
        stockMarket.registerObserver(web);

        System.out.println("Stock Price Changed to ₹500");

        stockMarket.setStockPrice(500);

        System.out.println();

        System.out.println("Stock Price Changed to ₹750");

        stockMarket.setStockPrice(750);

        System.out.println();

        System.out.println("Removing Web App Observer...");

        stockMarket.removeObserver(web);

        System.out.println();

        System.out.println("Stock Price Changed to ₹900");

        stockMarket.setStockPrice(900);

    }

}