/// Reason for a localization exception.
enum LocalizationExceptionReason {
  /// Unknown
  unknown,

  /// When the context is invalid.
  invalidContext,

  /// When the key is invalid.
  invalidKey,
}

/// LocalizationException
class LocalizationException implements Exception {
  /// Base localization exception thrown for localization operations
  LocalizationException(
    this.message, {
    this.reason = LocalizationExceptionReason.unknown,
  });

  /// Reason for the exception
  LocalizationExceptionReason reason;

  /// User friendly message printed to console.
  String message;

  @override
  String toString() =>
      'LocalizationException occurred: {reason: $reason, message: $message}';
}
