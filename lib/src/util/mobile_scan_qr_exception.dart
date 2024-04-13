import 'mobile_scan_qr_error_code.dart';

/// This class represents an exception thrown by the mobile scanner.
class MobileScanQrException implements Exception {
  const MobileScanQrException({
    required this.errorCode,
    this.errorDetails,
  });

  /// The error code of the exception.
  final MobileScanQrErrorCode errorCode;

  /// The additional error details that came with the [errorCode].
  final MobileScannerErrorDetails? errorDetails;

  @override
  String toString() {
    if (errorDetails != null && errorDetails?.message != null) {
      return "MobileScanQrException: code ${errorCode.name}, message: ${errorDetails?.message}";
    }
    return "MobileScanQrException: ${errorCode.name}";
  }
}

/// The raw error details for a [MobileScanQrException].
class MobileScannerErrorDetails {
  const MobileScannerErrorDetails({
    this.code,
    this.details,
    this.message,
  });

  /// The error code from the [PlatformException].
  final String? code;

  /// The details from the [PlatformException].
  final Object? details;

  /// The error message from the [PlatformException].
  final String? message;
}

/// This class represents an exception that is thrown
/// when the scanner was (re)started while a permission request was pending.
///
/// This exception type is only used internally,
/// and is not part of the public API.
class PermissionRequestPendingException implements Exception {}
