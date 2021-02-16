import 'package:flutter/services.dart';

// ignore: avoid_classes_with_only_static_members
class Channel {
  static const MethodChannel _channel = MethodChannel('de.ju.drawable');

  static Future<String?> get platformVersion async {
    final version = await _channel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
