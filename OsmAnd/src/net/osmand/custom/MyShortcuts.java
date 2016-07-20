package net.osmand.custom;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.ConnectivityManager;
import android.net.Network;
import android.net.NetworkInfo;
import android.os.Build;
import android.preference.PreferenceManager;
import android.provider.Settings;
import android.support.v7.app.AlertDialog;
import android.util.Base64;
import android.widget.Toast;

import java.util.HashMap;

/**
 * Created by stephineosoro on 07/06/16.
 */
public class MyShortcuts {


    public String baseURL = "";

    public static void set(String username, String password, Context context) {
        setDefaults("username", username, context);
        setDefaults("password", password, context);
    }

    public static HashMap<String, String> AunthenticationHeaders(Context context) {
        HashMap<String, String> headers = new HashMap<String, String>();
        headers.put("Content-Type", "application/json; charset=utf-8");
        /*String creds = String.format("%s:%s", "web@oneshoppoint.com", "spr0iPpQAiwS8u");
        String auth = "Basic " + Base64.encodeToString(creds.getBytes(), Base64.DEFAULT);
        headers.put("Authorization", auth);*/
        return headers;
    }
    public static HashMap<String, String> AunthenticationHeadersAdmin(Context context) {
        HashMap<String, String> headers = new HashMap<String, String>();
        headers.put("Content-Type", "application/json; charset=utf-8");
        String creds = String.format("%s:%s", getDefaults("username", context), getDefaults("password", context));
        String auth = "Basic " + Base64.encodeToString(creds.getBytes(), Base64.DEFAULT);
        headers.put("Authorization", auth);
        return headers;
    }


    public static void setDefaults(String key, String value, Context context) {
        SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(context);
        SharedPreferences.Editor editor = prefs.edit();
        editor.putString(key, value);
        editor.commit();
    }

    public static String getDefaults(String key, Context context) {
        SharedPreferences preferences = PreferenceManager.getDefaultSharedPreferences(context);
        return preferences.getString(key, null);
    }


    public static void showToast(String text, Context context) {

        Toast toast = Toast.makeText(context, text, Toast.LENGTH_SHORT);
        toast.show();
    }

    public void Delete(Context context) {
        SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(context);
        SharedPreferences.Editor editor = prefs.edit();
        editor.clear();
        editor.commit();
//        DetailActivity.i = 0;
//        k = 1;
    }

    public static Boolean checkDefaults(String key, Context context) {
        SharedPreferences preferences = PreferenceManager.getDefaultSharedPreferences(context);
        return preferences.contains(key);
    }


    public  static String help(String rb){

        String Validate = "yes";
        if (rb.equals("N/A")){
            Validate="na";
        }else{
            Validate=rb.toLowerCase();
        }
        return Validate;
    }




}
