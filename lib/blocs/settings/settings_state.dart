part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
}

class SettingsInitial extends SettingsState {
  @override
  List<Object> get props => [];
}

class SettingsLoading extends SettingsState {
  @override
  List<Object> get props => [];
}

class SettingsUpdated extends SettingsState {
  final Settings values;

  SettingsUpdated(this.values);

  @override
  List<Object> get props => [values];
}
