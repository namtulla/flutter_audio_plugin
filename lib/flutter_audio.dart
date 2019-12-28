import 'dart:async';

import 'package:flutter/services.dart';

class FlutterAudio {
  static const MethodChannel _channel =
      const MethodChannel('flutter_audio');

  static Future<void> play(String path) async {
    Map<String, dynamic> params = <String, dynamic> {
      'path': path
    };

    await _channel.invokeMethod('play', params);
  }

  static Future<void> stop() async {
    await _channel.invokeMethod('stop');
  }

}