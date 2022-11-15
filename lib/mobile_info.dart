import 'package:mobile_info/mobile_info_platform_interface.dart';

class MobileInfo {
  Future<Map<String, String>?> getSpecifications() {
    /// Invoke default instance of method_channel from MobileInfoPlatform.
    return MobileInfoPlatform.instance.getSpecifications();
  }
}
