import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:dwi/features/theme_chooser/cubit/theme_chooser_cubit.dart';
import 'package:equatable/equatable.dart';

part 'counter_list_state.dart';

/// CounterListCubit
class CounterListCubit extends Cubit<CounterListState> {
  /// Handles logic around the time counters list.
  CounterListCubit(
    this._themeChooserCubit,
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

  final ThemeChooserCubit _themeChooserCubit;
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

  /// Adds a new counter to the list and updates the list in state. After adding
  /// the item it should select the new counter and display it.
  ///
  /// The logic is to get the future item count and
  /// select the last item to display it.
  ///
  /// ```dart
  /// final itemCount = state.counters.length + 1;
  /// final selectedIdx = itemCount - 1;
  /// ```
  ///
  /// This is the same as doing the following:
  ///
  /// ```dart
  /// final selectedIdx = state.counters.length;
  /// ```
  ///
  /// Since `state.counters.length` is equal to
  /// `itemCount - 1`.
  Future<void> addNewCounter() async {
    try {
      await _service.save(
        TimeCounter.generated(
          title: kDefaultCounterTitle,
          theme: _themeChooserCubit.state.theme,
        ),
      );

      await fetchCounters(selectedIdx: state.counters.length);
    } on Exception {
      emit(state.copyWith(status: OperationStatus.failure));
    }
  }

  /// Deletes the current selected counter and updates the selected index and
  /// counter list.
  ///
  /// After deleting the counter then, if available, the previous item
  /// should be selected, otherwise the item next to it should be selected,
  /// which in this case has an index (in the future counter list) equal
  /// to the current `selectedIdx`.
  ///
  Future<void> deleteCurrentCounter() async {
    try {
      await _service.deleteById(state.selected.id);

      final itemCount = state.counters.length - 1;
      final previousIdx = state.selectedIdx - 1;

      final selectedIdx =
          itemCount > 0 && previousIdx < 0 ? state.selectedIdx : previousIdx;
      await fetchCounters(selectedIdx: selectedIdx);
    } on Exception {
      emit(state.copyWith(status: OperationStatus.failure));
    }
  }
}
