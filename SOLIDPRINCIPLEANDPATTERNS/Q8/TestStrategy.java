
interface PaymentStrategy {

    void pay(double amount);

}


class CreditCardPayment implements PaymentStrategy {

    @Override
    public void pay(double amount) {

        System.out.println("Paid ₹" + amount + " using Credit Card.");

    }

}



class PayPalPayment implements PaymentStrategy {

    @Override
    public void pay(double amount) {

        System.out.println("Paid ₹" + amount + " using PayPal.");

    }

}



class PaymentContext {

    private PaymentStrategy paymentStrategy;

    public PaymentContext(PaymentStrategy paymentStrategy) {

        this.paymentStrategy = paymentStrategy;

    }

    public void makePayment(double amount) {

        paymentStrategy.pay(amount);

    }

}



public class TestStrategy {

    public static void main(String[] args) {

        // Credit Card Payment
        PaymentContext payment1 =
                new PaymentContext(new CreditCardPayment());

        payment1.makePayment(2500);

        System.out.println();

        // PayPal Payment
        PaymentContext payment2 =
                new PaymentContext(new PayPalPayment());

        payment2.makePayment(5000);

    }

}