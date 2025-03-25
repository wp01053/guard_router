import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'guard_router_platform_interface.dart';

/// An implementation of [GuardRouterPlatform] that uses method channels.
class MethodChannelGuardRouter extends GuardRouterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('guard_router');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }
}
