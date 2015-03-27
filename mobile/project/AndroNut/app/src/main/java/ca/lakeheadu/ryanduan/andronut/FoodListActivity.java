package ca.lakeheadu.ryanduan.andronut;

import android.content.Intent;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;


public class FoodListActivity extends ActionBarActivity {
    public final static String SELECTED_FOOD = "ca.lakeheadu.ryanduan.andronut.SELECTED_FOOD";
    private static final String DB_NAME = "foods.sqlite3";
    private static final String TABLE_NAME = "foods";
    private static final String FOOD_ID = "_id";
    private static final String FOOD_NAME = "name";
    private static final String FOOD_CALORIES = "calories";
    private static final String FOOD_AMOUNT = "amount";

    private SQLiteDatabase database;
    private ListView lv;
    private ArrayList<String> foods;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_food_list);
        ExternalDbOpenHelper dbOpenHelper = new ExternalDbOpenHelper(this, DB_NAME);
        database = dbOpenHelper.openDataBase();
        lv = (ListView)findViewById(R.id.foodListView);
        fillFoods();
        setUpList();
    }

    private void fillFoods() {
        foods = new ArrayList<String>();
        Cursor foodCursor = database.query(TABLE_NAME,
                new String[] {
                        FOOD_ID, FOOD_NAME
                },
                null, null, null, null,
                FOOD_NAME);
        foodCursor.moveToFirst();
        if (!foodCursor.isAfterLast()) {
            do {
                String name = foodCursor.getString(1);
                foods.add(name);
            } while (foodCursor.moveToNext());
        }
        foodCursor.close();
    }

    private void setUpList() {
        ArrayAdapter<String> adapter = new ArrayAdapter<String>(this,
                android.R.layout.simple_list_item_1, foods);
        lv.setAdapter(adapter);
        lv.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {

                Intent intent = new Intent(FoodListActivity.this, FoodDetailActivity.class);
//                String msg = (String)adapterView.getItemAtPosition(i);
                String msg = (String) ((TextView)view).getText();
                intent.putExtra(SELECTED_FOOD, msg);
                startActivity(intent);
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_food_list, menu);
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
