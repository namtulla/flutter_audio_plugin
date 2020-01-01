import 'package:flutter/material.dart';
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
                      onPressed: onPlay,
                    ),
                    RaisedButton(
                      child: Text("Pause"),
                      onPressed: onPause,
                    ),
                    RaisedButton(
                      child: Text("Stop"),
                      onPressed: onStop,
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }

  onPlay() async {
    await FlutterAudio.play("assets/test.mp3");
  }

  onStop() async {
    await FlutterAudio.stop();
  }

  onPause() async {
    await FlutterAudio.pause();
  }
}
