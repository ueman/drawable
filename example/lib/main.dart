import 'package:drawable/drawable.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView(
          children: [
            const ListTile(title: Text('BitmapDrawable')),
            const Image(image: DrawableImage('flutter')),
            const ListTile(title: Text('VectorDrawable')),
            const Image(
              image: DrawableImage('child_care'),
              width: 80,
              height: 80,
            ),
            const ListTile(title: Text('ColorDrawable')),
            ColorDrawableWidget(),
          ],
        ),
      ),
    );
  }
}

class ColorDrawableWidget extends StatefulWidget {
  @override
  _ColorDrawableWidgetState createState() => _ColorDrawableWidgetState();
}

class _ColorDrawableWidgetState extends State<ColorDrawableWidget> {
  Color _color = Colors.transparent;

  @override
  void initState() {
    super.initState();
    loadColor();
  }

  Future<void> loadColor() async {
    final colorDrawable =
        await const AndroidDrawable().loadColor(name: 'example_color');
    setState(() {
      _color = colorDrawable?.color ?? Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _color,
      width: 50,
      height: 50,
    );
  }
}
