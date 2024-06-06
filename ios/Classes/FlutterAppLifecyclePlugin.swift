import Flutter
import UIKit

public class FlutterAppLifecyclePlugin: NSObject, FlutterPlugin {
    private let channel: FlutterMethodChannel
    let registrar: FlutterPluginRegistrar
    var messager: FlutterBinaryMessenger {
        return registrar.messenger()
    }
    
    init(registrar: FlutterPluginRegistrar) {
        self.channel = FlutterMethodChannel(
            name: "flutter_app_lifecycle",
            binaryMessenger: registrar.messenger()
        )
        self.registrar = registrar
        super.init()
    }
    
  public static func register(with registrar: FlutterPluginRegistrar) {
      let instance = FlutterAppLifecyclePlugin.init(registrar: registrar)
      instance.regsiterNotice()
      registrar.addMethodCallDelegate(instance, channel: instance.channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    switch call.method {
    case "getPlatformVersion":
        channel.invokeMethod("result", arguments: nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    
    func regsiterNotice() {
        NotificationCenter.default.addObserver(self, selector: #selector(tb_applicationDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector((tb_applicationWillEnterForeground)), name: UIApplication.willEnterForegroundNotification, object: nil)
        }
    
    @objc func tb_applicationDidEnterBackground() {
        channel.invokeMethod("result", arguments: ["back":true])
    }

    // 应用程序进入前台
    @objc func tb_applicationWillEnterForeground() {
        channel.invokeMethod("result", arguments: ["back":false])
    }
}
