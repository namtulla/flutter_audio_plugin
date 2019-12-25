import Flutter
import UIKit
import AVFoundation

public class SwiftFlutterAudioPlugin: NSObject, FlutterPlugin {
    
    var audioPlayer = AVPlayer()
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_audio", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterAudioPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if (call.method == "getPlatformVersion") {
        result("iOS " + UIDevice.current.systemVersion)
    } else if (call.method == "play") {
        guard let args = call.arguments else {
            return
        }
        
        let myArgs = args as? [String: Any]
        let path = myArgs?["path"] as? String
        
        if let unwrapped = path {
            guard let url = URL.init(string: unwrapped) else { return }
            let playerItem = AVPlayerItem(url: url)
            self.audioPlayer = AVPlayer(playerItem: playerItem)
            self.audioPlayer.volume = 1.0
            self.audioPlayer.play()
        }
        
        result("yay")
    }
  }
}
