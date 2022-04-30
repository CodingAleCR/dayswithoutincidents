part of 'counter_list_cubit.dart';

/// CounterListState
class CounterListState extends Equatable {
  /// Holds the information about a counter list.
  const CounterListState({
    this.status = OperationStatus.loading,
    this.counters = const [],
    this.selectedIdx = 0,
  });

  /// Status of the operation for fetching counters, adding a counter
  /// or deleting a counter.
  final OperationStatus status;

  /// List of the time counters available.
  final List<TimeCounter> counters;

  /// Index of the counter currently displayed
  final int selectedIdx;

  /// Time counter representation of the [selectedIdx]
  TimeCounter get selected {
    return counters[selectedIdx];
  }

  @override
  List<Object> get props => [
        status,
        counters,
        selectedIdx,
      ];

  /// Provides a cloned instance.
  CounterListState copyWith({
    OperationStatus? status,
    List<TimeCounter>? counters,
    int? selectedIdx,
  }) {
    return CounterListState(
      status: status ?? this.status,
      counters: counters ?? this.counters,
      selectedIdx: selectedIdx ?? this.selectedIdx,
    );
  }
}
