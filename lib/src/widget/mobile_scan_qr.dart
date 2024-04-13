import 'dart:async';

import 'package:flutter/material.dart';

import '../../mobile_scan_qr_platform_interface.dart';
import '../util/mobile_scan_qr_exception.dart';
import '../util/mobile_scan_qr_state.dart';
import 'mobile_scan_qr_controller.dart';
import 'scan_window_calculation.dart';

/// The function signature for the error builder.
typedef MobileScanQrErrorBuilder = Widget Function(
  BuildContext,
  MobileScanQrException,
  Widget?,
);

/// This widget displays a live camera preview for the barcode scanner.
class MobileScanQr extends StatefulWidget {
  /// Create a new [MobileScanQr] using the provided [controller].
  const MobileScanQr({
    required this.controller,
    this.fit = BoxFit.cover,
    this.errorBuilder,
    this.overlayBuilder,
    this.placeholderBuilder,
    this.scanWindow,
    this.scanWindowUpdateThreshold = 0.0,
    super.key,
  });

  /// The controller for the camera preview.
  final MobileScanQrController controller;

  /// The error builder for the camera preview.
  ///
  /// If this is null, a black [ColoredBox],
  /// with a centered white [Icons.error] icon is used as error widget.
  final MobileScanQrErrorBuilder? errorBuilder;

  /// The [BoxFit] for the camera preview.
  ///
  /// Defaults to [BoxFit.cover].
  final BoxFit fit;

  /// The builder for the overlay above the camera preview.
  ///
  /// The resulting widget can be combined with the [scanWindow] rectangle
  /// to create a cutout for the camera preview.
  ///
  /// The [BoxConstraints] for this builder
  /// are the same constraints that are used to compute the effective [scanWindow].
  ///
  /// The overlay is only displayed when the camera preview is visible.
  final LayoutWidgetBuilder? overlayBuilder;

  /// The placeholder builder for the camera preview.
  ///
  /// If this is null, a black [ColoredBox] is used as placeholder.
  ///
  /// The placeholder is displayed when the camera preview is being initialized.
  final Widget Function(BuildContext, Widget?)? placeholderBuilder;

  /// The scan window rectangle for the barcode scanner.
  ///
  /// If this is not null, the barcode scanner will only scan barcodes
  /// which intersect this rectangle.
  ///
  /// This rectangle is relative to the layout size
  /// of the *camera preview widget* in the widget tree,
  /// rather than the actual size of the camera preview output.
  /// This is because the size of the camera preview widget
  /// might not be the same as the size of the camera output.
  ///
  /// For example, the applied [fit] has an effect on the size of the camera preview widget,
  /// while the camera preview size remains the same.
  ///
  /// The following example shows a scan window that is centered,
  /// fills half the height and one third of the width of the layout:
  ///
  /// ```dart
  /// LayoutBuider(
  ///   builder: (BuildContext context, BoxConstraints constraints) {
  ///     final Size layoutSize = constraints.biggest;
  ///
  ///     final double scanWindowWidth = layoutSize.width / 3;
  ///     final double scanWindowHeight = layoutSize.height / 2;
  ///
  ///     final Rect scanWindow = Rect.fromCenter(
  ///       center: layoutSize.center(Offset.zero),
  ///       width: scanWindowWidth,
  ///       height: scanWindowHeight,
  ///     );
  ///   }
  /// );
  /// ```
  final Rect? scanWindow;

  /// The threshold for updates to the [scanWindow].
  ///
  /// If the [scanWindow] would be updated,
  /// due to new layout constraints for the scanner,
  /// and the width or height of the new scan window have not changed by this threshold,
  /// then the scan window is not updated.
  ///
  /// It is recommended to set this threshold
  /// if scan window updates cause performance issues.
  ///
  /// Defaults to no threshold for scan window updates.
  final double scanWindowUpdateThreshold;

  @override
  State<MobileScanQr> createState() => _MobileScanQrState();
}

class _MobileScanQrState extends State<MobileScanQr> {
  /// The current scan window.
  Rect? scanWindow;

  /// Calculate the scan window based on the given [constraints].
  ///
  /// If the [scanWindow] is already set, this method does nothing.
  void _maybeUpdateScanWindow(
    MobileScanQrState scannerState,
    BoxConstraints constraints,
  ) {
    if (widget.scanWindow == null) {
      return;
    }

    final Rect newScanWindow = calculateScanWindowRelativeToTextureInPercentage(
      widget.fit,
      widget.scanWindow!,
      textureSize: scannerState.size,
      widgetSize: constraints.biggest,
    );

    // The scan window was never set before.
    // Set the initial scan window.
    if (scanWindow == null) {
      scanWindow = newScanWindow;

      unawaited(widget.controller.updateScanWindow(scanWindow));

      return;
    }

    // The scan window did not not change.
    // The left, right, top and bottom are the same.
    if (scanWindow == newScanWindow) {
      return;
    }

    // The update threshold is not set, allow updating the scan window.
    if (widget.scanWindowUpdateThreshold == 0.0) {
      scanWindow = newScanWindow;

      unawaited(widget.controller.updateScanWindow(scanWindow));

      return;
    }

    final double dx = (newScanWindow.width - scanWindow!.width).abs();
    final double dy = (newScanWindow.height - scanWindow!.height).abs();

    // The new scan window has changed enough, allow updating the scan window.
    if (dx >= widget.scanWindowUpdateThreshold ||
        dy >= widget.scanWindowUpdateThreshold) {
      scanWindow = newScanWindow;

      unawaited(widget.controller.updateScanWindow(scanWindow));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MobileScanQrState>(
      valueListenable: widget.controller,
      builder: (BuildContext context, MobileScanQrState value, Widget? child) {
        if (!value.isInitialized) {
          const Widget defaultPlaceholder = ColoredBox(color: Colors.black);

          return widget.placeholderBuilder?.call(context, child) ??
              defaultPlaceholder;
        }

        final MobileScanQrException? error = value.error;

        if (error != null) {
          const Widget defaultError = ColoredBox(
            color: Colors.black,
            child: Center(child: Icon(Icons.error, color: Colors.white)),
          );

          return widget.errorBuilder?.call(context, error, child) ??
              defaultError;
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            _maybeUpdateScanWindow(value, constraints);

            final Widget? overlay =
                widget.overlayBuilder?.call(context, constraints);
            final Size cameraPreviewSize = value.size;

            final Widget scannerWidget = ClipRect(
              child: SizedBox.fromSize(
                size: constraints.biggest,
                child: FittedBox(
                  fit: widget.fit,
                  child: SizedBox(
                    width: cameraPreviewSize.width,
                    height: cameraPreviewSize.height,
                    child: MobileScanQrPlatform.instance.buildCameraView(),
                  ),
                ),
              ),
            );

            if (overlay == null) {
              return scannerWidget;
            }

            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                scannerWidget,
                overlay,
              ],
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    // When this widget is unmounted, reset the scan window.
    unawaited(widget.controller.updateScanWindow(null));
  }
}
