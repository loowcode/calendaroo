import 'package:flutter/services.dart';
import 'package:weather/weather_library.dart';

class WeatherService {
  WeatherService._();

  static final WeatherService _instance = WeatherService._();

  getWeather() async{
    String apiKey = await rootBundle.loadString('assets/secret/openweather-key.txt');
    WeatherStation weatherStation = new WeatherStation(apiKey);

    Weather weather = await weatherStation.currentWeather(1, 1);

  }
}