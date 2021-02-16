import 'dart:async';
import 'dart:ui' as ui;

import 'package:drawable/drawable.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/foundation.dart'
    show SynchronousFuture, describeIdentity;

// See https://github.com/flutter/plugins/blob/master/packages/ios_platform_images/lib/ios_platform_images.dart

// ignore: avoid_classes_with_only_static_members
class DrawableProvider {
  static final AndroidDrawable _drawable = AndroidDrawable();

  /// Loads an image from asset catalogs.  The equivalent would be:
  /// `[UIImage imageNamed:name]`.
  ///
  /// Throws an exception if the image can't be found.
  ///
  /// See [https://developer.apple.com/documentation/uikit/uiimage/1624146-imagenamed?language=objc]
  static ImageProvider load(String name) {
    final drawableFuture = _drawable.loadBitmap(name: name);
    final bytesCompleter = Completer<BitmapDrawable>();

    drawableFuture.then((drawable) {
      if (drawable == null) {
        bytesCompleter.completeError(
          Exception("Image couldn't be found: $name"),
        );
        return;
      }
      bytesCompleter.complete(drawable);
    });
    return _FutureMemoryImage(bytesCompleter.future);
  }
}

class _FutureImageStreamCompleter extends ImageStreamCompleter {
  _FutureImageStreamCompleter({
    required Future<ui.Codec> codec,
    this.informationCollector,
  }) {
    codec.then<void>(_onCodecReady, onError: (dynamic error, StackTrace stack) {
      reportError(
        context: ErrorDescription('resolving a single-frame image stream'),
        exception: Exception(error),
        stack: stack,
        informationCollector: informationCollector,
        silent: true,
      );
    });
  }

  final InformationCollector? informationCollector;

  Future<void> _onCodecReady(ui.Codec codec) async {
    try {
      final nextFrame = await codec.getNextFrame();
      setImage(ImageInfo(image: nextFrame.image));
    } catch (exception, stack) {
      reportError(
        context: ErrorDescription('resolving an image frame'),
        exception: exception,
        stack: stack,
        informationCollector: informationCollector,
        silent: true,
      );
    }
  }
}

/// Performs exactly like a [MemoryImage] but instead of taking in bytes
/// it takes in a future that represents bytes.
class _FutureMemoryImage extends ImageProvider<_FutureMemoryImage> {
  /// Constructor for FutureMemoryImage.  [_futureBytes] is the bytes that will
  /// be loaded into an image and [_futureScale] is the scale that will be
  /// applied to that image to account for high-resolution images.
  const _FutureMemoryImage(
    this._futureBytes,
  );

  final Future<BitmapDrawable> _futureBytes;

  /// See [ImageProvider.obtainKey].
  @override
  Future<_FutureMemoryImage> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<_FutureMemoryImage>(this);
  }

  /// See [ImageProvider.load].
  @override
  ImageStreamCompleter load(_FutureMemoryImage key, DecoderCallback decode) {
    return _FutureImageStreamCompleter(
      codec: _loadAsync(key, decode),
    );
  }

  Future<ui.Codec> _loadAsync(
    _FutureMemoryImage key,
    DecoderCallback decode,
  ) async {
    assert(key == this);
    return _futureBytes.then((BitmapDrawable drawable) {
      return decode(drawable.content);
    });
  }

  /// See [ImageProvider.operator==].
  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    if (other is _FutureMemoryImage) {
      return _futureBytes == other._futureBytes;
    } else {
      return false;
    }
  }

  /// See [ImageProvider.hashCode].
  @override
  int get hashCode => _futureBytes.hashCode;

  /// See [ImageProvider.toString].
  @override
  String toString() => '$runtimeType(${describeIdentity(_futureBytes)})';
}
