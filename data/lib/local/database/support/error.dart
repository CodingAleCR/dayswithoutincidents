class DatabaseException implements Exception {
  String cause;
  DatabaseException(this.cause);
}

class EntityNotFoundException extends DatabaseException {
  EntityNotFoundException(String cause) : super(cause);
}
