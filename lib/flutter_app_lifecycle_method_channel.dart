import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_app_lifecycle_platform_interface.dart';

/// An implementation of [FlutterAppLifecyclePlatform] that uses method channels.
class MethodChannelFlutterAppLifecycle extends FlutterAppLifecyclePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_app_lifecycle');

  MethodChannelFlutterAppLifecycle(){
    methodChannel.setMethodCallHandler((call)async{
      print("kkkkkkk===${call.method}");
    });
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
