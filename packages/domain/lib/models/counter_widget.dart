import 'package:domain/models/time_counter.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

/// A restart holds information about when a time counter was reset and about
/// the streak that it had.
class CounterWidget extends Equatable {
  /// Constructor
  const CounterWidget({
    required this.id,
    required this.counter,
    required this.widgetId,
  });

  /// Constructor
  CounterWidget.generated({
    required this.widgetId,
    TimeCounter? counter,
  })  : id = const Uuid().v4(),
        counter = counter ?? TimeCounter.empty;

  /// Unique identifier for the restart.
  final String id;

  /// Time counter tied to this restart.
  final TimeCounter counter;

  /// ID tied to the widget.
  final String widgetId;

  /// Empty representation of a restart.
  static const CounterWidget empty = CounterWidget(
    id: '',
    counter: TimeCounter.empty,
    widgetId: '',
  );

  @override
  List<Object?> get props => [
        id,
        counter,
        widgetId,
      ];

  /// Provides a copied instance.
  CounterWidget copyWith({
    String? id,
    TimeCounter? counter,
    String? widgetId,
  }) {
    return CounterWidget(
      id: id ?? this.id,
      counter: counter ?? this.counter,
      widgetId: widgetId ?? this.widgetId,
    );
  }
}
