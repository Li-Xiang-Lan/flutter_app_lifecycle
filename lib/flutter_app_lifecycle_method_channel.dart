import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_lifecycle/app_state_observer.dart';

import 'flutter_app_lifecycle_platform_interface.dart';

/// An implementation of [FlutterAppLifecyclePlatform] that uses method channels.
class MethodChannelFlutterAppLifecycle extends FlutterAppLifecyclePlatform {
  AppStateObserver? _appStateObserver;

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_app_lifecycle');

  MethodChannelFlutterAppLifecycle(){
    methodChannel.setMethodCallHandler((call)async{
      if(call.method=="result"){
        _appStateObserver?.call.call(call.arguments["back"]);
      }
    });
  }

  @override
  Future<void> setAppStateObserver(AppStateObserver observer)async{
    _appStateObserver=observer;
  }
}
