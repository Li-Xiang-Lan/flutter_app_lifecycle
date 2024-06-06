import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app_lifecycle/flutter_app_lifecycle.dart';
import 'package:flutter_app_lifecycle/flutter_app_lifecycle_platform_interface.dart';
import 'package:flutter_app_lifecycle/flutter_app_lifecycle_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterAppLifecyclePlatform
    with MockPlatformInterfaceMixin
    implements FlutterAppLifecyclePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterAppLifecyclePlatform initialPlatform = FlutterAppLifecyclePlatform.instance;

  test('$MethodChannelFlutterAppLifecycle is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterAppLifecycle>());
  });

  test('getPlatformVersion', () async {
    FlutterAppLifecycle flutterAppLifecyclePlugin = FlutterAppLifecycle();
    MockFlutterAppLifecyclePlatform fakePlatform = MockFlutterAppLifecyclePlatform();
    FlutterAppLifecyclePlatform.instance = fakePlatform;

    expect(await flutterAppLifecyclePlugin.getPlatformVersion(), '42');
  });
}
