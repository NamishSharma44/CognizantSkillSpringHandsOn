public class FinancialForecast {

    public static double futureValue(double currentValue,
                                     double growthRate,
                                     int years) {

        // Base Case
        if (years == 0)
            return currentValue;

        // Recursive Call
        return futureValue(currentValue, growthRate, years - 1)
                * (1 + growthRate);

    }

    public static void main(String[] args) {

        double investment = 10000;

        double growthRate = 0.10;

        int years = 5;

        double result = futureValue(investment,
                                    growthRate,
                                    years);

        System.out.println("Future Value = " + result);

    }

}