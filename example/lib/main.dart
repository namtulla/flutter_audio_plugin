import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_audio/flutter_audio.dart';

void main() => runApp(MyApp());

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
          body: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Play"),
                      onPressed: play,
                    ),
                    RaisedButton(
                      child: Text("Stop"),
                      onPressed: stop,
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }

  play() async {
    await FlutterAudio.play("assets/test.mp3");
    print("clicked play");
  }

  stop() async {
    await FlutterAudio.stop();
    print("clicked stop");
  }

}
