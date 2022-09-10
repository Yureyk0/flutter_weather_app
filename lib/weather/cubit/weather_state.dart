part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final weather;
  WeatherLoadedState(this.weather);
}

class WeatherErrorState extends WeatherState {}
