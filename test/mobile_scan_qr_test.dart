import 'dart:ui';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_scan_qr/mobile_scan_qr.dart';
import 'package:mobile_scan_qr/mobile_scan_qr_platform_interface.dart';
import 'package:mobile_scan_qr/mobile_scan_qr_method_channel.dart';
import 'package:mobile_scan_qr/src/objects/start_options.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMobileScanQrPlatform
    with MockPlatformInterfaceMixin
    implements MobileScanQrPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<BarcodeCapture?> analyzeImage(String path) {
    // TODO: implement analyzeImage
    throw UnimplementedError();
  }

  @override
  // TODO: implement barcodesStream
  Stream<BarcodeCapture?> get barcodesStream => throw UnimplementedError();

  @override
  Widget buildCameraView() {
    // TODO: implement buildCameraView
    throw UnimplementedError();
  }

  @override
  Future<void> dispose() {
    // TODO: implement dispose
    throw UnimplementedError();
  }

  @override
  Future<void> resetZoomScale() {
    // TODO: implement resetZoomScale
    throw UnimplementedError();
  }

  @override
  void setBarcodeLibraryScriptUrl(String scriptUrl) {
    // TODO: implement setBarcodeLibraryScriptUrl
  }

  @override
  Future<void> setTorchState(TorchState torchState) {
    // TODO: implement setTorchState
    throw UnimplementedError();
  }

  @override
  Future<void> setZoomScale(double zoomScale) {
    // TODO: implement setZoomScale
    throw UnimplementedError();
  }

  @override
  Future<MobileScanQrViewAttributes> start(StartOptions startOptions) {
    // TODO: implement start
    throw UnimplementedError();
  }

  @override
  Future<void> stop() {
    // TODO: implement stop
    throw UnimplementedError();
  }

  @override
  // TODO: implement torchStateStream
  Stream<TorchState> get torchStateStream => throw UnimplementedError();

  @override
  Future<void> updateScanWindow(Rect? window) {
    // TODO: implement updateScanWindow
    throw UnimplementedError();
  }

  @override
  // TODO: implement zoomScaleStateStream
  Stream<double> get zoomScaleStateStream => throw UnimplementedError();
}

void main() {
  final MobileScanQrPlatform initialPlatform = MobileScanQrPlatform.instance;

  test('$MethodChannelMobileScanQr is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMobileScanQr>());
  });

  test('getPlatformVersion', () async {
    MethodChannelMobileScanQr mobileScanQrPlugin = MethodChannelMobileScanQr();
    MockMobileScanQrPlatform fakePlatform = MockMobileScanQrPlatform();
    MobileScanQrPlatform.instance = fakePlatform;

    expect(await mobileScanQrPlugin.getPlatformVersion(), '42');
  });
}
