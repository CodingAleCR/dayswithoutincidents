import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

abstract class TimeCounterEvent extends Equatable {
  const TimeCounterEvent();
}

class ResetTimeCounter extends TimeCounterEvent {
  const ResetTimeCounter();

  @override
  List<Object> get props => [];
}

class GetTimeCounter extends TimeCounterEvent {
  const GetTimeCounter();

  @override
  List<Object> get props => [];
}

class UpdateTimeCounter extends TimeCounterEvent {
  final TimeCounter counter;

  const UpdateTimeCounter({required this.counter});

  @override
  List<Object> get props => [counter];
}
