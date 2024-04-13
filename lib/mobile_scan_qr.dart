
import 'mobile_scan_qr_platform_interface.dart';

class MobileScanQr {
  Future<String?> getPlatformVersion() {
    return MobileScanQrPlatform.instance.getPlatformVersion();
  }
}
