import 'package:dwi/domain/models/day_counter.dart';

abstract class DayCounterProvider {
  Future<void> init();
  void setCounter(DayCounter counter);
  DayCounter getCounter();
  void resetCounter();
  void dispose();
}
