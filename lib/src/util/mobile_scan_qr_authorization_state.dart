/// The authorization state of the scanner.
enum MobileScanQrAuthorizationState {
  /// The scanner has not yet requested the required permissions.
  undetermined(0),

  /// The scanner has the required permissions.
  authorized(1),

  /// The user denied the required permissions.
  denied(2);

  const MobileScanQrAuthorizationState(this.rawValue);

  factory MobileScanQrAuthorizationState.fromRawValue(int value) {
    switch (value) {
      case 0:
        return MobileScanQrAuthorizationState.undetermined;
      case 1:
        return MobileScanQrAuthorizationState.authorized;
      case 2:
        return MobileScanQrAuthorizationState.denied;
      default:
        throw ArgumentError.value(value, 'value', 'Invalid raw value.');
    }
  }

  /// The raw value for the state.
  final int rawValue;
}
