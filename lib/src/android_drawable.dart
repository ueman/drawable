import 'dart:typed_data';
import 'dart:ui';

import 'package:drawable/src/drawables/adaptive_icon_drawable.dart';
import 'package:drawable/src/drawables/bitmap_drawable.dart';
import 'package:drawable/src/drawables/color_drawable.dart';
import 'package:drawable/src/drawable_type.dart';
import 'package:drawable/src/drawables/vector_drawable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

const _id = 'id';
const _type = 'type';
const _scale = 'scale';
const _background = 'background';
const _foreground = 'foreground';

/// This class loads different kinds of Android drawables
class AndroidDrawable {
  const AndroidDrawable();

  static const MethodChannel _channel = MethodChannel('de.ju.drawable');

  Future<BitmapDrawable?> loadBitmap({
    required String name,
    DrawableType type = DrawableType.drawable,
  }) async {
    final bitmapData = await _channel.invokeMethod<Uint8List>('bitmap', {
      _id: name,
      _type: describeEnum(type),
    });
    if (bitmapData == null) {
      return null;
    }
    return BitmapDrawable(bitmapData);
  }

  Future<VectorDrawable?> loadVector({
    required String name,
    DrawableType type = DrawableType.drawable,
    int scale = 1,
  }) async {
    final data = await _channel.invokeMethod<Uint8List>('vector', {
      _id: name,
      _type: describeEnum(type),
      _scale: scale,
    });
    if (data == null) {
      return null;
    }
    return VectorDrawable(data);
  }

  Future<ColorDrawable?> loadColor({
    required String name,
  }) async {
    final data = await _channel.invokeMethod<int>('color', {
      _id: name,
    });
    if (data == null) {
      return null;
    }
    return ColorDrawable(Color(data));
  }

  Future<AdaptiveIconDrawable?> loadAdaptiveIcon({
    required String name,
    int scale = 1,
    DrawableType type = DrawableType.drawable,
  }) async {
    final data =
        await _channel.invokeMethod<Map<dynamic, dynamic>>('adaptiveIcon', {
      _id: name,
      _type: describeEnum(type),
      _scale: scale,
    });
    if (data == null) {
      return null;
    }
    return AdaptiveIconDrawable(
      data[_foreground] as Uint8List,
      data[_background] as Uint8List,
    );
  }
}
