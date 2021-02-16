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
            Image(image: DrawableProvider.load('flutter')),
            const ListTile(title: Text('VectorDrawable')),
            Image(image: DrawableProvider.load('child_care')),
          ],
        ),
      ),
    );
  }
}
