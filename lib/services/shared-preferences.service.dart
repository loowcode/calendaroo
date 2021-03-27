import 'package:calendaroo/widgets/calendar/calendar.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static const ENABLE_NOTIFICATIONS = 'enableNotifications';
  SharedPreferenceService._();


  static final SharedPreferenceService _instance = SharedPreferenceService._();

  SharedPreferences _prefs;

  Future<void> getSharedPreferencesInstance() async {
    _prefs = await SharedPreferences.getInstance().catchError((String e) {
      debugPrint('shared prefrences error : $e');
    });
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

  CalendarSize get calendarSize {
    var format = _prefs.getString('calendarSize');
    if (format == 'twoWeeks') {
      return CalendarSize.TWO_WEEKS;
    }
    if (format == 'week') {
      return CalendarSize.WEEK;
    }
    if (format == 'hide') {
      return CalendarSize.HIDE;
    }
    return CalendarSize.MONTH;
  }

  void setCalendarSize(String value) {
    _prefs.setString('calendarSize', value);
  }


  bool get enableNotifications {
    return _prefs.getBool(ENABLE_NOTIFICATIONS) ?? true;
  }

  void setEnableNotifications(bool value) async {
    await _prefs.setBool(ENABLE_NOTIFICATIONS, value);
  }

  factory SharedPreferenceService() {
    return _instance;
  }
}
