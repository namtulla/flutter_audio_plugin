import 'dart:async';

import 'package:flutter/services.dart';

class FlutterAudio {
  static const MethodChannel _channel =
      const MethodChannel('flutter_audio');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> play(String path) async {
    Map<String, dynamic> params = <String, dynamic> {
      'path': path
    };

    _channel.invokeMethod('play', params);
  }

}