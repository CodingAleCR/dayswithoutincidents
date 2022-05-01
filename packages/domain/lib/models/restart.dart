import 'package:domain/models/time_counter.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

/// A restart holds information about when a time counter was reset and about
/// the streak that it had.
class CounterRestart extends Equatable {
  /// Constructor
  const CounterRestart({
    required this.id,
    required this.counter,
    this.startedAt,
    this.restartedAt,
  });

  /// Constructor
  CounterRestart.generated({
    TimeCounter? counter,
    DateTime? startedAt,
    DateTime? restartedAt,
  })  : id = const Uuid().v4(),
        counter = counter ?? TimeCounter.empty,
        startedAt = startedAt ?? DateTime.now(),
        restartedAt = restartedAt ?? DateTime.now();

  /// Unique identifier for the restart.
  final String id;

  /// Time counter tied to this restart.
  final TimeCounter counter;

  /// Date at which the counter was started. This helps
  /// to determine streaks.
  final DateTime? startedAt;

  /// Date at which the counter was restarted.
  final DateTime? restartedAt;

  /// Amount of days passed from [startedAt] and [restartedAt]
  int get streak => restartedAt != null && startedAt != null
      ? restartedAt!.difference(startedAt!).inDays
      : 0;

  /// Empty representation of a restart.
  static const CounterRestart empty = CounterRestart(
    id: '',
    counter: TimeCounter.empty,
  );

  @override
  List<Object?> get props => [
        id,
        counter,
        startedAt,
        restartedAt,
      ];

  /// Provides a copied instance of a restart.
  CounterRestart copyWith({
    TimeCounter? counter,
    DateTime? startedAt,
    DateTime? restartedAt,
  }) {
    return CounterRestart(
      id: id,
      counter: counter ?? this.counter,
      startedAt: startedAt ?? this.startedAt,
      restartedAt: restartedAt ?? this.restartedAt,
    );
  }
}
