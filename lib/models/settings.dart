import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  final bool notificationsEnabled;

  Settings(this.notificationsEnabled);

  @override
  List<Object> get props => [notificationsEnabled];
}
