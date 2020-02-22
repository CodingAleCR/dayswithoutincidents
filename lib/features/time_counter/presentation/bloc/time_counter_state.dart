import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/models/time_counter.dart';

abstract class TimeCounterState extends Equatable {
  const TimeCounterState();
}

class TimeCounterInitial extends TimeCounterState {
  const TimeCounterInitial();
  @override
  List<Object> get props => [];
}

class TimeCounterLoading extends TimeCounterState {
  const TimeCounterLoading();
  @override
  List<Object> get props => [];
}

class TimeCounterLoaded extends TimeCounterState {
  final TimeCounter counter;
  const TimeCounterLoaded({@required this.counter});
  @override
  List<Object> get props => [counter];
}

class TimeCounterError extends TimeCounterState {
  final String message;
  const TimeCounterError({@required this.message});
  @override
  List<Object> get props => [message];
}
