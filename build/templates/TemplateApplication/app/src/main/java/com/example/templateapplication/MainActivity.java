package com.example.templateapplication;

import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;
import android.opengl.GLSurfaceView;

import com.gd.Main;
import com.gd.GDSurface;

public class MainActivity extends AppCompatActivity {

    private GLSurfaceView glView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        glView = new GDSurface(this);
        setContentView(glView);

        Main.instance.initialize();
    }
}
