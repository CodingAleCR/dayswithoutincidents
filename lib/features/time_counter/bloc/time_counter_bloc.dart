import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';

import './bloc.dart';

class TimeCounterBloc extends Bloc<TimeCounterEvent, TimeCounterState> {
  final TimeCounterRepository repository;

  TimeCounterBloc({required this.repository}) : super(TimeCounterInitial());

  @override
  Stream<TimeCounterState> mapEventToState(
    TimeCounterEvent event,
  ) async* {
    if (event is GetTimeCounter) {
      yield* _mapGetTimeCounterToState(event);
    } else if (event is UpdateTimeCounter) {
      yield* _mapUpdateTimeCounterToState(event);
    } else if (event is ResetTimeCounter) {
      yield* _mapResetTimeCounterToState(event);
    }
  }

  Stream<TimeCounterState> _mapGetTimeCounterToState(
      GetTimeCounter event) async* {
    try {
      yield TimeCounterLoading();
      TimeCounter current = await repository.getTimeCounter();
      yield TimeCounterLoaded(counter: current);
    } catch (error) {
      yield TimeCounterError(
        message: "There was a problem getting the counter.",
      );
    }
  }

  Stream<TimeCounterState> _mapUpdateTimeCounterToState(
      UpdateTimeCounter event) async* {
    try {
      yield TimeCounterLoading();
      DateTime today = DateTime.now();
      if (event.counter.incident!.isBefore(today)) {
        await repository.setTimeCounter(event.counter);
      } else {
        yield TimeCounterError(
          message: "Please select a date that is before today.",
        );
      }

      TimeCounter current = await repository.getTimeCounter();
      yield TimeCounterLoaded(counter: current);
    } catch (error) {
      yield TimeCounterError(
        message: "There was a problem getting the counter.",
      );
    }
  }

  Stream<TimeCounterState> _mapResetTimeCounterToState(
      ResetTimeCounter event) async* {
    try {
      yield TimeCounterLoading();
      await repository.resetTimeCounter();
      TimeCounter current = await repository.getTimeCounter();
      yield TimeCounterLoaded(counter: current);
    } catch (error) {
      yield TimeCounterError(
        message: "There was a problem getting the counter.",
      );
    }
  }
}
