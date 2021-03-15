import '../models/time_counter.dart';

abstract class TimeCounterRepository {
  Future<TimeCounter> getTimeCounter();
  Future<void> setTimeCounter(TimeCounter counter);
  Future<void> resetTimeCounter();
}
