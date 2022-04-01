import 'package:data/local/database/database.dart';
import 'package:sqflite/sqflite.dart';

abstract class Repository<EntityClass extends Entity> {
  late Future<Database> database;

  Repository() {
    this.database = openDWIDatabase();
  }

  String tablename();
  EntityClass parseMap(Map<String, Object?> map);

  Future<List<EntityClass>> findAll() async {
    final db = await database;
    final maps = await db.query(
      tablename(),
      columns: null,
    );

    return maps.map((map) => parseMap(map)).toList();
  }

  Future<EntityClass> findById(String uuid) async {
    final db = await database;

    final maps = await db.query(
      tablename(),
      columns: null,
      where: "id = ?",
      whereArgs: [uuid],
    );

    if (maps.isEmpty) {
      throw EntityNotFoundException(
        "The id does not correspond with any row in ${tablename()}",
      );
    }

    return parseMap(maps.first);
  }

  Future<void> save(EntityClass entity) async {
    final db = await database;

    final existingEntity = await db.query(
      tablename(),
      columns: null,
      where: "id = ?",
      whereArgs: [entity.primaryKey()],
    );

    if (existingEntity.isEmpty) {
      await db.insert(
        tablename(),
        entity.toDatabaseMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return;
    }

    await db.update(
      tablename(),
      entity.toDatabaseMap(),
      where: "id = ?",
      whereArgs: [entity.primaryKey()],
    );
  }

  Future<bool> deleteById(String uuid) async {
    final db = await database;

    int count = await db.delete(
      tablename(),
      where: "id = ?",
      whereArgs: [uuid],
    );

    return count > 0;
  }

  Future close() async {
    final db = await database;
    await db.close();
  }
}
