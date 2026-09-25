package com.widgetx.widget_x

import android.os.Bundle
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Allow screenshots and screen recording
        window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
    }
}
