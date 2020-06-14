import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather_library.dart';

class WeatherService {
  WeatherService._();

  WeatherDescription resultCached;
  DateTime timestamp;

  static final WeatherService _instance = WeatherService._();

  factory WeatherService() {
    return _instance;
  }

  Future<WeatherDescription> getWeather() async {
    try {
      if (resultCached != null &&
          timestamp != null &&
          DateTime.now().difference(timestamp).inMinutes < 30) {
        return resultCached;
      }
      timestamp = DateTime.now();
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      String apiKey =
          await rootBundle.loadString('assets/secret/openweather-key.txt');
      WeatherStation weatherStation = new WeatherStation(apiKey);

      Weather weather = await weatherStation.currentWeather(
          position.latitude, position.longitude);

      switch (weather.weatherIcon) {
        case "01d":
        case "01n":
          this.resultCached = WeatherDescription.CLEAR;
          return WeatherDescription.CLEAR;
        case "02d":
        case "02n":
          this.resultCached = WeatherDescription.CLOUD;
          return WeatherDescription.CLOUD;
        case "03d":
        case "03n":
          this.resultCached = WeatherDescription.CLOUD_SUN;
          return WeatherDescription.CLOUD_SUN;
        case "04d":
        case "04n":
          this.resultCached = WeatherDescription.CLOUD;
          return WeatherDescription.CLOUD;
        case "09d":
        case "09n":
          this.resultCached = WeatherDescription.CLOUD;
          return WeatherDescription.CLOUD;
        case "10d":
        case "10n":
          this.resultCached = WeatherDescription.RAIN;
          return WeatherDescription.RAIN;
        case "11d":
        case "11n":
          this.resultCached = WeatherDescription.STORM;
          return WeatherDescription.STORM;
        case "13d":
        case "13n":
          this.resultCached = WeatherDescription.SNOW;
          return WeatherDescription.SNOW;
        case "50d":
        case "50n":
          this.resultCached = WeatherDescription.MIST;
          return WeatherDescription.MIST;
        default:
          this.resultCached = WeatherDescription.OFFLINE;
          return WeatherDescription.OFFLINE;
      }
    } catch (e) {
      debugPrint(e);
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
