package ca.lakeheadu.ryanduan.andronut;

import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ExpandableListView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


public class MyMealsActivity extends ActionBarActivity {
    public final static String SELECTED_MEAL = "ca.lakeheadu.ryanduan.andronut.SELECTED_MEAL";
    ExpandableListAdapter listAdapter;
    ExpandableListView expListView;
    List<String> listDataHeader;
    HashMap<String, List<String>> listDataChild;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my_meals);

        expListView = (ExpandableListView) findViewById(R.id.mymeals_listview);

        // preparing list data
        prepareListData();

        listAdapter = new ExpandableListAdapter(this, listDataHeader, listDataChild);
        expListView.setAdapter(listAdapter);
    }

    private void prepareListData() {
        listDataHeader = new ArrayList<>();
        listDataChild = new HashMap<>();

        // Adding child data
        listDataHeader.add("Breakfast");
        listDataHeader.add("Lunch");
        listDataHeader.add("Supper");

        // Adding child data
        List<String> breakfastList = new ArrayList<>();
        breakfastList.add("Rice");
        breakfastList.add("Potato");
        breakfastList.add("Tomato");
        breakfastList.add("Bread");
        breakfastList.add("Salad");

        List<String> lunchList = new ArrayList<>();
        lunchList.add("Rice");
        lunchList.add("Noodles");
        lunchList.add("Sandwich");
        lunchList.add("Beef");

        List<String> supperList = new ArrayList<>();
        supperList.add("Beef");
        supperList.add("Chicken");
        supperList.add("Lamb");
        supperList.add("Salad");
        supperList.add("Sandwich");

        listDataChild.put(listDataHeader.get(0), breakfastList);
        listDataChild.put(listDataHeader.get(1), lunchList);
        listDataChild.put(listDataHeader.get(2), supperList);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_my_meals, menu);
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
