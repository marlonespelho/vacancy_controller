package br.com.mespelho.parking_controller

import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.widget.TextView

class MainActivity: FlutterActivity() {
    private val CHANNEL = "message/toast"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "message/toast").setMethodCallHandler {
                call, result ->
            if (call.method == "showToast") {
                val message = call.argument<String>("message")
                showCustomToast(message ?: "Mensagem vazia")
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun showCustomToast(message: String) {
        val inflater = layoutInflater
        val layout = inflater.inflate(R.layout.custom_toast, null)

        val text = layout.findViewById<TextView>(R.id.message)
        text.text = message

        val toast = Toast(applicationContext)
        toast.duration = Toast.LENGTH_SHORT
        toast.view = layout
        toast.show()
    }
}