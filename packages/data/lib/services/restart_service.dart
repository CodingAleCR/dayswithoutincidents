import 'package:data/local/database/database.dart' as db;
import 'package:domain/domain.dart';
import 'package:drift/drift.dart';

/// Service for handling counter restarts
class CounterRestartServiceImpl extends CounterRestartService {
  /// Constructor
  CounterRestartServiceImpl({
    db.AppDatabase? database,
  }) : _database = database ?? db.AppDatabase();

  final db.AppDatabase _database;

  @override
  Future<void> deleteById(String uuid) async {
    _database.delete(_database.counterRestarts).where(
          (t) => t.id.equals(uuid),
        );
  }

  @override
  Future<List<CounterRestart>> findAll() async {
    final entities = await _database.select(_database.counterRestarts).get();

    return entities
        .map(
          (e) => CounterRestart(
            id: e.id,
            counter: TimeCounter.empty.copyWith(
              id: e.counterId,
            ),
            startedAt: DateTime.tryParse(e.startedAt),
            restartedAt: DateTime.tryParse(e.restartedAt),
          ),
        )
        .toList();
  }

  @override
  Future<CounterRestart> findById(String uuid) async {
    final entity = await (_database.select(_database.counterRestarts)
          ..where(
            (t) => t.id.equals(uuid),
          ))
        .getSingle();

    return CounterRestart(
      id: entity.id,
      counter: TimeCounter.empty.copyWith(
        id: entity.counterId,
      ),
      startedAt: DateTime.tryParse(entity.startedAt),
      restartedAt: DateTime.tryParse(entity.restartedAt),
    );
  }

  @override
  Future<CounterRestart> save(CounterRestart model) async {
    final entity = db.CounterRestart(
      id: model.id,
      counterId: model.counter.id,
      startedAt: model.startedAt!.toIso8601String(),
      restartedAt: model.restartedAt!.toIso8601String(),
    );

    await _database.into(_database.counterRestarts).insert(entity);

    return CounterRestart(
      id: entity.id,
      counter: TimeCounter.empty.copyWith(
        id: entity.counterId,
      ),
      startedAt: DateTime.tryParse(entity.startedAt),
      restartedAt: DateTime.tryParse(entity.restartedAt),
    );
  }

  @override
  Future<List<CounterRestart>> findAllByCounter(
    TimeCounter counter, {
    String? sortBy,
  }) async {
    if (sortBy != null) {
      final entities = await (_database.select(_database.counterRestarts)
            ..where(
              (t) => t.counterId.equals(counter.id),
            )
            ..orderBy(
              [
                (t) => OrderingTerm(
                      expression:
                          sortBy == 'startedAt' ? t.startedAt : t.restartedAt,
                    ),
              ],
            ))
          .get();

      return entities
          .map(
            (e) => CounterRestart(
              id: e.id,
              counter: TimeCounter.empty.copyWith(
                id: e.counterId,
              ),
              startedAt: DateTime.tryParse(e.startedAt),
              restartedAt: DateTime.tryParse(e.restartedAt),
            ),
          )
          .toList();
    }

    final entities = await (_database.select(_database.counterRestarts)
          ..where(
            (t) => t.counterId.equals(counter.id),
          ))
        .get();

    return entities
        .map(
          (e) => CounterRestart(
            id: e.id,
            counter: TimeCounter.empty.copyWith(
              id: e.counterId,
            ),
            startedAt: DateTime.tryParse(e.startedAt),
            restartedAt: DateTime.tryParse(e.restartedAt),
          ),
        )
        .toList();
  }
}
