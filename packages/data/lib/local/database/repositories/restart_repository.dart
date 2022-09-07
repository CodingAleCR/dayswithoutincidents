import 'package:data/local/database/entities/entities.dart';
import 'package:data/local/database/support/support.dart';
import 'package:domain/domain.dart';

/// Implementation of database repository for a CounterRestart
class CounterRestartRepository
    extends Repository<CounterRestart, CounterRestartEntity> {
  @override
  String get tablename => CounterRestartEntity.tablename;

  @override
  CounterRestartEntity parseMap(Map<String, Object?> map) =>
      CounterRestartEntity.fromDatabase(map);

  /// Finds all restarts by counter ID.
  Future<List<CounterRestartEntity>> findAllByCounterId(
    String counterUuid,
  ) async {
    final db = await database;
    final maps = await db.query(
      CounterRestartEntity.tablename,
      where: '${CounterRestartEntity.kCounterId} = ?',
      whereArgs: [counterUuid],
    );

    return maps.map(parseMap).toList();
  }

  /// Finds all restarts by counter ID.
  Future<List<CounterRestartEntity>> findAllByCounterIdSortBy(
    String counterUuid,
    String sortBy,
  ) async {
    final db = await database;
    final maps = await db.query(
      CounterRestartEntity.tablename,
      where: '${CounterRestartEntity.kCounterId} = ?',
      whereArgs: [counterUuid],
      orderBy: sortBy,
    );

    return maps.map(parseMap).toList();
  }
}
