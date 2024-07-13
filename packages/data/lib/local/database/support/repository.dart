import 'package:data/local/database/database.dart';
import 'package:sqflite/sqflite.dart';

/// Generic repository that interacts with a local SQLite database.
abstract class Repository<Model, EntityClass extends Entity<Model>> {
  /// Constructor
  Repository() {
    database = openDWIDatabase();
  }

  /// Database instance
  late Future<Database> database;

  /// Parser for maps into Entities
  EntityClass parseMap(Map<String, Object?> map);

  /// Name of the table
  String get tablename;

  /// Finds all entities in the database.
  Future<List<EntityClass>> findAll() async {
    final db = await database;
    final maps = await db.query(
      tablename,
    );

    return maps.map(parseMap).toList();
  }

  /// Finds a single entity in the database that matches [uuid]
  ///
  /// Throws [EntityNotFoundException] if the entity is not found.
  Future<EntityClass> findById(String uuid) async {
    final db = await database;

    final maps = await db.query(
      tablename,
      where: 'id = ?',
      whereArgs: [uuid],
    );

    if (maps.isEmpty) {
      throw EntityNotFoundException(
        'The id does not correspond with any row in $tablename',
      );
    }

    return parseMap(maps.first);
  }

  /// Inserts or updates an entity in the database.
  Future<void> save(EntityClass entity) async {
    final db = await database;

    final existingEntity = await db.query(
      tablename,
      where: 'id = ?',
      whereArgs: [entity.primaryKey],
    );

    if (existingEntity.isEmpty) {
      await db.insert(
        tablename,
        entity.toDatabaseMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return;
    }

    await db.update(
      tablename,
      entity.toDatabaseMap(),
      where: 'id = ?',
      whereArgs: [entity.primaryKey],
    );
  }

  /// Deletes an entity from the database that matches the [uuid] given.
  Future<bool> deleteById(String uuid) async {
    final db = await database;

    final count = await db.delete(
      tablename,
      where: 'id = ?',
      whereArgs: [uuid],
    );

    return count > 0;
  }

  /// Closes all database connections.
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
