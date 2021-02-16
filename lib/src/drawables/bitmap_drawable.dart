import 'dart:typed_data';

/// See also:
///   - [Bitmap](https://developer.android.com/guide/topics/resources/drawable-resource#Bitmap)
///   - [BitmapDrawable](https://developer.android.com/reference/android/graphics/drawable/BitmapDrawable)
class BitmapDrawable {
  BitmapDrawable(this.content);
  final Uint8List content;
}
