part of 'streaks_cubit.dart';

/// State of [StreaksCubit]
class StreaksState extends Equatable {
  /// Holds information about streaks for [counter]
  const StreaksState({
    required this.counter,
    this.status = OperationStatus.idle,
    this.restarts = const [],
  });

  /// Operation status on fetching [restarts].
  final OperationStatus status;

  /// Counter of which all information is based on.
  final TimeCounter counter;

  /// List of restarts of [counter]
  final List<CounterRestart> restarts;

  /// Top ten streaks ordered by streak amount.
  List<CounterRestart> get topTenStreaks {
    final sortedRestarts = [...restarts]..sort(
        (a, b) => b.streakDifference.compareTo(a.streakDifference),
      );

    return sortedRestarts.take(10).toList();
  }

  @override
  List<Object> get props => [
        counter,
        restarts,
      ];

  /// Provides a cloned instance.
  StreaksState copyWith({
    OperationStatus? status,
    TimeCounter? counter,
    List<CounterRestart>? restarts,
  }) {
    return StreaksState(
      status: status ?? this.status,
      counter: counter ?? this.counter,
      restarts: restarts ?? this.restarts,
    );
  }
}
