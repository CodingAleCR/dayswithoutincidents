import 'package:dwi/datasource/day_counter/day_counter_repository.dart';
import 'package:dwi/domain/models/day_counter.dart';
import 'package:rxdart/rxdart.dart';

class Bloc {
  DayCounterRepository _repository = DayCounterRepository();

  BehaviorSubject<DayCounter> _counter = BehaviorSubject<DayCounter>();
  Observable<DayCounter> get counter => _counter.stream;

  Future<Bloc> init() async {
    await _repository.init();

    return this;
  }

  Future<void> fetchCounter() async {
    DayCounter counter = await _repository.getDayCounter();
    if (counter == null) {
      _counter.add(DayCounter.EMPTY_COUNTER);
    } else {
      _counter.add(counter);
    }
  }

  void setTitle(String title) {
    DayCounter counter = _counter.value;
    if (counter != null) {
      counter = DayCounter(title, counter.incident);
    } else {
      counter = DayCounter(title, DayCounter.EMPTY_COUNTER.incident);
    }
    _repository.setDayCounter(counter);
    _counter.add(counter);
  }

  void setIncident(DateTime incident) {
    DayCounter counter = _counter.value;
    if (counter != null) {
      counter = DayCounter(counter.title, incident);
    } else {
      counter = DayCounter(DayCounter.EMPTY_COUNTER.title, incident);
    }
    _repository.setDayCounter(counter);
    _counter.add(counter);
  }

  void resetCounter() async {
    await _repository.resetCounter();
    await fetchCounter();
  }

  void dispose() {
    _repository.dispose();
    _counter.close();
  }
}
