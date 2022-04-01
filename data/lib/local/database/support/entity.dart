abstract class Entity<T> {
  Entity.fromModel(T model);
  Entity.fromDatabase(Map<String, dynamic> parsedJson);
  T toModel();
  Map<String, dynamic> toDatabaseMap();
  String primaryKey();
}
