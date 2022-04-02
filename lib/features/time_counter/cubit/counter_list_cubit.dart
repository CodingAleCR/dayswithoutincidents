import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'counter_list_state.dart';

class CounterListCubit extends Cubit<CounterListState> {
  CounterListCubit(
    this._service,
  ) : super(CounterListState()) {
    fetchCounters();
  }

  TimeCounterService _service;

  Future<void> fetchCounters({int selectedIdx = 0}) async {
    var allCounters = await _service.findAll();

    if (allCounters.isEmpty) {
      final defaultTimeCounter = await _service.save(TimeCounter.empty);
      allCounters = [defaultTimeCounter];
    }

    emit(
      state.copyWith(
        status: OperationStatus.idle,
        counters: allCounters,
        selectedIdx: selectedIdx,
      ),
    );
  }

  Future<void> selectedCounterChanged(int selectedIdx) async {
    await fetchCounters(selectedIdx: selectedIdx);
  }

  Future<void> addNewCounter() async {
    try {
      await _service.save(TimeCounter.empty);

      await fetchCounters(selectedIdx: state.counters.length);
    } on Exception {
      emit(state.copyWith(status: OperationStatus.failure));
    }
  }

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
