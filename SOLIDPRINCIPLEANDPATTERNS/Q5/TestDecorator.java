// Component Interface
interface Notifier {

    void send(String message);

}



class EmailNotifier implements Notifier {

    @Override
    public void send(String message) {

        System.out.println("Email Notification : " + message);

    }

}



abstract class NotifierDecorator implements Notifier {

    protected Notifier notifier;

    public NotifierDecorator(Notifier notifier) {

        this.notifier = notifier;

    }

}


class SMSNotifierDecorator extends NotifierDecorator {

    public SMSNotifierDecorator(Notifier notifier) {

        super(notifier);

    }

    @Override
    public void send(String message) {

        notifier.send(message);

        System.out.println("SMS Notification : " + message);

    }

}


class SlackNotifierDecorator extends NotifierDecorator {

    public SlackNotifierDecorator(Notifier notifier) {

        super(notifier);

    }

    @Override
    public void send(String message) {

        notifier.send(message);

        System.out.println("Slack Notification : " + message);

    }

}



public class TestDecorator {

    public static void main(String[] args) {

        System.out.println("Email Only");
        Notifier email = new EmailNotifier();
        email.send("Order Placed");

        System.out.println();

        System.out.println("Email + SMS");
        Notifier sms =
                new SMSNotifierDecorator(new EmailNotifier());
        sms.send("Order Placed");

        System.out.println();

        System.out.println("Email + SMS + Slack");
        Notifier all =
                new SlackNotifierDecorator(
                        new SMSNotifierDecorator(
                                new EmailNotifier()));

        all.send("Order Placed");

    }

}