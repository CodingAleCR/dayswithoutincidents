import 'package:data/local/database/support/entity.dart';
import 'package:domain/domain.dart';

/// A time counter. Counts how many time has passed since it was created.
class TimeCounterEntity extends Entity<TimeCounter> {
  /// Creates Entity from model
  TimeCounterEntity.fromModel(TimeCounter model)
      : uuid = model.id,
        title = model.title,
        createdAt = model.createdAt?.toIso8601String() ?? '',
        theme = model.theme.key(),
        super.fromModel(model);

  /// Creates entity from database map.
  TimeCounterEntity.fromDatabase(Map<String, dynamic> parsedJson)
      : uuid = parsedJson[kId] as String,
        title = parsedJson[kTitle] as String,
        createdAt = parsedJson[kCreatedAt] as String,
        theme = parsedJson[kTheme] as String,
        super.fromDatabase(parsedJson);

  /// Unique identifier for the counter.
  final String uuid;

  /// Title to be displayed for the counter
  final String title;

  /// ISO String for the date at which the counter was created.
  final String createdAt;

  /// Theme used for this counter
  final String theme;

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
    return <String, dynamic>{
      kId: uuid,
      kTitle: title,
      kCreatedAt: createdAt,
      kTheme: theme,
    };
  }

  @override
  String get primaryKey => uuid;

  /// Tablename that represents the entities.
  static String get tablename => 'time_counters';

  /// Column name for [uuid]
  static const String kId = 'id';

  /// Column name for [title]
  static const String kTitle = 'title';

  /// Column name for [createdAt]
  static const String kCreatedAt = 'created_at';

  /// Column name for [theme]
  static const String kTheme = 'theme';
}
