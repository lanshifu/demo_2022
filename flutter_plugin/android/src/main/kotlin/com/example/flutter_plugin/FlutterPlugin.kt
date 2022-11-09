package com.example.flutter_plugin

import android.app.Activity
import android.app.Application
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterPlugin */
class FlutterPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private val TAG = "FlutterPlugin"

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_plugin")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext

        (flutterPluginBinding.applicationContext as Application)
            .registerActivityLifecycleCallbacks(object : Application.ActivityLifecycleCallbacks {
                override fun onActivityCreated(p0: Activity, p1: Bundle?) {
                    Log.d(TAG, "onActivityCreated: ${p0.localClassName}")
                }

                override fun onActivityStarted(p0: Activity) {

                    Log.d(TAG, "onActivityStarted: ${p0.localClassName}")
//          if(p0.localClassName == "MainActivity"){
//            p0.onResume()
//          }

                }

                override fun onActivityResumed(p0: Activity) {

                    Log.d(TAG, "onActivityResumed: ${p0.localClassName}")
                }

                override fun onActivityPaused(p0: Activity) {

                    Log.d(TAG, "onActivityPaused: ${p0.localClassName}")

                    if (p0.localClassName == "com.example.flutter_plugin.PluginMainActivity") {
                        p0.finish()
                    }
                }

                override fun onActivityStopped(p0: Activity) {

                    Log.d(TAG, "onActivityStopped: ${p0.localClassName}")
                }

                override fun onActivitySaveInstanceState(p0: Activity, p1: Bundle) {

                    Log.d(TAG, "onActivitySaveInstanceState: ${p0.localClassName}")
                }

                override fun onActivityDestroyed(p0: Activity) {
                    Log.d(TAG, "onActivitySaveInstanceState: ${p0.localClassName}")
                }
            })

    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (call.method == "startActivity") {
            context.startActivity(Intent(context, PluginMainActivity::class.java).apply {
                flags = Intent.FLAG_ACTIVITY_NEW_TASK
            })
            result.success("")
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
