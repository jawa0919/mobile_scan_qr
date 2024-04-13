import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mobile_scan_qr_method_channel.dart';

abstract class MobileScanQrPlatform extends PlatformInterface {
  /// Constructs a MobileScanQrPlatform.
  MobileScanQrPlatform() : super(token: _token);

  static final Object _token = Object();

  static MobileScanQrPlatform _instance = MethodChannelMobileScanQr();

  /// The default instance of [MobileScanQrPlatform] to use.
  ///
  /// Defaults to [MethodChannelMobileScanQr].
  static MobileScanQrPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MobileScanQrPlatform] when
  /// they register themselves.
  static set instance(MobileScanQrPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
