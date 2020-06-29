import 'package:calendaroo/pages/container.page.dart';
import 'package:calendaroo/pages/details/datails.page.dart';
import 'package:calendaroo/pages/settings/settings.page.dart';
import 'package:calendaroo/pages/today/today.page.dart';
import 'package:flutter/material.dart';

import 'model/event.model.dart';

const HOMEPAGE = '/home';
const SETTINGS = '/settings';
const TODAY = '/today';
const DETAILS = '/details';

MaterialPageRoute<dynamic> Function(RouteSettings) routes =
    (RouteSettings settings) {
  switch (settings.name) {
    case HOMEPAGE:
      return MaterialPageRoute(
          builder: (context) => ContainerPage(), settings: settings);
    case SETTINGS:
      return MaterialPageRoute(
          builder: (context) => SettingsPage(), settings: settings);
    case TODAY:
      return MaterialPageRoute(
          builder: (context) => TodayPage(), settings: settings);
    case DETAILS:
      return MaterialPageRoute(
          builder: (context) =>
              DetailsPage(ModalRoute.of(context).settings.arguments as Event),
          settings: settings);
    default:
      return MaterialPageRoute(
          builder: (context) => ContainerPage(), settings: settings);
  }
};
