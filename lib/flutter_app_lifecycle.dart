
import 'flutter_app_lifecycle_platform_interface.dart';

class FlutterAppLifecycle {
  Future<String?> getPlatformVersion() {
    return FlutterAppLifecyclePlatform.instance.getPlatformVersion();
  }
}
