import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_info/mobile_info.dart';
import 'package:mobile_info/mobile_info_platform_interface.dart';
import 'package:mobile_info/mobile_info_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMobileInfoPlatform
    with MockPlatformInterfaceMixin
    implements MobileInfoPlatform {

  @override
  Future<String?> getSpecifications() => Future.value('42');
}

void main() {
  final MobileInfoPlatform initialPlatform = MobileInfoPlatform.instance;

  test('$MethodChannelMobileInfo is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMobileInfo>());
  });

  test('getPlatformVersion', () async {
    MobileInfo mobileInfoPlugin = MobileInfo();
    MockMobileInfoPlatform fakePlatform = MockMobileInfoPlatform();
    MobileInfoPlatform.instance = fakePlatform;

    expect(await mobileInfoPlugin.getSpecifications(), '42');
  });
}
