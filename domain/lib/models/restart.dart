import 'package:domain/models/time_counter.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class CounterRestart extends Equatable {
  final String id;
  final TimeCounter counter;
  final DateTime startedAt;
  final DateTime restartedAt;

  CounterRestart.generated({
    TimeCounter? counter,
    DateTime? startedAt,
    DateTime? restartedAt,
  })  : id = Uuid().v4(),
        counter = counter ?? TimeCounter.empty,
        startedAt = startedAt ?? DateTime.now(),
        restartedAt = restartedAt ?? DateTime.now();

  CounterRestart({
    required this.id,
    required this.counter,
    required this.startedAt,
    required this.restartedAt,
  });

  static CounterRestart get empty => CounterRestart(
        id: Uuid().v4(),
        counter: TimeCounter.empty,
        startedAt: DateTime.now(),
        restartedAt: DateTime.now(),
      );

  @override
  List<Object?> get props => [
        id,
        counter,
        startedAt,
        restartedAt,
      ];

  CounterRestart copyWith({
    TimeCounter? counter,
    DateTime? startedAt,
    DateTime? restartedAt,
  }) {
    return CounterRestart(
      id: this.id,
      counter: counter ?? this.counter,
      startedAt: startedAt ?? this.startedAt,
      restartedAt: restartedAt ?? this.restartedAt,
    );
  }
}
