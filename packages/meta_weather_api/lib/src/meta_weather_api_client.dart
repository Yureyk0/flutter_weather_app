import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta_weather_api/meta_weather_api.dart';

import 'utilities/constants.dart';

/// Exception thrown when the provided location is not found.
class LocationNotFoundFailure implements Exception {}

/// Exception thrown when getWeather fails.
class WeatherRequestFailure implements Exception {}

/// Exception thrown when weather for provided location is not found.
class WeatherNotFoundFailure implements Exception {}

class MetaWeatherApiClient {
  /// {@macro meta_weather_api_client}
  MetaWeatherApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();
  final http.Client _httpClient;

  /// Fetches [Weather] for a given [locationId].
  Future<WeatherForecastModel> getWeather(String city) async {
    final queryParameters = {
      'key': Constants.WEATHER_APP_ID,
      'q': city,
      'aqi': 'no',
      'days': '10'
    };

    final weatherRequest = Uri.https(Constants.WEATHER_BASE_URL_DOMAIN,
        Constants.WEATHER_FORECAST_TODAY_PATH, queryParameters);

    final weatherResponse = await _httpClient.get(weatherRequest);

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    final bodyJson = jsonDecode(weatherResponse.body) as Map<String, dynamic>;

    if (bodyJson.isEmpty || weatherResponse.statusCode == 400) {
      throw WeatherNotFoundFailure();
    }

    return WeatherForecastModel.fromJson(bodyJson);
  }
}
