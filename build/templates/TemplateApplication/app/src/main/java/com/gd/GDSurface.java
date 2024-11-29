package com.gd;

import android.content.Context;
import android.opengl.GLSurfaceView;
import android.view.MotionEvent;

public class GDSurface extends GLSurfaceView {

    private final GDRenderer renderer;

    public GDSurface(Context context) {
        super(context);

        setEGLContextClientVersion(2);

        renderer = new GDRenderer();

        setRenderer(renderer);
        setPreserveEGLContextOnPause(true);
        setRenderMode(GLSurfaceView.RENDERMODE_WHEN_DIRTY);
    }

    @Override
    public boolean onTouchEvent(MotionEvent e) {
        super.onTouchEvent(e);

        int i = 0;
        int pointerId = 0;
        int pointerCount = e.getPointerCount();

        switch (e.getAction()) {
        case MotionEvent.ACTION_MOVE:
            for (i = 0; i < pointerCount; i++) {
                pointerId = e.getPointerId(i);
                Main.instance.onTouchMove(pointerId, e.getX(i), e.getY(i));
            }
            break;
        case MotionEvent.ACTION_DOWN:
        case MotionEvent.ACTION_POINTER_DOWN:
            for (i = 0; i < pointerCount; i++) {
                pointerId = e.getPointerId(i);
                Main.instance.onTouchStart(pointerId, e.getX(i), e.getY(i));
            }
            break;
        case MotionEvent.ACTION_UP:
        case MotionEvent.ACTION_CANCEL:
        case MotionEvent.ACTION_POINTER_UP:
            for (i = 0; i < pointerCount; i++) {
                pointerId = e.getPointerId(i);
                Main.instance.onTouchEnd(pointerId, e.getX(i), e.getY(i));
            }
            break;
        case MotionEvent.ACTION_SCROLL:
            Main.instance.onScroll(e.getAxisValue(MotionEvent.AXIS_HSCROLL), e.getAxisValue(MotionEvent.AXIS_VSCROLL));
            break;
        default:
            break;
        }

        return true;
    }

}
