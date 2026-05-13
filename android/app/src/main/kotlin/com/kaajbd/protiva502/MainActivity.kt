package com.kaajbd.protiva502

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.sslwireless.sslcommerz.FlutterSslcommerzPlugin

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.plugins.add(FlutterSslcommerzPlugin())
    }
}


