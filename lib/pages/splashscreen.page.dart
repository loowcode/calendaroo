import 'package:calendaroo/redux/actions/app-status.actions.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:calendaroo/services/calendar.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class SplashscreenPage extends StatefulWidget {
  final Store<AppState> store;

  SplashscreenPage({Key key, this.store}) : super(key: key);

  @override
  _SplashscreenPageState createState() => _SplashscreenPageState();
}

class _SplashscreenPageState extends State<SplashscreenPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var store = StoreProvider.of<AppState>(context);
//      store.dispatch(LoadedEventsList(eventsList));
      store.dispatch(StartApplication(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, _) {
          return Scaffold(
            body: Text('splashscreen'),
          );
        });
  }
}
