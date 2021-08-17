import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:uuid/uuid.dart';

import './bloc.dart';

class TimeCounterBloc extends Bloc<TimeCounterEvent, TimeCounterState> {
  final TimeCounterService _service;
  final uuid = Uuid();

  TimeCounterBloc({required TimeCounterService service})
      : _service = service,
        super(TimeCounterInitial());

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
      final allCounters = await _service.findAll();
      late TimeCounter current;
      if (allCounters.isEmpty) {
        current = TimeCounter.empty();
      } else {
        current = allCounters.first;
      }
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
        await _service.save(event.counter);
      } else {
        yield TimeCounterError(
          message: "Please select a date that is before today.",
        );
      }

      TimeCounter current =
          await _service.findById(UuidValue(event.counter.id));
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
      await _service.deleteById(UuidValue(event.uuid));
      TimeCounter current = TimeCounter.empty();
      yield TimeCounterLoaded(counter: current);
    } catch (error) {
      yield TimeCounterError(
        message: "There was a problem getting the counter.",
      );
    }
  }
}
