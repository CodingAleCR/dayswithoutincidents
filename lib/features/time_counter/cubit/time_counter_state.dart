part of 'time_counter_cubit.dart';

class TimeCounterState extends Equatable {
  TimeCounterState({
    this.status = OperationStatus.loading,
    this.message = '',
    TimeCounter? counter,
  }) : counter = counter ?? TimeCounter.empty;

  final OperationStatus status;
  final TimeCounter counter;
  final String message;

  @override
  List<Object> get props => [
        status,
        counter,
        message,
      ];

  /// Provides a cloned instance.
  TimeCounterState copyWith({
    OperationStatus? status,
    TimeCounter? counter,
    String? message,
  }) {
    return TimeCounterState(
      status: status ?? this.status,
      counter: counter ?? this.counter,
      message: message ?? this.message,
    );
  }
}
