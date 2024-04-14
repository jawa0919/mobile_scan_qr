library mobile_scan_qr;

import 'package:flutter/widgets.dart';
import 'package:mobile_scan_qr_platform_interface/mobile_scan_qr_platform_interface.dart';

class MobileScanQr {
  Future<String?> getPlatformVersion() async {
    debugPrint("MobileScanQr getPlatformVersion");
    return MobileScanQrPlatform.instance.getPlatformVersion();
  }
}
