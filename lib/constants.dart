// General constants
const String DEVELOP = 'develop';
const String INTEGRATION = 'integration';
const String VERSION = '0.0.1-alpha';

// keys for translate json file
class Texts {
  static const String APP_NAME = "appName";
  static const String HOME = "home";
  static const String TODO = "todo";
  static const String PROFILE = "profile";
  static const String UPCOMING_EVENTS = "upcoming-events";
  static const String START = "start";
}

// Example holidays
final Map<DateTime, List> holidays = {
  DateTime(2019, 1, 1): ['New Year\'s Day'],
  DateTime(2019, 1, 6): ['Epiphany'],
  DateTime(2019, 2, 14): ['Valentine\'s Day'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 4, 22): ['Easter Monday'],
};
