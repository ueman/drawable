package de.ju.drawable

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.lang.Exception

const val channelId = "de.ju.drawable"
const val drawableId = "id"
const val scaleKey = "scale"
const val typeKey = "type"
const val foregroundKey = "foreground"
const val backgroundKey = "background"

/** DrawablePlugin */
class DrawablePlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private lateinit var loader: DrawableLoader

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, channelId)
        channel.setMethodCallHandler(this)
        loader = DrawableLoader(flutterPluginBinding.applicationContext)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "bitmap" -> loadBitmap(call, result)
            "color" -> loadColor(call, result)
            "vector" -> loadVector(call, result)
            "adaptiveIcon" -> loadAdaptiveIconDrawable(call, result)
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun loadBitmap(call: MethodCall, result: Result) {
        val bitmapName = call.argument<String>(drawableId)!!
        val type = call.argument<String>(typeKey)!!
        val bitmap = loader.loadBitmapDrawable(bitmapName, type)
        if (bitmap != null) {
            result.success(bitmap)
        } else {
            result.error(
                    "Drawable not found",
                    "The specified drawable for id $bitmapName could not be found",
                    null
            )
        }
    }

    private fun loadColor(call: MethodCall, result: Result) {
        try {
            val bitmapName = call.argument<String>(drawableId)!!
            val color = loader.loadColorDrawable(bitmapName)
            result.success(color)
        } catch (_: Exception) {
            result.error(
                    "Drawable not found",
                    "The specified drawable for id ${call.argument<String>(drawableId)!!} could not be found",
                    null
            )
        }
    }

    private fun loadVector(call: MethodCall, result: Result) {
        if (android.os.Build.VERSION.SDK_INT < android.os.Build.VERSION_CODES.LOLLIPOP) {
            result.error(
                    "VectorDrawable",
                    "Vector Drawable are not supported on this SDK Level: ${android.os.Build.VERSION.SDK_INT}",
                    null
            )

        } else {
            val vectorName = call.argument<String>(drawableId)!!
            val scale = call.argument<Int>(scaleKey)!!
            val type = call.argument<String>(typeKey)!!
            val color = loader.loadVectorDrawable(vectorName, scale, type)
            if (color != null) {
                result.success(color)
            } else {
                result.error(
                        "Drawable not found",
                        "The specified drawable for id $vectorName could not be found",
                        null
                )
            }
        }
    }

    private fun loadAdaptiveIconDrawable(call: MethodCall, result: Result) {
        if (android.os.Build.VERSION.SDK_INT < android.os.Build.VERSION_CODES.O) {
            result.error(
                    "AdaptiveIconDrawable",
                    "AdaptiveIconDrawable are not supported on this SDK Level: ${android.os.Build.VERSION.SDK_INT}",
                    null
            )
        } else {
            val vectorName = call.argument<String>(drawableId)!!
            val scale = call.argument<Int>(scaleKey)!!
            val type = call.argument<String>(typeKey)!!
            val adaptiveIconDrawable = loader.loadAdaptiveIconDrawable(vectorName, scale, type)
            if (adaptiveIconDrawable != null) {
                result.success(mapOf(
                        foregroundKey to adaptiveIconDrawable.first,
                        backgroundKey to adaptiveIconDrawable.second
                ))
            } else {
                result.error(
                        "Drawable not found",
                        "The specified drawable for id $vectorName could not be found",
                        null
                )
            }
        }
    }
}
