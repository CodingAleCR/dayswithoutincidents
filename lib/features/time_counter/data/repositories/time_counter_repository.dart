import 'package:dwi/features/time_counter/domain/domain.dart';

import '../datasources/local/time_counter_preference_provider.dart';

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
