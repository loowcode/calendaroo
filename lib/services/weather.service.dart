import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

class WeatherService {
  WeatherService._();

  static final WeatherService _instance = WeatherService._();

  factory WeatherService() {
    return _instance;
  }

  WeatherDescription resultCached;
  DateTime timestamp;

  Future<WeatherDescription> getWeather() async {
    try {
      if (resultCached != null &&
          timestamp != null &&
          DateTime.now().difference(timestamp).inMinutes < 30) {
        return resultCached;
      }
      timestamp = DateTime.now();
      var position = await Geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      var apiKey =
          await rootBundle.loadString('assets/secret/openweather-key.txt');
      var weatherStation = WeatherFactory(apiKey);

      var weather = await weatherStation.currentWeatherByLocation(
          position.latitude, position.longitude);

      switch (weather.weatherIcon) {
        case '01d':
        case '01n':
          resultCached = WeatherDescription.CLEAR;
          return WeatherDescription.CLEAR;
        case '02d':
        case '02n':
          resultCached = WeatherDescription.CLOUD;
          return WeatherDescription.CLOUD;
        case '03d':
        case '03n':
          resultCached = WeatherDescription.CLOUD_SUN;
          return WeatherDescription.CLOUD_SUN;
        case '04d':
        case '04n':
          resultCached = WeatherDescription.CLOUD;
          return WeatherDescription.CLOUD;
        case '09d':
        case '09n':
          resultCached = WeatherDescription.CLOUD;
          return WeatherDescription.CLOUD;
        case '10d':
        case '10n':
          resultCached = WeatherDescription.RAIN;
          return WeatherDescription.RAIN;
        case '11d':
        case '11n':
          resultCached = WeatherDescription.STORM;
          return WeatherDescription.STORM;
        case '13d':
        case '13n':
          resultCached = WeatherDescription.SNOW;
          return WeatherDescription.SNOW;
        case '50d':
        case '50n':
          resultCached = WeatherDescription.MIST;
          return WeatherDescription.MIST;
        default:
          resultCached = WeatherDescription.OFFLINE;
          return WeatherDescription.OFFLINE;
      }
    } catch (exception) {
      debugPrint(exception.toString());
      return WeatherDescription.OFFLINE;
    }
  }
}

enum WeatherDescription {
  CLEAR,
  CLOUD_SUN,
  CLOUD,
  RAIN,
  STORM,
  SNOW,
  MIST,
  OFFLINE
}
