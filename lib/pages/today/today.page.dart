import 'package:calendaroo/colors.dart';
import 'package:calendaroo/routes.dart';
import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:calendaroo/services/navigation.service.dart';
import 'package:calendaroo/services/weather.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class TodayPage extends StatefulWidget {
  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> with TickerProviderStateMixin {
  Future<void> weather;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: white,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildTitle(context),
                  IconButton(
                    onPressed: () {
                      NavigationService().navigateTo(SETTINGS);
                    },
                    icon: FaIcon(FontAwesomeIcons.user, color: grey,),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    var _formatterDate =
        new DateFormat.yMMMMEEEEd(Localizations.localeOf(context).toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              AppLocalizations.of(context).today,
              style: Theme.of(context).textTheme.headline4,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: _weather(),
            )
          ],
        ),
        Text(
          _formatterDate.format(DateTime.now()),
          style: Theme.of(context).textTheme.bodyText2,
        )
      ],
    );
  }

  Widget _weather() {
    return FutureBuilder<WeatherDescription>(
      future: WeatherService().getWeather(),
      builder:
          (BuildContext context, AsyncSnapshot<WeatherDescription> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return SizedBox();
          case ConnectionState.waiting:
            return SizedBox();
          default:
            if (snapshot.hasError)
              return Icon(
                Icons.cloud_off,
                color: lightGrey,
              );
            else
              return iconWeather(snapshot.data);
        }
      },
    );
  }

  Widget iconWeather(WeatherDescription weather) {
    switch (weather) {
      case WeatherDescription.CLEAR:
        return FaIcon(FontAwesomeIcons.sun, color: yellow,);
      case WeatherDescription.CLOUD_SUN:
        return FaIcon(FontAwesomeIcons.cloudSun, color: grey,);
      case WeatherDescription.CLOUD:
        return Icon(Icons.cloud_queue);
      case WeatherDescription.RAIN:
        return FaIcon(FontAwesomeIcons.cloudRain, color: lightBlue,);
      case WeatherDescription.STORM:
        return FaIcon(FontAwesomeIcons.cloudShowersHeavy, color: lightBlue,);
      case WeatherDescription.SNOW:
        return FaIcon(FontAwesomeIcons.snowflake, color: lightBlue,);
      case WeatherDescription.MIST:
        return FaIcon(FontAwesomeIcons.wind, color: grey,);
      default:
        return Icon(Icons.cloud_off, color: lightGrey,);
    }
  }
}
