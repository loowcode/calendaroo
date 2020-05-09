import 'package:calendaroo/pages/add-event/add-event.page.dart';
import 'package:calendaroo/pages/home.page.dart';
import 'package:calendaroo/pages/show-event/show-event.page.dart';

const HOMEPAGE = '/home';
const ADD_EVENT = '/add_event';
const SHOW_EVENT = '/show_event';

final routes = {
  HOMEPAGE: (context) => HomePage(),
  ADD_EVENT: (context) => AddEventPage(),
  SHOW_EVENT: (context) => ShowEventPage(),
};
