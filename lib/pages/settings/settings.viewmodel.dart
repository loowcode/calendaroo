import 'package:calendaroo/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class SettingsViewModel {
  SettingsViewModel();

  static SettingsViewModel fromStore(Store<AppState> store) {
    return SettingsViewModel();
  }
}