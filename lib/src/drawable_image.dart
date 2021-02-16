import 'dart:ui' as ui show Codec;

import 'package:drawable/drawable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

/// Loads the given Android Drawable identified by [name] as an image,
/// associating it with the given scale.
class DrawableImage extends ImageProvider<DrawableImage> {
  const DrawableImage(
    this.name, {
    this.scale = 1.0,
    this.androidDrawable = const AndroidDrawable(),
  });

  /// Useful for testing. Should not be set by user.
  final AndroidDrawable androidDrawable;

  /// The Drawable resource id. E.g. the "foo" in "R.drawable.foo"
  final String name;

  /// The scale to place in the [ImageInfo] object of the image.
  final double scale;

  @override
  Future<DrawableImage> obtainKey(ImageConfiguration configuration) {
    return Future<DrawableImage>.value(this);
  }

  @override
  ImageStreamCompleter load(DrawableImage key, DecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, decode),
      scale: key.scale,
      debugLabel: key.name,
      informationCollector: () sync* {
        yield ErrorDescription('Resource: $name');
      },
    );
  }

  Future<ui.Codec> _loadAsync(DrawableImage key, DecoderCallback decode) async {
    assert(key == this);

    final drawable = await androidDrawable.loadBitmap(name: name);
    if (drawable == null) {
      throw StateError(
        '$name does not exist and cannot be loaded as an image.',
      );
    }
    final bytes = drawable.content;

    return decode(bytes);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is DrawableImage && other.name == name && other.scale == scale;
  }

  @override
  int get hashCode => hashValues(name, scale);

  @override
  String toString() =>
      '${objectRuntimeType(this, 'DrawableImage')}("$name", scale: $scale)';
}
