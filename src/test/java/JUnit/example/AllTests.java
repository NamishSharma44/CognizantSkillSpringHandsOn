package JUnit.example;

import org.junit.platform.suite.api.SelectClasses;
import org.junit.platform.suite.api.Suite;

@Suite
@SelectClasses({

        CalculatorTest.class,

        Student.class,

        EvenCheckerTest.class

})

public class AllTests {

}