import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_info/mobile_info_method_channel.dart';

void main() {
  MethodChannelMobileInfo platform = MethodChannelMobileInfo();
  const MethodChannel channel = MethodChannel('mobile_info');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return {"Platform": "Android 10"};
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getSpecifications', () async {
    expect(await platform.getSpecifications(), {"Platform": "Android 10"});
  });
}
