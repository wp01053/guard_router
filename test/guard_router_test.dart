import 'package:flutter_test/flutter_test.dart';
import 'package:guard_router/guard_router_method_channel.dart';
import 'package:guard_router/guard_router_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGuardRouterPlatform
    with MockPlatformInterfaceMixin
    implements GuardRouterPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final GuardRouterPlatform initialPlatform = GuardRouterPlatform.instance;

  test('$MethodChannelGuardRouter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGuardRouter>());
  });
}
