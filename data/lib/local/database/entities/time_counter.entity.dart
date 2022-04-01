import 'package:data/local/database/support/entity.dart';
import 'package:domain/domain.dart';

class TimeCounterEntity extends Entity<TimeCounter> {
  final String uuid;
  final String title;
  final String createdAt;

  TimeCounterEntity.fromModel(TimeCounter model)
      : uuid = model.id,
        title = model.title,
        createdAt = model.createdAt.toIso8601String(),
        super.fromModel(model);

  TimeCounterEntity.fromDatabase(Map<String, dynamic> parsedJson)
      : uuid = parsedJson[ID],
        title = parsedJson[TITLE],
        createdAt = parsedJson[CREATED_AT],
        super.fromDatabase(parsedJson);

  @override
  TimeCounter toModel() {
    return TimeCounter(
      id: uuid,
      title: title,
      createdAt: DateTime.parse(createdAt),
    );
  }

  @override
  Map<String, dynamic> toDatabaseMap() {
    return {
      ID: uuid,
      TITLE: title,
      CREATED_AT: createdAt,
    };
  }

  @override
  String primaryKey() => uuid;

  static String get tablename => "time_counters";

  static const String ID = "id";
  static const String TITLE = "title";
  static const String CREATED_AT = "created_at";
  static const String THEME = "theme";
}
