import 'package:data/local/database/support/entity.dart';
import 'package:domain/domain.dart';

/// A restart for a counter.
///
/// Each time a counter is restarted then a CounterWidget should be generated
/// and stored locally.
class CounterWidgetEntity extends Entity<CounterWidget> {
  /// Creates Entity from model
  CounterWidgetEntity.fromModel(super.model)
      : uuid = model.id,
        counterId = model.counter.id,
        widgetId = '',
        super.fromModel();

  /// Creates entity from database map.
  CounterWidgetEntity.fromDatabase(super.parsedJson)
      : uuid = parsedJson[kId] as String,
        counterId = parsedJson[kCounterId] as String,
        widgetId = parsedJson[kWidgetId] as String,
        super.fromDatabase();

  /// Unique identifier for the restart.
  final String uuid;

  /// Counter ID tied to the widget.
  final String counterId;

  /// ID tied to the widget.
  final String widgetId;

  @override
  CounterWidget toModel() => CounterWidget(
        id: uuid,
        counter: TimeCounter.empty.copyWith(
          id: counterId,
        ),
        widgetId: widgetId,
      );

  @override
  Map<String, dynamic> toDatabaseMap() => <String, dynamic>{
        kId: uuid,
        kCounterId: counterId,
        kWidgetId: widgetId,
      };

  @override
  String get primaryKey => uuid;

  /// Tablename that represents the entities.
  static String get tablename => 'counter_widgets';

  /// Column name for [uuid]
  static const String kId = 'id';

  /// Column name for [counterId]
  static const String kCounterId = 'counter_id';

  /// Column name for [widgetId]
  static const String kWidgetId = 'widget_id';
}
