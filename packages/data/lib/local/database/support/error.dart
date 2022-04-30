/// Exception thrown when an I/O operation is done in the database.
class DatabaseException implements Exception {
  /// Constructor
  DatabaseException(this.cause);

  /// Caused by
  String cause;

  @override
  String toString() {
    return 'DatabaseException { cause: $cause}';
  }
}

/// Thrown when an entity is not found
class EntityNotFoundException extends DatabaseException {
  /// constructor
  EntityNotFoundException(String cause) : super(cause);

  @override
  String toString() {
    return 'EntityNotFoundException { cause: $cause }';
  }
}
