library mobile_scan_qr_android;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:mobile_scan_qr_platform_interface/mobile_scan_qr_platform_interface.dart';

class MobileScanQrAndroid extends MobileScanQrPlatform {
  static void registerWith() {
    debugPrint("MobileScanQrAndroid static void registerWith");
    MobileScanQrPlatform.instance = MobileScanQrAndroid();
  }

  @visibleForTesting
  final mc = const MethodChannel('mobile_scan_qr_android');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await mc.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
