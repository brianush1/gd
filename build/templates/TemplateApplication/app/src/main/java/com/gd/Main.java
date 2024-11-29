package com.gd;

public class Main {

    static {
        System.loadLibrary("template-library-name");
    }

    public static Main instance;

    public native void initializeEarly();
    public native void initialize();

    public native void onSurfaceCreated();
    public native void onDrawFrame();
    public native void onSurfaceChanged(int width, int height);

    public native void onTouchStart(int pointerId, double x, double y);
    public native void onTouchEnd(int pointerId, double x, double y);
    public native void onTouchMove(int pointerId, double x, double y);
    public native void onScroll(double dx, double dy);

}
