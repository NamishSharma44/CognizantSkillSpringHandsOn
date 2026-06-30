package org.example;

import org.junit.jupiter.api.*;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("Calculator Unit Tests")
public class CalculatorTest {

    private Calculator calculator;

    // Runs once before all tests
    @BeforeAll
    static void beforeAll() {
        System.out.println("========== Starting Calculator Tests ==========");
    }

    // Runs before every test
    @BeforeEach
    void setup() {
        calculator = new Calculator();
        System.out.println("Calculator Object Created");
    }

    // Runs after every test
    @AfterEach
    void tearDown() {
        System.out.println("Test Completed");
    }

    // Runs once after all tests
    @AfterAll
    static void afterAll() {
        System.out.println("========== All Calculator Tests Completed ==========");
    }

    // ---------------- Addition ----------------

    @Test
    @DisplayName("Addition of two positive numbers")
    void shouldAddTwoNumbers() {

        // Arrange
        int a = 5;
        int b = 3;

        // Act
        int result = calculator.add(a, b);

        // Assert
        assertEquals(8, result);
    }

    // ---------------- Subtraction ----------------

    @Test
    @DisplayName("Subtraction of two numbers")
    void shouldSubtractTwoNumbers() {

        // Arrange
        int a = 10;
        int b = 6;

        // Act
        int result = calculator.subtract(a, b);

        // Assert
        assertEquals(4, result);
    }

    // ---------------- Multiplication ----------------

    @Test
    @DisplayName("Multiplication of two numbers")
    void shouldMultiplyTwoNumbers() {

        // Arrange
        int a = 4;
        int b = 5;

        // Act
        int result = calculator.multiply(a, b);

        // Assert
        assertEquals(20, result);
    }

    // ---------------- Division ----------------

    @Test
    @DisplayName("Division of two numbers")
    void shouldDivideTwoNumbers() {

        // Arrange
        int a = 20;
        int b = 4;

        // Act
        int result = calculator.divide(a, b);

        // Assert
        assertEquals(5, result);
    }

    @Test
    @DisplayName("Division by zero should throw ArithmeticException")
    void shouldThrowExceptionWhenDivideByZero() {

        assertThrows(
                ArithmeticException.class,
                () -> calculator.divide(10, 0)
        );
    }

    @Test
    @DisplayName("Division with valid numbers should not throw exception")
    void shouldNotThrowException() {

        assertDoesNotThrow(() -> calculator.divide(10, 2));
    }

    // ---------------- Square ----------------

    @Test
    @DisplayName("Square of positive number")
    void shouldReturnSquareOfPositiveNumber() {

        assertEquals(25, calculator.square(5));
    }

    @Test
    @DisplayName("Square of zero")
    void shouldReturnSquareOfZero() {

        assertEquals(0, calculator.square(0));
    }

    @Test
    @DisplayName("Square of negative number")
    void shouldReturnSquareOfNegativeNumber() {

        assertEquals(25, calculator.square(-5));
    }

    // ---------------- Modulus ----------------

    @Test
    @DisplayName("Modulus of two numbers")
    void shouldReturnModulus() {

        assertEquals(1, calculator.modulus(10, 3));
    }

    @Test
    @DisplayName("Modulus by one")
    void shouldReturnZeroWhenModulusByOne() {

        assertEquals(0, calculator.modulus(10, 1));
    }

    @Test
    @DisplayName("Modulus of same numbers")
    void shouldReturnZeroWhenSameNumbers() {

        assertEquals(0, calculator.modulus(5, 5));
    }

    // ---------------- Other Assertions ----------------

    @Test
    @DisplayName("assertNotEquals Example")
    void shouldPassAssertNotEquals() {

        int result = calculator.square(5);

        assertNotEquals(20, result);
    }

    @Test
    @DisplayName("assertTrue Example")
    void shouldPassAssertTrue() {

        int result = calculator.square(5);

        assertTrue(result > 20);
    }

    @Test
    @DisplayName("assertFalse Example")
    void shouldPassAssertFalse() {

        int result = calculator.square(5);

        assertFalse(result < 20);
    }

    @Test
    @DisplayName("Student name should be null")
    void shouldReturnNullName() {

        Student student = new Student();

        assertNull(student.getName());
    }

    @Test
    @DisplayName("Student object should not be null")
    void shouldReturnNonNullStudentObject() {

        Student student = new Student();

        assertNotNull(student);
    }

    // ---------------- assertAll ----------------

    @Test
    @DisplayName("All calculator operations should work correctly")
    void shouldPerformAllOperationsCorrectly() {

        assertAll(

                () -> assertEquals(8, calculator.add(5, 3)),

                () -> assertEquals(2, calculator.subtract(5, 3)),

                () -> assertEquals(15, calculator.multiply(3, 5)),

                () -> assertEquals(2, calculator.divide(10, 5)),

                () -> assertEquals(25, calculator.square(5)),

                () -> assertEquals(1, calculator.modulus(10, 3))
        );
    }
}