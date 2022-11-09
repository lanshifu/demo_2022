package com.example.flutter_plugin

import android.os.Bundle
import android.view.WindowManager
import androidx.appcompat.app.AppCompatActivity


class PluginMainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        //隐藏标题栏以及状态栏
        //隐藏标题栏以及状态栏
//        window.setFlags(
//            WindowManager.LayoutParams.FLAG_FULLSCREEN,
//            WindowManager.LayoutParams.FLAG_FULLSCREEN
//        )
//        val window = getWindow()
//        window.addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_plugin_main)
    }
}