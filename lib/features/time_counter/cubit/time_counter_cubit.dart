import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uuid/uuid.dart';

part 'time_counter_state.dart';

class TimeCounterCubit extends Cubit<TimeCounterState> {
  TimeCounterCubit(this._service) : super(TimeCounterState()) {
    _service.findAll().then(
      (allCounters) {
        late TimeCounter current;
        if (allCounters.isEmpty) {
          current = TimeCounter.empty;
        } else {
          current = allCounters.first;
        }

        emit(
          state.copyWith(
            status: OperationStatus.idle,
            counter: current,
          ),
        );
      },
    );
  }

  TimeCounterService _service;

  Future<void> titleChanged(String newTitle) async {
    try {
      emit(state.copyWith(status: OperationStatus.loading));

      // Validate new date.
      if (newTitle.isEmpty) {
        emit(
          state.copyWith(
            status: OperationStatus.failure,
            message: "Title can't be empty.",
          ),
        );

        return;
      }

      // Update date of the counter.
      final counter = state.counter.copyWith(title: newTitle);
      final current = await _service.save(counter);

      // Emit success
      emit(state.copyWith(
        counter: current,
        status: OperationStatus.success,
        message: "Your incident counter was updated.",
      ));
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(
        state.copyWith(
          status: OperationStatus.failure,
          message: "There was a problem updating  the counter.",
        ),
      );
    } finally {
      emit(
        state.copyWith(
          status: OperationStatus.idle,
          message: "",
        ),
      );
    }
  }

  Future<void> dateChanged(DateTime newDate) async {
    try {
      emit(state.copyWith(status: OperationStatus.loading));

      // Validate new date.
      DateTime today = DateTime.now();
      if (!newDate.isBefore(today)) {
        emit(
          state.copyWith(
            status: OperationStatus.failure,
            message: "Please select a date that is before today.",
          ),
        );

        return;
      }

      // Update date of the counter.
      final counter = state.counter.copyWith(createdAt: newDate);
      final current = await _service.save(counter);

      // Emit success
      emit(state.copyWith(
        counter: current,
        status: OperationStatus.success,
        message: "Your incident counter was updated.",
      ));
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(
        state.copyWith(
          status: OperationStatus.failure,
          message: "There was a problem updating  the counter.",
        ),
      );
    } finally {
      emit(
        state.copyWith(
          status: OperationStatus.idle,
          message: "",
        ),
      );
    }
  }

  Future<void> resetCounter() async {
    try {
      emit(state.copyWith(status: OperationStatus.loading));

      // Delete previous counter.
      await _service.deleteById(UuidValue(state.counter.id));

      // Store new counter.
      final newCounter = TimeCounter.empty;
      final current = await _service.save(newCounter);

      // Emit success
      emit(state.copyWith(
        counter: current,
        status: OperationStatus.success,
        message: "Your incident counter was reset.",
      ));
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      emit(
        state.copyWith(
          status: OperationStatus.failure,
          message: "There was a problem getting the counter.",
        ),
      );
    } finally {
      emit(
        state.copyWith(
          status: OperationStatus.idle,
          message: "",
        ),
      );
    }
  }
}
