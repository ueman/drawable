import 'dart:typed_data';
import 'dart:ui';

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
  group('loadBitmap', () {
    test('simple', () async {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'bitmap');
        expect(methodCall.arguments['id'], 'foo');
        expect(methodCall.arguments['type'], 'drawable');
        return Uint8List(0);
      });

      final drawable = await const AndroidDrawable().loadBitmap(name: 'foo');
      expect(drawable?.content, Uint8List(0));
    });

    test('complicated', () async {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'bitmap');
        expect(methodCall.arguments['id'], 'foo');
        expect(methodCall.arguments['type'], 'mipmap');
        return Uint8List(0);
      });

      final drawable = await const AndroidDrawable().loadBitmap(
        name: 'foo',
        type: DrawableType.mipmap,
      );
      expect(drawable?.content, Uint8List(0));
    });
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

      final drawable = await const AndroidDrawable().loadVector(name: 'foo');
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

      final drawable = await const AndroidDrawable().loadVector(
        name: 'foo',
        scale: 2,
        type: DrawableType.mipmap,
      );
      expect(drawable?.content, Uint8List(0));
    });
  });

  test('loadColor', () async {
    const color = Color(0x00ff69b4);
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      expect(methodCall.method, 'color');
      expect(methodCall.arguments['id'], 'foo');
      expect(methodCall.arguments['type'], null);
      return color.value;
    });

    final drawable = await const AndroidDrawable().loadColor(name: 'foo');
    expect(drawable!.color, color);
  });

  group('loadAdaptiveIcon', () {
    test('simple', () async {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'adaptiveIcon');
        expect(methodCall.arguments['id'], 'foo');
        expect(methodCall.arguments['type'], 'drawable');
        expect(methodCall.arguments['scale'], 1);
        return <dynamic, dynamic>{
          'foreground': Uint8List(0),
          'background': Uint8List(0),
        };
      });

      final drawable =
          await const AndroidDrawable().loadAdaptiveIcon(name: 'foo');
      expect(drawable!.foreground, Uint8List(0));
      expect(drawable.background, Uint8List(0));
    });

    test('with scale and as mipmap', () async {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        expect(methodCall.method, 'adaptiveIcon');
        expect(methodCall.arguments['id'], 'foo');
        expect(methodCall.arguments['type'], 'mipmap');
        expect(methodCall.arguments['scale'], 2);
        return <dynamic, dynamic>{
          'foreground': Uint8List(0),
          'background': Uint8List(0),
        };
      });

      final drawable = await const AndroidDrawable().loadAdaptiveIcon(
        name: 'foo',
        scale: 2,
        type: DrawableType.mipmap,
      );

      expect(drawable!.foreground, Uint8List(0));
      expect(drawable.background, Uint8List(0));
    });
  });
}
