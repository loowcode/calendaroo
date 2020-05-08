import 'package:calendaroo/pages/home.page.dart';
import 'package:calendaroo/pages/show-event/show-event.page.dart';
import 'package:calendaroo/pages/splashscreen.page.dart';

const HOMEPAGE = '/home';
const SPLASHSCREEN = '/splashscreen';
const SHOW_EVENT = '/show_event';

final routes = {
  HOMEPAGE: (context) => HomePage(),
  SPLASHSCREEN: (context) => SplashscreenPage(),
  SHOW_EVENT: (context) => ShowEventPage(),
};
