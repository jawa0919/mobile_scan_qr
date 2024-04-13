import 'dart:ui';

import '../enums/camera_facing.dart';
import '../enums/torch_state.dart';
import 'mobile_scan_qr_exception.dart';

/// This class represents the current state of a [MobileScanQrController].
class MobileScanQrState {
  /// Create a new [MobileScanQrState] instance.
  const MobileScanQrState({
    required this.availableCameras,
    required this.cameraDirection,
    required this.isInitialized,
    required this.isRunning,
    required this.size,
    required this.torchState,
    required this.zoomScale,
    this.error,
  });

  /// Create a new [MobileScanQrState] instance that is uninitialized.
  const MobileScanQrState.uninitialized(CameraFacing facing)
      : this(
          availableCameras: null,
          cameraDirection: facing,
          isInitialized: false,
          isRunning: false,
          size: Size.zero,
          torchState: TorchState.unavailable,
          zoomScale: 1.0,
        );

  /// The number of available cameras.
  ///
  /// This is null if the number of cameras is unknown.
  final int? availableCameras;

  /// The facing direction of the camera.
  final CameraFacing cameraDirection;

  /// The error that occurred while setting up or using the canera.
  final MobileScanQrException? error;

  /// Whether the mobile scanner has initialized successfully.
  ///
  /// This is `true` if the camera is ready to be used.
  final bool isInitialized;

  /// Whether the mobile scanner is currently running.
  ///
  /// This is `true` if the camera is active.
  final bool isRunning;

  /// The size of the camera output.
  final Size size;

  /// The current state of the flashlight of the camera.
  final TorchState torchState;

  /// The current zoom scale of the camera.
  final double zoomScale;

  /// Create a copy of this state with the given parameters.
  MobileScanQrState copyWith({
    int? availableCameras,
    CameraFacing? cameraDirection,
    MobileScanQrException? error,
    bool? isInitialized,
    bool? isRunning,
    Size? size,
    TorchState? torchState,
    double? zoomScale,
  }) {
    return MobileScanQrState(
      availableCameras: availableCameras ?? this.availableCameras,
      cameraDirection: cameraDirection ?? this.cameraDirection,
      error: error,
      isInitialized: isInitialized ?? this.isInitialized,
      isRunning: isRunning ?? this.isRunning,
      size: size ?? this.size,
      torchState: torchState ?? this.torchState,
      zoomScale: zoomScale ?? this.zoomScale,
    );
  }
}
