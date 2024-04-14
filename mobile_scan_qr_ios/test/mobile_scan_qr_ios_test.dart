import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scan_qr_ios/mobile_scan_qr_ios.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MobileScanQrIos platform = MobileScanQrIos();
  const MethodChannel channel = MethodChannel('mobile_scan_qr_ios');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
