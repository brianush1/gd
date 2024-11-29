package com.example.templateapplication;

import android.app.Application;
import android.content.Context;

import com.gd.Main;

public class MyApplication extends Application {

    static {
        Main.instance = new Main();
        Main.instance.initializeEarly();
    }

}
