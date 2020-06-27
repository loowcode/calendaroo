import 'package:calendaroo/pages/add-event/add-event.page.dart';
import 'package:calendaroo/pages/container.page.dart';
import 'package:calendaroo/pages/details/datails.page.dart';
import 'package:calendaroo/pages/settings/settings.page.dart';
import 'package:calendaroo/pages/show-event/show-event.page.dart';
import 'package:calendaroo/pages/today/today.page.dart';
import 'package:flutter/material.dart';

const HOMEPAGE = '/home';
const ADD_EVENT = '/add_event';
const SHOW_EVENT = '/show_event';
const SETTINGS = '/settings';
const TODAY = '/today';
const DETAILS = '/details';

MaterialPageRoute<dynamic> Function(RouteSettings) routes =
    (RouteSettings settings) {
  switch (settings.name) {
    case HOMEPAGE:
      return MaterialPageRoute(
          builder: (context) => ContainerPage(), settings: settings);
    case ADD_EVENT:
      return MaterialPageRoute(
          builder: (context) => AddEventPage(), settings: settings);
    case SHOW_EVENT:
      return MaterialPageRoute(
          builder: (context) => ShowEventPage(), settings: settings);
    case SETTINGS:
      return MaterialPageRoute(
          builder: (context) => SettingsPage(), settings: settings);
    case TODAY:
      return MaterialPageRoute(
          builder: (context) => TodayPage(), settings: settings);
    case DETAILS:
      return MaterialPageRoute(
          builder: (context) => DetailsPage(), settings: settings);
    default:
      return MaterialPageRoute(
          builder: (context) => ContainerPage(), settings: settings);
  }
};
