import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
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
    final counter = await _service.findById(state.counter.id);
    final restarts = await _restartsService.findAllByCounter(counter);

    emit(
      state.copyWith(
        status: OperationStatus.idle,
        counter: counter,
        restarts: restarts,
      ),
    );
  }

  /// Updates the title of a counter
  Future<void> titleChanged(String newTitle) async {
    try {
      emit(state.copyWith(status: OperationStatus.loading));

      // Validate new date.
      if (newTitle.isEmpty) {
        emit(
          state.copyWith(
            status: OperationStatus.failure,
          ),
        );

        return;
      }

      // Update date of the counter.
      final counter = state.counter.copyWith(title: newTitle);
      final current = await _service.save(counter);

      // Emit success
      emit(
        state.copyWith(
          counter: current,
          status: OperationStatus.success,
        ),
      );
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(
        state.copyWith(
          status: OperationStatus.failure,
        ),
      );
    } finally {
      emit(
        state.copyWith(
          status: OperationStatus.idle,
        ),
      );
    }
  }

  /// Updates the date of a counter
  Future<void> dateChanged(DateTime newDate) async {
    try {
      emit(state.copyWith(status: OperationStatus.loading));

      // Validate new date.
      final today = DateTime.now();
      if (!newDate.isBefore(today)) {
        emit(
          state.copyWith(
            status: OperationStatus.failure,
          ),
        );

        return;
      }

      // Update date of the counter.
      final counter = state.counter.copyWith(createdAt: newDate);
      final current = await _service.save(counter);

      // Emit success
      emit(
        state.copyWith(
          counter: current,
          status: OperationStatus.success,
        ),
      );
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(
        state.copyWith(
          status: OperationStatus.failure,
        ),
      );
    } finally {
      emit(
        state.copyWith(
          status: OperationStatus.idle,
        ),
      );
    }
  }

  /// Updates the theme of a counter.
  Future<void> themeChanged(AppTheme theme) async {
    try {
      final updatedCounter = state.counter.copyWith(theme: theme);

      await _service.save(updatedCounter);

      await fetchCounter();
    } on Exception catch (err, stacktrace) {
      await Sentry.captureException(
        err,
        stackTrace: stacktrace,
      );
    }
  }

  /// Creates a new restart for the counter.
  Future<void> restartCounter() async {
    try {
      emit(state.copyWith(status: OperationStatus.loading));

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
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(
        state.copyWith(
          status: OperationStatus.failure,
        ),
      );
    } finally {
      emit(
        state.copyWith(
          status: OperationStatus.idle,
        ),
      );
    }
  }
}
