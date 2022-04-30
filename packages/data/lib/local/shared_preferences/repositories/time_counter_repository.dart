import 'package:data/local/shared_preferences/providers/time_counter_preference_provider.dart';
import 'package:domain/domain.dart';

/// Implementation of a time counter repository from shared preferences.
class TimeCounterRepositoryImpl {
  /// Constructor
  TimeCounterRepositoryImpl({
    TimeCounterSharedPreferenceProvider? counterProvider,
  }) : _counterProvider =
            counterProvider ?? TimeCounterSharedPreferenceProvider();

  final TimeCounterSharedPreferenceProvider _counterProvider;

  /// Gets the single time counter stored.
  Future<TimeCounter> getTimeCounter() => _counterProvider.getCounter();

  /// Resets single time counter.
  Future<void> resetTimeCounter() async {
    await _counterProvider.resetCounter();
  }

  /// Updates the single time counter stored.
  Future<void> setTimeCounter(TimeCounter counter) async {
    await _counterProvider.setCounter(counter);
  }
}
