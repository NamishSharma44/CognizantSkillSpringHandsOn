class Computer {

   
    private String cpu;
    private int ram;
    private int storage;
    private String graphicsCard;
    private String operatingSystem;

    
    private Computer(Builder builder) {
        this.cpu = builder.cpu;
        this.ram = builder.ram;
        this.storage = builder.storage;
        this.graphicsCard = builder.graphicsCard;
        this.operatingSystem = builder.operatingSystem;
    }

    
    public void display() {

        System.out.println("Computer Configuration");
        System.out.println("----------------------");
        System.out.println("CPU : " + cpu);
        System.out.println("RAM : " + ram + " GB");
        System.out.println("Storage : " + storage + " GB");
        System.out.println("Graphics Card : " + graphicsCard);
        System.out.println("Operating System : " + operatingSystem);
        System.out.println();
    }

   
    static class Builder {

        private String cpu;
        private int ram;
        private int storage;
        private String graphicsCard;
        private String operatingSystem;

        public Builder setCPU(String cpu) {
            this.cpu = cpu;
            return this;
        }

        public Builder setRAM(int ram) {
            this.ram = ram;
            return this;
        }

        public Builder setStorage(int storage) {
            this.storage = storage;
            return this;
        }

        public Builder setGraphicsCard(String graphicsCard) {
            this.graphicsCard = graphicsCard;
            return this;
        }

        public Builder setOperatingSystem(String operatingSystem) {
            this.operatingSystem = operatingSystem;
            return this;
        }

        public Computer build() {
            return new Computer(this);
        }
    }
}

public class TestBuilder {

    public static void main(String[] args) {

        
        Computer gamingPC = new Computer.Builder()
                .setCPU("Intel i9")
                .setRAM(32)
                .setStorage(1000)
                .setGraphicsCard("RTX 4080")
                .setOperatingSystem("Windows 11")
                .build();

        gamingPC.display();

        
        Computer officePC = new Computer.Builder()
                .setCPU("Intel i3")
                .setRAM(8)
                .setStorage(512)
                .setOperatingSystem("Windows 10")
                .build();

        officePC.display();

    }
}