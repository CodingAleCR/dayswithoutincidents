import 'package:data/local/database/support/entity.dart';
import 'package:domain/domain.dart';

class TimeCounterEntity extends Entity<TimeCounter> {
  final String uuid;
  final String title;
  final String createdAt;
  final String? theme;

  TimeCounterEntity.fromModel(TimeCounter model)
      : uuid = model.id,
        title = model.title,
        createdAt = model.createdAt.toIso8601String(),
        theme = model.theme.key(),
        super.fromModel(model);

  TimeCounterEntity.fromDatabase(Map<String, dynamic> parsedJson)
      : uuid = parsedJson[ID],
        title = parsedJson[TITLE],
        createdAt = parsedJson[CREATED_AT],
        theme = parsedJson[THEME],
        super.fromDatabase(parsedJson);

  @override
  TimeCounter toModel() {
    return TimeCounter(
      id: uuid,
      title: title,
      createdAt: DateTime.parse(createdAt),
      theme: AppThemeFromString.fromString(theme),
    );
  }

  @override
  Map<String, dynamic> toDatabaseMap() {
    return {
      ID: uuid,
      TITLE: title,
      CREATED_AT: createdAt,
      THEME: theme,
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
