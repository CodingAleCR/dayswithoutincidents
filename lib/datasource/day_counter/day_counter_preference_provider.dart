import 'package:dwi/datasource/day_counter/day_counter_provider.dart';
import 'package:dwi/domain/models/day_counter.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String TITLE = "title";
const String LAST_INCIDENT = "last_incident";

class DayCounterSharedPreferenceProvider implements DayCounterProvider {
  SharedPreferences _prefs;
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  DayCounter getCounter() {
    if (_prefs.containsKey(TITLE) && _prefs.containsKey(LAST_INCIDENT)) {
      DateTime now = DateTime.now();
      String title = _prefs.getString(TITLE);
      String lastIncidentString = _prefs.getString(LAST_INCIDENT);
      DateTime lastIncident = DateTime.parse(lastIncidentString);

      return DayCounter(title, lastIncident);
    } else {
      final counter = DayCounter.EMPTY_COUNTER;
      setCounter(counter);

      return counter;
    }
  }

  @override
  void setCounter(DayCounter counter) {
    _prefs.setString(TITLE, counter.title);
    _prefs.setString(LAST_INCIDENT, counter.incident.toIso8601String());
  }

  @override
  Future<void> resetCounter() async {
    final now = DateTime.now().toIso8601String();
    print(now);
    _prefs.setString(LAST_INCIDENT, now);
  }

  void clear() {
    _prefs.setString(TITLE, null);
    _prefs.setString(LAST_INCIDENT, null);
  }

  void dispose() {}
}
