import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'streaks_state.dart';

/// Handles logic around streaks of a counter.
class StreaksCubit extends Cubit<StreaksState> {
  /// Handles logic around streaks of a counter.
  StreaksCubit(
    this._restartService, {
    required TimeCounter counter,
  }) : super(
          StreaksState(
            counter: counter,
          ),
        );

  /// Service for interacting with counter restarts.
  final CounterRestartService _restartService;

  /// Fetches all the restarts for the counter in state.
  Future<void> fetchRestarts() async {
    try {
      emit(
        state.copyWith(
          status: OperationStatus.loading,
        ),
      );
      final restarts = await _restartService.findAllByCounter(state.counter);
      emit(
        state.copyWith(
          status: OperationStatus.success,
          restarts: restarts,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: OperationStatus.failure,
        ),
      );
    }
  }
}
