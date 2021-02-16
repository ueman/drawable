import 'dart:typed_data';

import 'package:drawable/drawable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'image_data.dart';

void main() {
  const channel = MethodChannel('de.ju.drawable');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return Uint8List.fromList(kBlueRectPng);
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  testWidgets('test that DrawableImage shows the expected image',
      (tester) async {
    await setGoldenImageSurfaceSize(tester);

    const widget = MyTestApp(
      child: Center(
        child: Image(image: DrawableImage('foo')),
      ),
    );
    await tester.runAsync(() async {
      await tester.pumpWidget(widget);
      final element = tester.element(find.byType(Image));
      final image = element.widget as Image;
      await precacheImage(image.image, element);
      await tester.pumpAndSettle();
    });

    await expectLater(
      find.byType(Image),
      matchesGoldenFile('golden_images/image.png'),
    );
  });
}

class MyTestApp extends StatelessWidget {
  const MyTestApp({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('foo')),
        body: child,
      ),
    );
  }
}

/// use a portrait format for golden images
Future<void> setGoldenImageSurfaceSize(WidgetTester tester) async {
  // iPhone 11 Pro Max, portrait
  const width = 414.0;
  const height = 896.0;
  const pixelRation = 1.0;

  tester.binding.window.devicePixelRatioTestValue = pixelRation;
  await tester.binding.setSurfaceSize(const Size(width, height));
}
