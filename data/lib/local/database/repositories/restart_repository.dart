import 'package:data/local/database/entities/entities.dart';
import 'package:data/local/database/support/support.dart';

class CounterRestartRepository extends Repository<CounterRestartEntity> {
  @override
  String tablename() => CounterRestartEntity.tablename;

  @override
  CounterRestartEntity parseMap(Map<String, Object?> map) =>
      CounterRestartEntity.fromDatabase(map);

  Future<List<CounterRestartEntity>> findAllByCounterId(
    String counterUuid,
  ) async {
    final db = await database;
    final maps = await db.query(
      CounterRestartEntity.tablename,
      columns: null,
      where: "${CounterRestartEntity.COUNTER_ID} = ?",
      whereArgs: [counterUuid],
    );

    return maps.map((map) => parseMap(map)).toList();
  }
}
