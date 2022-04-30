/// Base Entity
// ignore_for_file: avoid_unused_constructor_parameters

abstract class Entity<Model> {
  /// Creates an entity from a model
  Entity.fromModel(Model model);

  /// Creates an entity from a map
  Entity.fromDatabase(Map<String, dynamic> parsedJson);

  /// Converts the entity into a BL model.
  Model toModel();

  /// Converts the Entity into something that the database can work.
  Map<String, dynamic> toDatabaseMap();

  /// Name of the primary key column
  String get primaryKey;
}
