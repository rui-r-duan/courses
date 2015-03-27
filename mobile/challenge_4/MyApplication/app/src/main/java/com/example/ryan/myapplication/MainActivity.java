package com.example.ryan.myapplication;

import android.content.Intent;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.SimpleAdapter;

import java.util.ArrayList;
import java.util.Map;
import java.util.List;
import java.util.HashMap;


public class MainActivity extends ActionBarActivity {

    private String[] names = new String[] {
            "Dan", "John", "Daniel", "Johnny", "Makiyo"
    };
    private String[] emails = new String[] {
            "dan@lakeheadu.ca", "john@gmail.com", "daniel@gmail.com", "johnny@gmail.com",
            "makiyo@gmail.com"
    };
    private String[] cellphone = new String[] {
            "40010787", "23079732", "37985339", "40774042", "36155618"
    };
    private String[] homephone = new String[] {
            "116257324", "79145508", "23716735", "73959961", "139746094"
    };
    private double[] xs = new double[] {
            48.420892, 58.420990, 33.516144, 60.376485, 53.413501
    };
    private double[] ys = new double[] {
            -89.260566, -80.250238, -60.512254, -70.319674, -76.243799
    };
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        List<Map<String, Object>> listItems = new ArrayList<Map<String, Object>>();
        for (int i = 0; i < names.length; i++) {
            Map<String, Object> listItem = new HashMap<String, Object>();
            listItem.put("name", names[i]);
            listItem.put("email", emails[i]);
            listItem.put("cellphone", cellphone[i]);
            listItem.put("homephone", homephone[i]);
            listItems.add(listItem);
        }
        SimpleAdapter simpleAdapter = new SimpleAdapter(this
                , listItems
                , R.layout.list_entry
                , new String[]{ "name", "email", "cellphone", "homephone" }
                , new int[]{R.id.name, R.id.email, R.id.cellphone, R.id.homephone});
        ListView list = (ListView)findViewById(R.id.listView);

        list.setAdapter(simpleAdapter);
        list.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                double x = xs[i];
                double y = ys[i];
                String name = names[i];

                Intent intent = new Intent();
                intent.setClass(MainActivity.this, MapsActivity.class);

                Bundle bundle = new Bundle();
                bundle.putDouble("x",x);
                bundle.putDouble("y",y);
                bundle.putString("name",name);

                intent.putExtras(bundle);

                startActivity(intent);
            }
        });
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
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
