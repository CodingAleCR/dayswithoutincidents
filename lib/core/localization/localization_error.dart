enum LocalizationExceptionReason {
  unknown,
  invalidContext,
  invalidKey,
}

class LocalizationException implements Exception {
  LocalizationExceptionReason reason;
  String message;

  LocalizationException(
    this.message, {
    this.reason = LocalizationExceptionReason.unknown,
  });
}
