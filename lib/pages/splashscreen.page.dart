import 'package:calendaroo/redux/actions.dart';
import 'package:calendaroo/redux/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class SplashscreenPage extends StatelessWidget {
  final Store<AppState> store;

  SplashscreenPage({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var events = List<String>();
    events.add('event');
    return StoreConnector<AppState, VoidCallback>(converter: (store) {
      return () => store.dispatch(LoadedEventsList(events));
    }, builder: (context, callback) {
      callback();
      return MaterialApp(home: Container(child: Icon(Icons.home)));
    });
  }
}
