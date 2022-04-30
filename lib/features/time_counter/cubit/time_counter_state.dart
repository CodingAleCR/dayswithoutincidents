part of 'time_counter_cubit.dart';

/// TimeCounterState
class TimeCounterState extends Equatable {
  /// Holds the information about the time counter.
  const TimeCounterState({
    this.status = OperationStatus.loading,
    this.restarts = const [],
    TimeCounter? counter,
  }) : counter = counter ?? TimeCounter.empty;

  /// I/O action status
  final OperationStatus status;

  /// List of restarts tied to [counter]
  final List<CounterRestart> restarts;

  /// Counter to be displayed
  final TimeCounter counter;

  /// Longest streak of [counter].
  ///
  /// It is inferred from [restarts]
  int? get longestStreak {
    final streaks = restarts
        .map(
          (counterRestart) => counterRestart.restartedAt!
              .difference(counterRestart.startedAt!)
              .inDays,
        )
        .toList();

    final currentStreak = DateTime.now().difference(counter.createdAt!).inDays;
    if (streaks.isEmpty) return currentStreak;

    final longestRestartStreak = streaks.reduce(
      (aStreak, anotherStreak) =>
          aStreak > anotherStreak ? aStreak : anotherStreak,
    );

    return longestRestartStreak > currentStreak
        ? longestRestartStreak
        : currentStreak;
  }

  /// Determines if the current streak is the longest streak alive.
  bool get isLongestStreakAlive {
    final currentStreak = DateTime.now().difference(counter.createdAt!).inDays;

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
