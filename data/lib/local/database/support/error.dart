class DatabaseException implements Exception {
  String cause;
  DatabaseException(this.cause);

  @override
  String toString() {
    return "DatabaseException { cause: $cause}";
  }
}

class EntityNotFoundException extends DatabaseException {
  EntityNotFoundException(String cause) : super(cause);

  @override
  String toString() {
    return "EntityNotFoundException { cause: $cause }";
  }
}
