package ca.lakeheadu.ryanduan.andronut;

/**
 * Created by Ryan on 2015-03-27.
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
