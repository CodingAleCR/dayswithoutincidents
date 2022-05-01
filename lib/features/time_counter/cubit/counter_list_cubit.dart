import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'counter_list_state.dart';

/// CounterListCubit
class CounterListCubit extends Cubit<CounterListState> {
  /// Handles logic around the time counters list.
  CounterListCubit(
    this._service,
  ) : super(const CounterListState()) {
    _suscription = _service.allCounters.listen(
      (counters) => emit(
        state.copyWith(
          counters: counters,
        ),
      ),
    );
  }

  final TimeCounterService _service;

  late StreamSubscription<List<TimeCounter>> _suscription;

  @override
  Future<void> close() async {
    await _suscription.cancel();
    await super.close();
  }

  /// Fetches all the counters from storage, and updates the selected time
  /// counter.
  Future<void> fetchCounters({int selectedIdx = 0}) async {
    try {
      emit(
        state.copyWith(
          status: OperationStatus.loading,
        ),
      );
      final allCounters = await _service.findAll();

      emit(
        state.copyWith(
          status: OperationStatus.success,
          counters: allCounters,
          selectedIdx: selectedIdx,
        ),
      );
    } on Exception catch (e, s) {
      emit(state.copyWith(status: OperationStatus.failure));

      log(e.toString());
      log(s.toString());
    }
  }

  /// Responds to user interactions that trigger a change in the current
  /// selected counter.
  Future<void> selectedCounterChanged(int selectedIdx) async {
    emit(
      state.copyWith(
        selectedIdx: selectedIdx,
      ),
    );
  }

  /// Adds a new counter to the list and updates the list in state.
  Future<void> addNewCounter() async {
    try {
      await _service.save(TimeCounter.generated(title: kDefaultCounterTitle));

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
