package de.ju.drawable

import android.content.Context
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.ColorDrawable
import android.graphics.drawable.Drawable
import androidx.core.content.ContextCompat
import java.io.ByteArrayOutputStream

class DrawableLoader(private val context: Context) {
    fun loadBitmapDrawable(name: String): ByteArray? {
        return drawableByName(name)?.toBitmap()?.toByteArray()
    }

    fun loadColorDrawable(name: String): Int? {
        val drawable = drawableByName(name)
        if(drawable is ColorDrawable) {
            return drawable.color
        }
        return null
    }

    private fun drawableByName(name: String): Drawable? {
        try {
            val resourceId = context.resources.getIdentifier(name, "drawable", context.packageName)
            return ContextCompat.getDrawable(context, resourceId)
        } catch (_: Exception){ }
        return null
    }
}

fun Drawable.toBitmap(): Bitmap? {
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
        Bitmap.createBitmap(this.intrinsicWidth, this.intrinsicHeight, Bitmap.Config.ARGB_8888)
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