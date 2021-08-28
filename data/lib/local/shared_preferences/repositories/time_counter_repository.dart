import 'package:data/local/shared_preferences/providers/time_counter_preference_provider.dart';
import 'package:domain/domain.dart';

class TimeCounterRepositoryImpl {
  TimeCounterSharedPreferenceProvider _counterProvider =
      TimeCounterSharedPreferenceProvider();

  TimeCounterRepositoryImpl({
    TimeCounterSharedPreferenceProvider? counterProvider,
  }) : _counterProvider =
            counterProvider ?? TimeCounterSharedPreferenceProvider();

  Future<TimeCounter> getTimeCounter() async {
    return await _counterProvider.getCounter();
  }

  Future<void> resetTimeCounter() async {
    await _counterProvider.resetCounter();
  }

  Future<void> setTimeCounter(TimeCounter counter) async {
    await _counterProvider.setCounter(counter);
  }
}
