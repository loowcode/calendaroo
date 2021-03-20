import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:calendaroo/models/settings.dart';
import 'package:calendaroo/services/shared-preferences.service.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is SettingsLoadEvent) {
      yield SettingsLoading();
      var settings = Settings(SharedPreferenceService().enableNotifications);
      yield SettingsUpdated(settings);
    }

    if (event is SettingsChangedEvent) {
      // TODO: add Repository layer. The repository layer calls the data layer that can be SharedPreferences, database, HTTP requests and so on.
      // The repository layer has to be a "generic" layer, decoupling Bloc behaviour from the actual way of storing things
      // Other than this, here we have to add this:
      // NotificationService().rescheduleForEvent(); for rescheduling all event notifications when notificationEnabled is true
      // cancelAllNotifications(); for canceling all current event notifications when notificationEnabled is false
      await SharedPreferenceService()
          .setBool('enableNotifications', event.values.notificationsEnabled);
      yield SettingsUpdated(Settings(event.values.notificationsEnabled));
    }
  }
}
