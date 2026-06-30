package JUnit.example;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.*;

import static org.junit.jupiter.api.Assertions.*;

public class EvenCheckerTest {

    EvenChecker checker = new EvenChecker();

    @DisplayName("Even Numbers Test")
    @ParameterizedTest
    @ValueSource(ints = {2,4,6,8,10,100})
    void shouldReturnTrueForEvenNumbers(int number){

        assertTrue(checker.isEven(number));

    }
    @DisplayName("Odd Numbers Test")
    @ParameterizedTest
    @ValueSource(ints = {1, 3, 5, 7, 9})
    void shouldReturnFalseForOddNumbers(int number) {
        assertFalse(checker.isEven(number));
    }


    Calculator calculator = new Calculator();

    @ParameterizedTest
    @CsvSource({
            "2, 2, 4",
            "5, 5, 10",
            "10, 20, 30",
            "100, 200, 300"
    })
    void shouldAddNumbers(int a, int b, int expected) {
        assertEquals(expected, calculator.add(a, b));
    }

    private boolean isStringValid(String input) {
        return input != null && !input.isEmpty();
    }

    @ParameterizedTest
    @NullSource
    @DisplayName("Testing with Null source")
    void testNull(String input) {
        assertFalse(isStringValid(input), "Null should be invalid");
    }

    @ParameterizedTest
    @EmptySource
    @DisplayName("Testing with Empty source")
    void testEmpty(String input) {
        assertFalse(isStringValid(input), "Empty string should be invalid");
    }

    @ParameterizedTest
    @NullAndEmptySource
    @DisplayName("Testing with Null and Empty source")
    void testNullAndEmpty(String input) {
        assertFalse(isStringValid(input), "Null and Empty should both be invalid");
    }

    @ParameterizedTest
    @EmptySource
    void testEmpt(String text){

        assertTrue(text.isEmpty());

    }
}