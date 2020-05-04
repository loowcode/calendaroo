import 'package:calendaroo/redux/actions/app-status.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';

class AppMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is StartApplication) {
      Navigator.of(action.context).pushNamed(HOMEPAGE);
    }
    next(action);
  }
}
