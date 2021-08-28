abstract class Entity<T> {
  static String tablename() => "";
  Entity.fromModel(T model);
  Entity.fromDatabase(Map<String, dynamic> parsedJson);
  T toModel();
  Map<String, dynamic> toDatabaseMap();
}
