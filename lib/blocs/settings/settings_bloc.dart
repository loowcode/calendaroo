import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:calendaroo/models/settings/settings.model.dart';
import 'package:calendaroo/repositories/settings/settings.repository.dart';
import 'package:calendaroo/services/notification.service.dart';
import 'package:calendaroo/utils/notification.utils.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _repository;

  SettingsBloc(this._repository) : super(SettingsInitial());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is SettingsLoadEvent) {
      yield SettingsLoading();
      var settings = await _repository.read();
      yield SettingsUpdated(settings);
    }

    if (event is SettingsChangedEvent) {
      var newSettings = Settings(event.values.notificationsEnabled);
      await _repository.write(newSettings);

      if (newSettings.notificationsEnabled) {
        await NotificationService().rescheduleForEvent();
      } else {
        await cancelAllNotifications();
      }

      yield SettingsUpdated(newSettings);
    }
  }
}
