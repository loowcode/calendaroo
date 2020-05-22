import 'package:calendaroo/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class ProfileViewModel {
  ProfileViewModel();

  static ProfileViewModel fromStore(Store<AppState> store) {
    return ProfileViewModel();
  }
}
