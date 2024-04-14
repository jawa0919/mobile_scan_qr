library mobile_scan_qr_ios;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:mobile_scan_qr_platform_interface/mobile_scan_qr_platform_interface.dart';

class MobileScanQrIos extends MobileScanQrPlatform {
  static void registerWith() {
    MobileScanQrPlatform.instance = MobileScanQrIos();
  }

  @visibleForTesting
  final mc = const MethodChannel('mobile_scan_qr_ios');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await mc.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
