part of 'time_counter_cubit.dart';

class TimeCounterState extends Equatable {
  TimeCounterState({
    this.status = OperationStatus.loading,
    this.restarts = const [],
    TimeCounter? counter,
  }) : counter = counter ?? TimeCounter.empty;

  final OperationStatus status;
  final List<CounterRestart> restarts;
  final TimeCounter counter;

  int? get longestStreak {
    final streaks = restarts
        .map((counterRestart) => counterRestart.restartedAt
            .difference(counterRestart.startedAt)
            .inDays)
        .toList();

    final currentStreak = DateTime.now().difference(counter.createdAt).inDays;
    if (streaks.isEmpty) return currentStreak;

    final longestRestartStreak = streaks.reduce((aStreak, anotherStreak) =>
        aStreak > anotherStreak ? aStreak : anotherStreak);

    return longestRestartStreak > currentStreak
        ? longestRestartStreak
        : currentStreak;
  }

  bool get isLongestStreakAlive {
    final currentStreak = DateTime.now().difference(counter.createdAt).inDays;

    return longestStreak == currentStreak;
  }

  @override
  List<Object> get props => [
        status,
        counter,
        restarts,
      ];

  /// Provides a cloned instance.
  TimeCounterState copyWith({
    OperationStatus? status,
    List<CounterRestart>? restarts,
    TimeCounter? counter,
  }) {
    return TimeCounterState(
      status: status ?? this.status,
      restarts: restarts ?? this.restarts,
      counter: counter ?? this.counter,
    );
  }
}
