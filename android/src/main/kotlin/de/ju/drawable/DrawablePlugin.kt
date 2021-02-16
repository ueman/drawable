package de.ju.drawable

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

const val channelId = "de.ju.drawable"
const val drawableId = "id"

/** DrawablePlugin */
class DrawablePlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  private lateinit var loader : DrawableLoader

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, channelId)
    channel.setMethodCallHandler(this)
    loader = DrawableLoader(flutterPluginBinding.applicationContext)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "bitmap" -> loadBitmap(call, result)
      "color" -> loadColor(call, result)
      else -> { // Note the block
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun loadBitmap(call: MethodCall, result: Result){
    val bitmapName = call.argument<String>(drawableId)!!
    val bitmap = loader.loadBitmapDrawable(bitmapName)
    if(bitmap != null){
      result.success(bitmap)
    }else {
      result.error(
        "Drawable not found",
        "The specified drawable for id $bitmapName could not be found",
        null
      )
    }
  }

  private fun loadColor(call: MethodCall, result: Result) {
    val bitmapName = call.argument<String>(drawableId)!!
    val color = loader.loadColorDrawable(bitmapName)
    if(color != null){
      result.success(color)
    }else {
      result.error(
        "Drawable not found",
        "The specified drawable for id $bitmapName could not be found",
        null
      )
    }
  }
}
