import 'dart:typed_data';

import 'package:drawable/src/drawables/bitmap_drawable.dart';
import 'package:drawable/src/drawables/color_drawable.dart';
import 'package:drawable/src/drawable_type.dart';
import 'package:drawable/src/drawables/vector_drawable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AndroidDrawable {
  static const MethodChannel _channel = MethodChannel('de.ju.drawable');

  Future<BitmapDrawable?> loadBitmap({
    required String name,
    DrawableType type = DrawableType.drawable,
  }) async {
    final bitmapData = await _channel.invokeMethod<Uint8List>('bitmap', {
      'id': name,
      'type': describeEnum(type),
    });
    if (bitmapData == null) {
      return null;
    }
    return BitmapDrawable(bitmapData);
  }

  Future<VectorDrawable?> loadVector({
    required String name,
    DrawableType type = DrawableType.drawable,
  }) async {
    return null;
  }

  Future<ColorDrawable?> loadColor({
    required String name,
    DrawableType type = DrawableType.drawable,
  }) async {
    return null;
  }
}
