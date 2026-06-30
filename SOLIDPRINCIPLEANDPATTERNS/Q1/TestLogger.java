class Logger{
    private static Logger instance;
    private Logger(){
        System.out.println("Logger instance created");
    }
    public static Logger getInstance(){
        if(instance==null){
            instance=new Logger();
        }
        return instance;
    }
    public void log(String message) {
        System.out.println("[LOG] " + message);
    }
}
public class TestLogger {

    public static void main(String[] args) {

        Logger logger1 = Logger.getInstance();

        Logger logger2 = Logger.getInstance();

        logger1.log("Application Started");

        logger2.log("User Logged In");

        System.out.println();

        System.out.println("HashCode of logger1 : " + logger1.hashCode());

        System.out.println("HashCode of logger2 : " + logger2.hashCode());

        if (logger1 == logger2) {
            System.out.println("\nOnly One Logger Instance Exists");
        } else {
            System.out.println("\nDifferent Logger Objects Created");
        }

    }
}
