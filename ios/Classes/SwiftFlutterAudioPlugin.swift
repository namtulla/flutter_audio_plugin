import Flutter
import UIKit
import AVFoundation

public class SwiftFlutterAudioPlugin: NSObject, FlutterPlugin {
    
    var audioPlayer = AVPlayer()
    var registrar: FlutterPluginRegistrar? = nil
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_audio", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterAudioPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    instance.registrar = registrar
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
            let key = registrar?.lookupKey(forAsset: unwrapped)
            let p = Bundle.main.path(forResource: key, ofType: nil)!
            let url = URL(fileURLWithPath: p)
            
            let playerItem = AVPlayerItem(url: url)
            self.audioPlayer = AVPlayer(playerItem: playerItem)
            self.audioPlayer.volume = 1.0
            self.audioPlayer.play()
        }
    }
  }
    
}
