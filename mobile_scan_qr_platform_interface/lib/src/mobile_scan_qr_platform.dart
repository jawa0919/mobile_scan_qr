import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class MobileScanQrPlatform extends PlatformInterface {
  MobileScanQrPlatform() : super(token: _token);
  static final Object _token = Object();
  static late MobileScanQrPlatform _instance;
  static MobileScanQrPlatform get instance => _instance;
  static set instance(MobileScanQrPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
