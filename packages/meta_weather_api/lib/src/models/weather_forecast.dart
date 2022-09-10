import 'weather_forecast_current_model.dart';
import 'weather_forecast_days_model.dart';
import 'weather_forecast_location_model.dart';

class WeatherForecastModel {
  Location? location;
  Current? current;
  Forecast? forecast;

  WeatherForecastModel({location, current, forecast});

  WeatherForecastModel.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    current =
        json['current'] != null ? Current.fromJson(json['current']) : null;
    forecast =
        json['forecast'] != null ? Forecast.fromJson(json['forecast']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (current != null) {
      data['current'] = current!.toJson();
    }
    if (forecast != null) {
      data['forecast'] = forecast!.toJson();
    }
    return data;
  }
}



