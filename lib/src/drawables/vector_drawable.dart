import 'dart:typed_data';

import 'package:drawable/src/drawables/bitmap_drawable.dart';
import 'package:drawable/src/drawables/drawable.dart';

/// Even though this is a VectorDrawable there is no way to get it
/// as a vector from Android. So this is still a bitmap.
/// See also:
/// - [VectorDrawable](https://developer.android.com/reference/android/graphics/drawable/VectorDrawable)
class VectorDrawable extends BitmapDrawable with Drawable {
  VectorDrawable(Uint8List content) : super(content);
}
