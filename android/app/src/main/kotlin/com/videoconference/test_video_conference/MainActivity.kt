package com.gcnt.ijmeet
import android.os.Bundle
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
//import name.avioli.unilinks.UniLinksPlugin
class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        UniLinksPlugin.registerWith(registrarFor("name.avioli.unilinks.UniLinksPlugin"))
//        window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
        window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
    }
}
//UniLinksPlugin.registerWith(registrarFor("name.avioli.unilinks.UniLinksPlugin"))
//import android.os.Bundle
//import io.flutter.embedding.android.FlutterActivity
//import name.avioli.unilinks.UniLinksPlugin


