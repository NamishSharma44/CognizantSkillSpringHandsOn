// Target Interface
interface PaymentProcessor {

    void processPayment(double amount);

}


class PayPalGateway {

    public void sendPayment(double amount) {

        System.out.println("Payment of ₹" + amount + " processed using PayPal.");

    }

}



class StripeGateway {

    public void makePayment(double amount) {

        System.out.println("Payment of ₹" + amount + " processed using Stripe.");

    }

}


class PayPalAdapter implements PaymentProcessor {

    private PayPalGateway payPalGateway;

    public PayPalAdapter() {

        payPalGateway = new PayPalGateway();

    }

    @Override
    public void processPayment(double amount) {

        payPalGateway.sendPayment(amount);

    }

}



class StripeAdapter implements PaymentProcessor {

    private StripeGateway stripeGateway;

    public StripeAdapter() {

        stripeGateway = new StripeGateway();

    }

    @Override
    public void processPayment(double amount) {

        stripeGateway.makePayment(amount);

    }

}


public class TestAdapter {

    public static void main(String[] args) {

        PaymentProcessor paypal =
                new PayPalAdapter();

        PaymentProcessor stripe =
                new StripeAdapter();

        paypal.processPayment(2500);

        stripe.processPayment(5000);

    }

}