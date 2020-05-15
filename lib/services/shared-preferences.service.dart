import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class SharedPreferenceService {
  SharedPreferenceService._();

  static final SharedPreferenceService _instance = SharedPreferenceService._();

  SharedPreferences _prefs;

  Future<bool> getSharedPreferencesInstance() async {
    _prefs = await SharedPreferences.getInstance().catchError((e) {
      print("shared prefrences error : $e");
      return false;
    });
    return true;
  }

  Future setString(String name, String value) async {
    await _prefs.setString(name, value);
  }

  Future setBool(String name, bool value) async {
    await _prefs.setBool(name, value);
  }

  Future remove(String name) async {
    await _prefs.remove(name);
  }

  Future clearAll() async {
    await _prefs.clear();
  }


  CalendarFormat get calendarFormat {
    var format = _prefs.getString('calendarFormat');
    if (format == null || format == 'month') {
      return CalendarFormat.month;
    } else {
      return CalendarFormat.week;
    }
  }

  factory SharedPreferenceService() {
    return _instance;
  }
}
