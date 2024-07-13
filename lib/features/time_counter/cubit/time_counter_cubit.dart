import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'time_counter_state.dart';

/// TimeCounterCubit
class TimeCounterCubit extends Cubit<TimeCounterState> {
  /// Handles logic for a time counter.
  ///
  /// Resets or fetches information about it.
  TimeCounterCubit(
    TimeCounter counter,
    this._service,
    this._restartsService,
  ) : super(TimeCounterState(counter: counter));

  final TimeCounterService _service;
  final CounterRestartService _restartsService;

  /// Fetches information about the counter
  Future<void> fetchCounter() async {
    try {
      final counter = await _service.findById(state.counter.id);
      final restarts = await _restartsService.findAllByCounter(counter);

      emit(
        state.copyWith(
          status: OperationStatus.idle,
          counter: counter,
          restarts: restarts,
        ),
      );
    } catch (exception, stacktrace) {
      await Sentry.captureException(exception, stackTrace: stacktrace);
    }
  }

  /// Saves the information about the counter
  Future<void> saveCounter() async {
    try {
      emit(state.copyWith(status: OperationStatus.loading));
      await _service.save(state.counter);
      emit(state.copyWith(status: OperationStatus.success));
    } catch (exception, stacktrace) {
      await Sentry.captureException(exception, stackTrace: stacktrace);
    } finally {
      await fetchCounter();
    }
  }

  /// Updates the information of a counter
  void counterChanged(String title, DateTime lastRestart) {
    emit(
      state.copyWith(
        counter: state.counter.copyWith(
          title: title,
          createdAt: lastRestart,
        ),
      ),
    );

    saveCounter();
  }

  /// Updates the title of a counter
  void titleChanged(String newTitle) {
    emit(
      state.copyWith(
        counter: state.counter.copyWith(title: newTitle),
      ),
    );
  }

  /// Updates the date of a counter
  void dateChanged(DateTime newDate) {
    emit(
      state.copyWith(
        counter: state.counter.copyWith(createdAt: newDate),
      ),
    );

    saveCounter();
  }

  /// Updates the theme of a counter.
  void themeChanged(AppTheme theme) {
    emit(
      state.copyWith(
        counter: state.counter.copyWith(theme: theme),
      ),
    );

    saveCounter();
  }

  /// Creates a new restart for the counter.
  Future<void> restartCounter() async {
    try {
      emit(state.copyWith(restartStatus: OperationStatus.loading));

      final restartDate = DateTime.now();
      final restartItem = CounterRestart.generated(
        counter: state.counter,
        startedAt: state.counter.createdAt,
        restartedAt: DateTime.now(),
      );
      await _restartsService.save(restartItem);

      final updatedCounter = state.counter.copyWith(createdAt: restartDate);
      await _service.save(updatedCounter);
      await fetchCounter();
      emit(
        state.copyWith(
          restartStatus: OperationStatus.success,
        ),
      );
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(
        state.copyWith(
          restartStatus: OperationStatus.failure,
        ),
      );
    } finally {
      await fetchCounter();
    }
  }

  /// Permanently deletes the counter.
  Future<void> deleteCounter() async {
    try {
      emit(state.copyWith(restartStatus: OperationStatus.loading));

      await _service.deleteById(state.counter.id);
      emit(
        state.copyWith(
          restartStatus: OperationStatus.success,
        ),
      );
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(
        state.copyWith(
          restartStatus: OperationStatus.failure,
        ),
      );
    }
  }
}
