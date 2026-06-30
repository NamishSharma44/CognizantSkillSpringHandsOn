package JUnit.example;

import org.junit.jupiter.api.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class OrderedTests {

    @Test
    @Order(1)
    void openApplication() {

        System.out.println("Application Opened");

    }

    @Test
    @Order(2)
    void login() {

        System.out.println("Login Successful");

    }

    @Test
    @Order(3)
    void searchProduct() {

        System.out.println("Searching Product");

    }

    @Test
    @Order(4)
    void logout() {

        System.out.println("Logout Successful");

    }

}