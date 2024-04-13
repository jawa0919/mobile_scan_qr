import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scan_qr/mobile_scan_qr.dart';
import 'package:mobile_scan_qr/mobile_scan_qr_platform_interface.dart';
import 'package:mobile_scan_qr/mobile_scan_qr_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMobileScanQrPlatform
    with MockPlatformInterfaceMixin
    implements MobileScanQrPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MobileScanQrPlatform initialPlatform = MobileScanQrPlatform.instance;

  test('$MethodChannelMobileScanQr is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMobileScanQr>());
  });

  test('getPlatformVersion', () async {
    MobileScanQr mobileScanQrPlugin = MobileScanQr();
    MockMobileScanQrPlatform fakePlatform = MockMobileScanQrPlatform();
    MobileScanQrPlatform.instance = fakePlatform;

    expect(await mobileScanQrPlugin.getPlatformVersion(), '42');
  });
}
