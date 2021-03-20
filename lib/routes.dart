import 'package:calendaroo/blocs/settings_bloc.dart';
import 'package:calendaroo/pages/container.page.dart';
import 'package:calendaroo/pages/details/datails.page.dart';
import 'package:calendaroo/pages/settings/settings.page.dart';
import 'package:calendaroo/pages/today/today.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      // TODO: maybe move the BlocProvider elsewhere
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => SettingsBloc(),
                child: SettingsPage(),
              ),
          settings: settings);
    case TODAY:
      return MaterialPageRoute(
          builder: (context) => TodayPage(), settings: settings);
    case DETAILS:
      return MaterialPageRoute(
          builder: (context) => DetailsPage(settings.arguments as Event),
          settings: settings);
    default:
      return MaterialPageRoute(
          builder: (context) => ContainerPage(), settings: settings);
  }
};
