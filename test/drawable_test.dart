import 'dart:typed_data';

import 'package:drawable/drawable.dart';
import 'package:drawable/src/drawable_type.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const channel = MethodChannel('de.ju.drawable');

  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('loadBitmap', () async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      expect(methodCall.method, 'bitmap');
      expect(methodCall.arguments['id'], 'foo');
      expect(methodCall.arguments['type'], 'drawable');
      return Uint8List(0);
    });

    final drawable = await AndroidDrawable().loadBitmap(name: 'foo');
    expect(drawable?.content, Uint8List(0));
  });

  group('loadVector', () {
    test('simple', () async {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'vector');
        expect(methodCall.arguments['id'], 'foo');
        expect(methodCall.arguments['type'], 'drawable');
        expect(methodCall.arguments['scale'], 1);
        return Uint8List(0);
      });

      final drawable = await AndroidDrawable().loadVector(name: 'foo');
      expect(drawable?.content, Uint8List(0));
    });

    test('with scale and as mipmap', () async {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'vector');
        expect(methodCall.arguments['id'], 'foo');
        expect(methodCall.arguments['type'], 'mipmap');
        expect(methodCall.arguments['scale'], 2);
        return Uint8List(0);
      });

      final drawable = await AndroidDrawable().loadVector(
        name: 'foo',
        scale: 2,
        type: DrawableType.mipmap,
      );
      expect(drawable?.content, Uint8List(0));
    });
  });
}
