import 'dart:typed_data';

import 'package:drawable/src/drawables/drawable.dart';

/// See also:
///   - [Bitmap](https://developer.android.com/guide/topics/resources/drawable-resource#Bitmap)
///   - [BitmapDrawable](https://developer.android.com/reference/android/graphics/drawable/BitmapDrawable)
class BitmapDrawable with Drawable {
  BitmapDrawable(this.content);
  final Uint8List content;
}
