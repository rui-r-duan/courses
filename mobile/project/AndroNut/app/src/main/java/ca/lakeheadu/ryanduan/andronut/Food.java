package ca.lakeheadu.ryanduan.andronut;

/**
 * Data structure for the food record.
 */
public class Food {
    private String name;
    private int calories;
    private double amount;

    public Food(String name, int calories, double amount) {
        this.name = name;
        this.calories = calories;
        this.amount = amount;
    }

    public String getName() { return name; }
    public int getCalories() { return calories; }
    public double getAmount() { return amount; }
}
