import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, String> _localizedStrings;

  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    var jsonString =
        await rootBundle.loadString('assets/langs/${locale.languageCode}.json');
    var jsonMap = json.decode(jsonString) as Map<String, dynamic>;

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    return _localizedStrings[key];
  }

  static const String DELETE = 'delete';

  String get addDescription => _localizedStrings['add_description'];
  String get addEvent => _localizedStrings['add_event'];
  String get addTitle=> _localizedStrings['add_title'];
  String get allDay=> _localizedStrings['all_day'];
  String get appName => _localizedStrings['app_name'];
  String get cancel => _localizedStrings['cancel'];
  String get compact => _localizedStrings['compact'];
  String get daily => _localizedStrings['daily'];
  String get delete => _localizedStrings[DELETE];
  String get description => _localizedStrings['description'];
  String get editEvent => _localizedStrings['edit_event'];
  String get event => _localizedStrings['event'];
  String get events => _localizedStrings['events'];
  String get eventEnd => _localizedStrings['event_end'];
  String get eventStart => _localizedStrings['event_start'];
  String get expanded => _localizedStrings['expanded'];
  String get feedback => _localizedStrings['feedback'];
  String get feedbackInfo => _localizedStrings['feedback_info'];
  String get home => _localizedStrings['home'];
  String get insertATitle => _localizedStrings['insert_a_title'];
  String get madeWithLove => _localizedStrings['made_with_love'];
  String get monthly => _localizedStrings['monthly'];
  String get never => _localizedStrings['never'];
  String get newEvent => _localizedStrings['new_event'];
  String get newEventTitle => _localizedStrings['new_event_title'];
  String get no => _localizedStrings['no'];
  String get noEvents => _localizedStrings['no_events'];
  String get notifications => _localizedStrings['notifications'];
  String get ok => _localizedStrings['Ok'];
  String get profile => _localizedStrings['profile'];
  String get repeat => _localizedStrings['repeat'];
  String get save => _localizedStrings['save'];
  String get sendFeedback => _localizedStrings['send_feedback'];
  String get setStopDate => _localizedStrings['set_stop_date'];
  String get settings => _localizedStrings['settings'];
  String get start => _localizedStrings['start'];
  String get title => _localizedStrings['title'];
  String get today => _localizedStrings['today'];
  String get todo => _localizedStrings['todo'];
  String get until => _localizedStrings['until'];
  String get version => _localizedStrings['version'];
  String get warning => _localizedStrings['warning'];
  String get warningNoEmailApp => _localizedStrings['warning_no_email_app'];
  String get weekly => _localizedStrings['weekly'];
  String get yearly => _localizedStrings['yearly'];
  String get yes => _localizedStrings['yes'];
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'it'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    var localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
