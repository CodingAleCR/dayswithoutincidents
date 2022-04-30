import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'counter_list_state.dart';

/// CounterListCubit
class CounterListCubit extends Cubit<CounterListState> {
  /// Handles logic around the time counters list.
  CounterListCubit(
    this._service,
  ) : super(const CounterListState());

  final TimeCounterService _service;

  /// Fetches all the counters from storage, and updates the selected time
  /// counter.
  Future<void> fetchCounters({int selectedIdx = 0}) async {
    var allCounters = await _service.findAll();

    if (allCounters.isEmpty) {
      final defaultTimeCounter = await _service.save(TimeCounter.empty);
      allCounters = [defaultTimeCounter];
    }

    await Future.delayed(const Duration(milliseconds: 150), () {
      emit(
        state.copyWith(
          status: OperationStatus.idle,
          counters: allCounters,
          selectedIdx: selectedIdx,
        ),
      );
    });
  }

  /// Responds to user interactions that trigger a change in the current
  /// selected counter.
  Future<void> selectedCounterChanged(int selectedIdx) async {
    await fetchCounters(selectedIdx: selectedIdx);
  }

  /// Adds a new counter to the list and updates the list in state.
  Future<void> addNewCounter() async {
    try {
      await _service.save(TimeCounter.empty);

      await fetchCounters(selectedIdx: state.counters.length);
    } on Exception {
      emit(state.copyWith(status: OperationStatus.failure));
    }
  }

  /// Deletes the current selected counter and updates the selected index and
  /// counter list.
  Future<void> deleteCurrentCounter() async {
    try {
      final nextIdx = state.selectedIdx - 1 == -1 ? 0 : state.selectedIdx - 1;
      await _service.deleteById(state.selected.id);

      await fetchCounters(selectedIdx: nextIdx);
    } on Exception {
      emit(state.copyWith(status: OperationStatus.failure));
    }
  }
}
