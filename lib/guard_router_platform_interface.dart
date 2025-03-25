import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'guard_router_method_channel.dart';

abstract class GuardRouterPlatform extends PlatformInterface {
  /// Constructs a GuardRouterPlatform.
  GuardRouterPlatform() : super(token: _token);

  static final Object _token = Object();

  static GuardRouterPlatform _instance = MethodChannelGuardRouter();

  /// The default instance of [GuardRouterPlatform] to use.
  ///
  /// Defaults to [MethodChannelGuardRouter].
  static GuardRouterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GuardRouterPlatform] when
  /// they register themselves.
  static set instance(GuardRouterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
