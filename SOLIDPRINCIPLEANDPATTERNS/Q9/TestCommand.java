

interface Command {

    void execute();

}


class Light {

    public void turnOn() {

        System.out.println("Light is ON");

    }

    public void turnOff() {

        System.out.println("Light is OFF");

    }

}


class LightOnCommand implements Command {

    private Light light;

    public LightOnCommand(Light light) {

        this.light = light;

    }

    @Override
    public void execute() {

        light.turnOn();

    }

}


class LightOffCommand implements Command {

    private Light light;

    public LightOffCommand(Light light) {

        this.light = light;

    }

    @Override
    public void execute() {

        light.turnOff();

    }

}



class RemoteControl {

    private Command command;

    public void setCommand(Command command) {

        this.command = command;

    }

    public void pressButton() {

        command.execute();

    }

}



public class TestCommand {

    public static void main(String[] args) {

        // Receiver
        Light light = new Light();

        // Commands
        Command lightOn = new LightOnCommand(light);
        Command lightOff = new LightOffCommand(light);

        // Invoker
        RemoteControl remote = new RemoteControl();

        System.out.println("Press ON Button");
        remote.setCommand(lightOn);
        remote.pressButton();

        System.out.println();

        System.out.println("Press OFF Button");
        remote.setCommand(lightOff);
        remote.pressButton();

    }

}