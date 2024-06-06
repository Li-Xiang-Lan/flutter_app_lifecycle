
import 'package:flutter_app_lifecycle/app_state_observer.dart';

import 'flutter_app_lifecycle_platform_interface.dart';

class FlutterAppLifecycle {
  factory FlutterAppLifecycle()=>_getInstance();
  static FlutterAppLifecycle get instance => _getInstance();
  static FlutterAppLifecycle? _instance;
  static FlutterAppLifecycle _getInstance(){
    _instance??=FlutterAppLifecycle._internal();
    return _instance!;
  }

  FlutterAppLifecycle._internal();

  Future<void> setCallObserver(AppStateObserver appStateObserver)async{
    await FlutterAppLifecyclePlatform.instance.setAppStateObserver(appStateObserver);
  }
}
