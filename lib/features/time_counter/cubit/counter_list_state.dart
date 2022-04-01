part of 'counter_list_cubit.dart';

class CounterListState extends Equatable {
  CounterListState({
    this.status = OperationStatus.loading,
    this.counters = const [],
    this.selectedIdx = 0,
  });

  final OperationStatus status;
  final List<TimeCounter> counters;
  final int selectedIdx;
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
