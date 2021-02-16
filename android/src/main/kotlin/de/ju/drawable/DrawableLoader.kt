package de.ju.drawable

import android.content.Context
import android.content.res.Resources
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.*
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.core.content.ContextCompat
import java.io.ByteArrayOutputStream

class DrawableLoader(private val context: Context) {
    fun loadBitmapDrawable(name: String, type: String): ByteArray? {
        return drawableByName(name, type)?.toBitmap()?.toByteArray()
    }

    fun loadColorDrawable(name: String): Int {
        val res: Resources = context.resources
        val packageName: String = context.packageName

        val colorId  = res.getIdentifier(name, "color", packageName)
        return ContextCompat.getColor(context, colorId)
    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    fun loadVectorDrawable(name: String, scale: Int, type: String): ByteArray? {
        val drawable = drawableByName(name, type)
        if(drawable is VectorDrawable) {
            return drawable.toBitmap(scale)?.toByteArray()
        }
        return null
    }

    @RequiresApi(Build.VERSION_CODES.O)
    fun loadAdaptiveIconDrawable(name: String, scale: Int, type: String): Pair<ByteArray, ByteArray>? {
        val drawable = drawableByName(name, type)
        if (drawable is AdaptiveIconDrawable) {
            return Pair(
                drawable.foreground.toBitmap(scale)!!.toByteArray(),
                drawable.background.toBitmap(scale)!!.toByteArray()
            )
        }
        return null
    }

    private fun drawableByName(name: String, type: String): Drawable? {
        try {
            val resourceId = context.resources.getIdentifier(name, type, context.packageName)
            return ContextCompat.getDrawable(context, resourceId)
        } catch (_: Exception){ }
        return null
    }
}

fun Drawable.toBitmap(scale: Int = 1): Bitmap? {
    if (this is BitmapDrawable) {
        if (this.bitmap != null) {
            return this.bitmap
        }
    }
    // drawable is anything else for example:
    // - ColorDrawable
    // - AdaptiveIconDrawable
    // - VectorDrawable
    val bitmap = if (this.intrinsicWidth <= 0 || this.intrinsicHeight <= 0) {
        // Single color bitmap will be created of 1x1 pixel
        Bitmap.createBitmap(1, 1, Bitmap.Config.ARGB_8888) 
    } else {
        Bitmap.createBitmap(
            this.intrinsicWidth * scale,
            this.intrinsicHeight * scale,
            Bitmap.Config.ARGB_8888
        )
    }
    val canvas = Canvas(bitmap)
    this.setBounds(0, 0, canvas.width, canvas.height)
    this.draw(canvas)
    return bitmap
}

fun Bitmap.toByteArray(): ByteArray {
    val stream = ByteArrayOutputStream()
    this.compress(Bitmap.CompressFormat.PNG, 90, stream)
    return stream.toByteArray()
}