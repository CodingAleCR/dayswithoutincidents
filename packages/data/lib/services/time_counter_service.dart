import 'package:data/local/database/database.dart' as db;
import 'package:domain/domain.dart';

/// Service that handles operations for time counters.
class TimeCounterServiceImpl extends TimeCounterService {
  /// Constructor
  TimeCounterServiceImpl({
    db.AppDatabase? database,
  }) : _database = database ?? db.AppDatabase();

  final db.AppDatabase _database;

  @override
  Stream<List<TimeCounter>> get allCounters =>
      _database.watchAllCounters().asBroadcastStream().map(
            (List<db.TimeCounter> entities) => entities
                .map(
                  (e) => TimeCounter(
                    id: e.id,
                    title: e.title ?? '',
                    createdAt: DateTime.tryParse(e.createdAt ?? ''),
                    theme: AppTheme.fromString(e.theme),
                  ),
                )
                .toList(),
          );

  @override
  Future<void> deleteById(String uuid) async {
    _database.delete(_database.timeCounters).where(
          (t) => t.id.equals(uuid),
        );
  }

  @override
  Future<List<TimeCounter>> findAll() async {
    final entities = await _database.select(_database.timeCounters).get();

    return entities
        .map(
          (e) => TimeCounter(
            id: e.id,
            title: e.title ?? '',
            createdAt: DateTime.tryParse(e.createdAt ?? ''),
            theme: AppTheme.fromString(e.theme),
          ),
        )
        .toList();
  }

  @override
  Future<TimeCounter> findById(String uuid) async {
    final entity = await (_database.select(_database.timeCounters)
          ..where((t) => t.id.equals(uuid)))
        .get();

    return TimeCounter(
      id: entity.first.id,
      title: entity.first.title ?? '',
      createdAt: DateTime.tryParse(entity.first.createdAt ?? ''),
      theme: AppTheme.fromString(entity.first.theme),
    );
  }

  @override
  Future<TimeCounter> save(TimeCounter model) async {
    final entity = db.TimeCounter(
      id: model.id,
      title: model.title,
      createdAt: model.createdAt?.toIso8601String(),
      theme: model.theme.key(),
    );

    await _database.into(_database.timeCounters).insertOnConflictUpdate(entity);

    return model;
  }
}
