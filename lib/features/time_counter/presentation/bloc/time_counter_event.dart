import 'package:dwi/features/time_counter/domain/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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

  const UpdateTimeCounter({@required this.counter});

  @override
  List<Object> get props => [counter];
}
