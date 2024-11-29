package com.gd;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

import android.opengl.GLES20;
import android.opengl.GLSurfaceView;

public class GDRenderer implements GLSurfaceView.Renderer {

    public void onSurfaceCreated(GL10 unused, EGLConfig config) {
        Main.instance.onSurfaceCreated();
    }

    public void onDrawFrame(GL10 unused) {
        Main.instance.onDrawFrame();
    }

    public void onSurfaceChanged(GL10 unused, int width, int height) {
        Main.instance.onSurfaceChanged(width, height);
    }

}
