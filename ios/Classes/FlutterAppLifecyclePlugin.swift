import Flutter
import UIKit

public class FlutterAppLifecyclePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_app_lifecycle", binaryMessenger: registrar.messenger())
    let instance = FlutterAppLifecyclePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    instance.regsiterNotice()
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    
    func regsiterNotice() {
        NotificationCenter.default.addObserver(self, selector: #selector(tb_applicationDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector((tb_applicationWillEnterForeground)), name: UIApplication.willEnterForegroundNotification, object: nil)
        }
    
    // 应用程序进入后台
    @objc func tb_applicationDidEnterBackground() {
        // 在应用程序进入后台时执行的代码
        //    FlutterAppLifecyclePlugin.applicationDidEnterBackground(application)
        print("应用程序进入后台")
    }

    // 应用程序进入前台
    @objc func tb_applicationWillEnterForeground() {
        // 在应用程序进入前台时执行的代码
        //    FlutterAppLifecyclePlugin.applicationDidEnterBackground(application)
        print("应用程序进入前台")
    }
}
