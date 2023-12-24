package com.example.spinner_try
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import android.os.PowerManager
import android.os.Bundle
import android.content.Context

class MainActivity : FlutterActivity() {

    private var wakeLock: PowerManager.WakeLock? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger!!, "android_wake_lock")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "acquireWakeLock" -> {
                        keepScreenOn()
                        result.success(null)
                    }
                    "releaseWakeLock" -> {
                        wakeLock?.release()
                        result.success(null)
                    }
                    else -> {
                        result.notImplemented()
                    }
                }
            }

    }

    private fun keepScreenOn() {
        val powerManager = getSystemService(Context.POWER_SERVICE) as PowerManager
        wakeLock = powerManager.newWakeLock(
            PowerManager.PROXIMITY_SCREEN_OFF_WAKE_LOCK or PowerManager.ACQUIRE_CAUSES_WAKEUP,
            "YourApp:WakeLockTag"
        )

        wakeLock?.acquire()
    }

    override fun onDestroy() {
        super.onDestroy()

        // Release the wake lock when the activity is destroyed
        wakeLock?.release()
    }
}
