import 'package:data/local/database/support/entity.dart';
import 'package:domain/domain.dart';

/// A restart for a counter.
///
/// Each time a counter is restarted then a CounterRestart should be generated
/// and stored locally.
class CounterRestartEntity extends Entity<CounterRestart> {
  /// Creates Entity from model
  CounterRestartEntity.fromModel(super.model)
      : uuid = model.id,
        counterId = model.counter.id,
        startedAt = model.startedAt?.toIso8601String() ?? '',
        restartedAt = model.restartedAt?.toIso8601String() ?? '',
        super.fromModel();

  /// Creates entity from database map.
  CounterRestartEntity.fromDatabase(super.parsedJson)
      : uuid = parsedJson[kId] as String,
        counterId = parsedJson[kCounterId] as String,
        startedAt = parsedJson[kStartedAt] as String,
        restartedAt = parsedJson[kRestartedAt] as String,
        super.fromDatabase();

  /// Unique identifier for the restart.
  final String uuid;

  /// Counter ID tied to the restart.
  final String counterId;

  /// ISO String for a date at which the counter was started. This helps
  /// to determine streaks.
  final String startedAt;

  /// ISO String for the date at which the counter was restarted.
  final String restartedAt;

  @override
  CounterRestart toModel() => CounterRestart(
        id: uuid,
        counter: TimeCounter.empty.copyWith(
          id: counterId,
        ),
        startedAt: DateTime.parse(startedAt),
        restartedAt: DateTime.parse(restartedAt),
      );

  @override
  Map<String, dynamic> toDatabaseMap() => <String, dynamic>{
        kId: uuid,
        kCounterId: counterId,
        kStartedAt: startedAt,
        kRestartedAt: restartedAt,
      };

  @override
  String get primaryKey => uuid;

  /// Tablename that represents the entities.
  static String get tablename => 'counter_restarts';

  /// Column name for [uuid]
  static const String kId = 'id';

  /// Column name for [counterId]
  static const String kCounterId = 'counter_id';

  /// Column name for [startedAt]
  static const String kStartedAt = 'started_at';

  /// Column name for [restartedAt]
  static const String kRestartedAt = 'restarted_at';
}
