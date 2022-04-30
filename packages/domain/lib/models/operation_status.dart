/// Defines all possible states of an I/O operation.
enum OperationStatus {
  /// Initial state of an operation.
  idle,

  /// while the operation is performed
  loading,

  /// When the operation finishes successfully.
  success,

  /// When the operation fails to finish.
  failure,
}
