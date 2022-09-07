part of 'restarts_cubit.dart';

/// State of [RestartsCubit]
class RestartsState extends Equatable {
  /// Holds information about streaks for [counter]
  const RestartsState({
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

  @override
  List<Object> get props => [
        counter,
        restarts,
      ];

  /// Provides a cloned instance.
  RestartsState copyWith({
    OperationStatus? status,
    TimeCounter? counter,
    List<CounterRestart>? restarts,
  }) {
    return RestartsState(
      status: status ?? this.status,
      counter: counter ?? this.counter,
      restarts: restarts ?? this.restarts,
    );
  }
}
