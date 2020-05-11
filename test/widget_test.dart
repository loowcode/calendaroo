// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:calendaroo/redux/middlewares/app.middlewares.dart';
import 'package:calendaroo/redux/middlewares/calendar.middlewares.dart';
import 'package:calendaroo/redux/reducers/app.reducer.dart';
import 'package:calendaroo/redux/states/app.state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

import 'package:calendaroo/main.dart';

void main() {
  testWidgets('Navigate NewEvent test', (WidgetTester tester) async {
//    await setUpEnv();
//    var store = createStore();
//    initializerAppService.preLoadingData(store);

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    expect(find.text('April 2020'), findsNothing);

    // Verify that our counter starts at 0.
//    expect(find.text('0'), findsOneWidget);
//    expect(find.text('1'), findsNothing);
//
//    // Tap the '+' icon and trigger a frame.
//    await tester.tap(find.byIcon(Icons.add));
//    await tester.pump();
//
//    // Verify that our counter has incremented.
//    expect(find.text('0'), findsNothing);
//    expect(find.text('1'), findsOneWidget);
  });
}

Store<AppState> createStore() {
  return Store(appReducer,
      initialState: AppState.initial(),
      middleware: [AppMiddleware(), CalendarMiddleware()]);
}
