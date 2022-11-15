import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:mobile_info/mobile_info_method_channel.dart';

abstract class MobileInfoPlatform extends PlatformInterface {
  /// Constructs a MobileInfoPlatform.
  MobileInfoPlatform() : super(token: _token);

  static final Object _token = Object();

  static MobileInfoPlatform _instance = MethodChannelMobileInfo();

  /// The default instance of [MobileInfoPlatform] to use.
  ///
  /// Defaults to [MethodChannelMobileInfo].
  static MobileInfoPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MobileInfoPlatform] when
  /// they register themselves.
  static set instance(MobileInfoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Map<String, String>?> getSpecifications() {
    throw UnimplementedError('getSpecifications() has not been implemented.');
  }
}
