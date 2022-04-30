import 'package:domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Key for the title in shared prefs.
const String kTitle = 'title';

/// Key for the date in shared prefs.
const String kLastIncident = 'last_incident';

/// [deprecated]
///
/// Time counter provides information of a single counter from shared
/// preferences
class TimeCounterSharedPreferenceProvider {
  /// Get current stored time counter.
  Future<TimeCounter> getCounter() async {
    final _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey(kTitle) && _prefs.containsKey(kLastIncident)) {
      final title = _prefs.getString(kTitle)!;
      final lastIncidentString = _prefs.getString(kLastIncident)!;
      final lastIncident = DateTime.parse(lastIncidentString);

      return TimeCounter(
        title: title,
        createdAt: lastIncident,
      );
    } else {
      const counter = TimeCounter.empty;
      await setCounter(counter);
      return counter;
    }
  }

  /// Stores counter in local key-value storage.
  Future<void> setCounter(TimeCounter counter) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(kTitle, counter.title);
    await _prefs.setString(kLastIncident, counter.createdAt!.toIso8601String());
  }

  /// Resets the counter time to now.
  Future<void> resetCounter() async {
    final _prefs = await SharedPreferences.getInstance();
    final now = DateTime.now().toIso8601String();
    await _prefs.setString(kLastIncident, now);
  }

  /// Deletes all counter information from key-value storage.
  Future<void> clear() async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.remove(kTitle);
    await _prefs.remove(kLastIncident);
  }
}
