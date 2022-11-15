import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mobile_info/mobile_info_platform_interface.dart';



/// An implementation of [MobileInfoPlatform] that uses method channels.
class MethodChannelMobileInfo extends MobileInfoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mobile_info');

  @override
  Future<Map<String, String>?> getSpecifications() async {
    final specifications = await methodChannel.invokeMethod('getSpecifications');
    return Map<String, String>.from(specifications);
  }
}
