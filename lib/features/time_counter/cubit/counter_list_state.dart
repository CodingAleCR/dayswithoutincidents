part of 'counter_list_cubit.dart';

/// CounterListState
class CounterListState extends Equatable {
  /// Holds the information about a counter list.
  const CounterListState({
    this.status = OperationStatus.loading,
    this.counters = const [],
    this.selectedIdx = -1,
    this.preferredMode = DisplayModes.carousel,
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

  /// Preferred display mode for the list of counters.
  final DisplayModes preferredMode;

  @override
  List<Object> get props => [
        status,
        counters,
        selectedIdx,
        preferredMode,
      ];

  /// Provides a cloned instance.
  CounterListState copyWith({
    OperationStatus? status,
    List<TimeCounter>? counters,
    int? selectedIdx,
    DisplayModes? preferredMode,
  }) {
    return CounterListState(
      status: status ?? this.status,
      counters: counters ?? this.counters,
      selectedIdx: selectedIdx ?? this.selectedIdx,
      preferredMode: preferredMode ?? this.preferredMode,
    );
  }
}
