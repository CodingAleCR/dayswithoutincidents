import 'package:data/local/database/support/entity.dart';
import 'package:domain/domain.dart';

class CounterRestartEntity extends Entity<CounterRestart> {
  final String uuid;
  final String counterId;
  final String startedAt;
  final String restartedAt;

  CounterRestartEntity.fromModel(CounterRestart model)
      : uuid = model.id,
        counterId = model.counter.id,
        startedAt = model.startedAt.toIso8601String(),
        restartedAt = model.restartedAt.toIso8601String(),
        super.fromModel(model);

  CounterRestartEntity.fromDatabase(Map<String, dynamic> parsedJson)
      : uuid = parsedJson[ID],
        counterId = parsedJson[COUNTER_ID],
        startedAt = parsedJson[STARTED_AT],
        restartedAt = parsedJson[RESTARTED_AT],
        super.fromDatabase(parsedJson);

  @override
  CounterRestart toModel() {
    return CounterRestart(
      id: uuid,
      counter: TimeCounter.empty.copyWith(
        id: counterId,
      ),
      startedAt: DateTime.parse(startedAt),
      restartedAt: DateTime.parse(restartedAt),
    );
  }

  @override
  Map<String, dynamic> toDatabaseMap() {
    return {
      ID: uuid,
      COUNTER_ID: counterId,
      STARTED_AT: startedAt,
      RESTARTED_AT: restartedAt,
    };
  }

  @override
  String primaryKey() => uuid;

  static String get tablename => "counter_restarts";

  static const String ID = "id";
  static const String COUNTER_ID = "counter_id";
  static const String STARTED_AT = "started_at";
  static const String RESTARTED_AT = "restarted_at";
}
