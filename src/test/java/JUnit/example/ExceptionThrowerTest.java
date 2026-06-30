package JUnit.example;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class ExceptionThrowerTest {

    ExceptionThrower exceptionThrower =
            new ExceptionThrower();

    @Test
    void shouldThrowIllegalArgumentException() {

        IllegalArgumentException exception =
                assertThrows(
                        IllegalArgumentException.class,
                        () -> exceptionThrower.throwException()
                );

        assertEquals(
                "Invalid Input",
                exception.getMessage()
        );

    }

}