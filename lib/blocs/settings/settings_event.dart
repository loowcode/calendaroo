part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class SettingsLoadEvent extends SettingsEvent {
  @override
  List<Object> get props => [];
}

class SettingsChangedEvent extends SettingsEvent {
  final Settings values;

  SettingsChangedEvent(this.values);

  @override
  List<Object> get props => [values];
}
