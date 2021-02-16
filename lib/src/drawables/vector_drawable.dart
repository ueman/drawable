import 'dart:typed_data';

import 'package:drawable/src/drawables/bitmap_drawable.dart';

/// Even though this is a VectorDrawable there is no way to get it
/// as a vector from Android. So this is still a bitmap.
class VectorDrawable extends BitmapDrawable {
  VectorDrawable(Uint8List content) : super(content);
}
