import 'package:data/local/database/database.dart';
import 'package:data/local/database/support/entity.dart';
import 'package:data/local/database/support/error.dart';
import 'package:sqflite/sqflite.dart';

abstract class Repository<EntityClass extends Entity> {
  late Future<Database> _db;

  Repository() {
    this._db = openDWIDatabase();
  }

  String tablename();
  EntityClass parseMap(Map<String, Object?> map);

  Future<List<EntityClass>> findAll() async {
    final db = await _db;
    final maps = await db.query(
      tablename(),
      columns: null,
    );

    return maps.map((map) => parseMap(map)).toList();
  }

  Future<EntityClass> findById(String uuid) async {
    final db = await _db;

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
    final db = await _db;

    await db.insert(
      tablename(),
      entity.toDatabaseMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<bool> deleteById(String uuid) async {
    final db = await _db;

    int count = await db.delete(
      tablename(),
      where: "id = ?",
      whereArgs: [uuid],
    );

    return count > 0;
  }

  Future close() async {
    final db = await _db;
    await db.close();
  }
}
