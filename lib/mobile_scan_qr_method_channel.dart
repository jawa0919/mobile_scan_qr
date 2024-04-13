import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mobile_scan_qr_platform_interface.dart';

/// An implementation of [MobileScanQrPlatform] that uses method channels.
class MethodChannelMobileScanQr extends MobileScanQrPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mobile_scan_qr');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
