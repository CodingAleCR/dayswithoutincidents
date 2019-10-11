import 'package:dwi/datasource/day_counter/day_counter_preference_provider.dart';
import 'package:dwi/datasource/day_counter/day_counter_provider.dart';
import 'package:dwi/domain/models/day_counter.dart';

class DayCounterRepository {
  DayCounterProvider _counterProvider = DayCounterSharedPreferenceProvider();

  Future<void> init() async {
    await _counterProvider.init();
  }

  Future<DayCounter> getDayCounter() async {
    return _counterProvider.getCounter();
  }

  Future<void> setDayCounter(DayCounter counter) async {
    _counterProvider.setCounter(counter);
  }

  Future<void> resetCounter() async {
    _counterProvider.resetCounter();
  }

  void dispose() {
    _counterProvider.dispose();
  }
}
