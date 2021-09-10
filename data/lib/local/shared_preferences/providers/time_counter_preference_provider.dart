import 'package:domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String TITLE = "title";
const String LAST_INCIDENT = "last_incident";

class TimeCounterSharedPreferenceProvider {
  /// Get current stored time counter.
  Future<TimeCounter> getCounter() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey(TITLE) && _prefs.containsKey(LAST_INCIDENT)) {
      String title = _prefs.getString(TITLE)!;
      String lastIncidentString = _prefs.getString(LAST_INCIDENT)!;
      DateTime lastIncident = DateTime.parse(lastIncidentString);

      return TimeCounter(
        id: "",
        title: title,
        createdAt: lastIncident,
      );
    } else {
      final counter = TimeCounter.empty;
      await setCounter(counter);
      return counter;
    }
  }

  /// Stores counter in local key-value storage.
  Future<void> setCounter(TimeCounter counter) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(TITLE, counter.title);
    _prefs.setString(LAST_INCIDENT, counter.createdAt.toIso8601String());
  }

  /// Resets the counter time to now.
  Future<void> resetCounter() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final now = DateTime.now().toIso8601String();
    print(now);
    _prefs.setString(LAST_INCIDENT, now);
  }

  /// Deletes all counter information from key-value storage.
  Future<void> clear() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove(TITLE);
    _prefs.remove(LAST_INCIDENT);
  }
}
