package ca.lakeheadu.ryanduan.andronut;

import android.content.Intent;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TextView;


public class FoodDetailActivity extends ActionBarActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_food_detail);
        Intent intent = getIntent();
        Bundle bundle = intent.getExtras();
        String foodName = bundle.getString(FoodListActivity.FOOD_NAME);
        int foodCalories = bundle.getInt(FoodListActivity.FOOD_CALORIES);
        double foodAmount = bundle.getDouble(FoodListActivity.FOOD_AMOUNT);
        TextView tvName = (TextView)findViewById(R.id.food_name);
//        tvName.setTextSize(40);
        tvName.setText(foodName);
        TextView tvCalories = (TextView)findViewById(R.id.food_calories);
//        tvCalories.setTextSize(30);
        tvCalories.setText(Integer.toString(foodCalories) + " kCal");
        TextView tvAmount = (TextView)findViewById(R.id.food_amount);
//        tvAmount.setTextSize(30);
        tvAmount.setText(Double.toString(foodAmount) + " g");
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_food_detail, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}
