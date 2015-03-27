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
import android.widget.CursorAdapter;
import android.widget.ListView;
import android.widget.SimpleCursorAdapter;
import android.widget.TextView;

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
    private ArrayList<Food> foods;
    private Cursor cursor;

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
        foods = new ArrayList<Food>();
        cursor = database.query(TABLE_NAME,
                new String[] {
                        FOOD_ID, FOOD_NAME, FOOD_CALORIES, FOOD_AMOUNT
                }, // columns
                null, // selection
                null, // selectionArgs
                null, // groupBy
                null, // having
                FOOD_NAME); // orderBy
//        cursor.moveToFirst();
//        if (!cursor.isAfterLast()) {
//            do {
//                String name = cursor.getString(1);
//                int calories = cursor.getInt(2);
//                double amount = cursor.getDouble(3);
//                foods.add(new Food(name, calories, amount));
//            } while (cursor.moveToNext());
//        }
//        cursor.close();
    }

    private void setUpList() {
        SimpleCursorAdapter adapter = new SimpleCursorAdapter(this,
                android.R.layout.simple_list_item_2,
                cursor,
                new String[] {
                        FOOD_NAME, FOOD_CALORIES
                },
                new int[]{
                        android.R.id.text1, android.R.id.text2
                });
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
