import 'package:calendaroo/blocs/calendar/calendar_bloc.dart';
import 'package:calendaroo/blocs/details/details_bloc.dart';
import 'package:calendaroo/blocs/settings/settings_bloc.dart';
import 'package:calendaroo/models/calendar_item/calendar_item.model.dart';
import 'package:calendaroo/pages/container.page.dart';
import 'package:calendaroo/pages/details/details.page.dart';
import 'package:calendaroo/pages/settings/settings.page.dart';
import 'package:calendaroo/repositories/settings/settings_shared_preferences.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const HOMEPAGE = '/home';
const SETTINGS = '/settings';
const TODAY = '/today';
const DETAILS = '/details';

MaterialPageRoute<dynamic> Function(RouteSettings) routes =
    (RouteSettings settings) {
  switch (settings.name) {
    case HOMEPAGE:
      return MaterialPageRoute<ContainerPage>(
        builder: (context) {
          return ContainerPage();
        },
        settings: settings,
      );

    case SETTINGS:
      return MaterialPageRoute<SettingsPage>(
        builder: (context) {
          return BlocProvider(
            create: (context) =>
                SettingsBloc(SharedPreferencesSettingsRepository()),
            child: SettingsPage(),
          );
        },
        settings: settings,
      );

    // case TODAY:
    //   return MaterialPageRoute<TodayPage>(
    //     builder: (context) {
    //       return BlocProvider(
    //           create: (BuildContext context) =>
    //               CalendarBloc(CalendarLocalRepository()),
    //           child: TodayPage());
    //     },
    //     settings: settings,
    //   );
    //
    case DETAILS:
      return MaterialPageRoute<DetailsPage>(
        builder: (context) {
          var calendarBloc = BlocProvider.of<CalendarBloc>(context);

          return BlocProvider(
            create: (BuildContext context) => DetailsBloc(
              calendarBloc,
              calendarItemModel: settings.arguments as CalendarItemModel,
            ),
            child: DetailsPage(),
          );
        },
        settings: settings,
      );

    default:
      return MaterialPageRoute<ContainerPage>(
        builder: (context) {
          return ContainerPage();
        },
        settings: settings,
      );
  }
};
