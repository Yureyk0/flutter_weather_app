import 'dart:async';

import 'package:meta_weather_api/meta_weather_api.dart' hide Weather;

class WeatherFailure implements Exception {}

class WeatherRepository {
  WeatherRepository({MetaWeatherApiClient? weatherApiClient})
      : _weatherApiClient = weatherApiClient ?? MetaWeatherApiClient();

  final MetaWeatherApiClient _weatherApiClient;

  Future<WeatherForecastModel> getWeather(String city) async {
    final weather = await _weatherApiClient.getWeather(city);

    return weather;
  }
}
