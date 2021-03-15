import 'package:data/local/time_counter_preference_provider.dart';
import 'package:domain/domain.dart';

class TimeCounterRepositoryImpl extends TimeCounterRepository {
  TimeCounterSharedPreferenceProvider _counterProvider =
      TimeCounterSharedPreferenceProvider();

  @override
  Future<TimeCounter> getTimeCounter() async {
    return await _counterProvider.getCounter();
  }

  @override
  Future<void> resetTimeCounter() async {
    await _counterProvider.resetCounter();
  }

  @override
  Future<void> setTimeCounter(TimeCounter counter) async {
    await _counterProvider.setCounter(counter);
  }
}
