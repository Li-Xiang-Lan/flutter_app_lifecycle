import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_app_lifecycle_method_channel.dart';

abstract class FlutterAppLifecyclePlatform extends PlatformInterface {
  /// Constructs a FlutterAppLifecyclePlatform.
  FlutterAppLifecyclePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterAppLifecyclePlatform _instance = MethodChannelFlutterAppLifecycle();

  /// The default instance of [FlutterAppLifecyclePlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterAppLifecycle].
  static FlutterAppLifecyclePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterAppLifecyclePlatform] when
  /// they register themselves.
  static set instance(FlutterAppLifecyclePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
