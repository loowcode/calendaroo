import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:redux/redux.dart';

class AppMiddleware extends MiddlewareClass<AppState>{

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if(action is AddEvent){
      // Do something of logic
    }
    next(action);
  }
}