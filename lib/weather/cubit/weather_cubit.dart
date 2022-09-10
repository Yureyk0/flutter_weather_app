import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_repository/weather_repository.dart'
    show WeatherRepository;
import 'package:weather_repository/weather_repository.dart'
    as weather_repository;

part 'weather_state.dart';

class WeatherCubit extends HydratedCubit<WeatherState> {
  WeatherCubit(this._weatherRepository) : super(WeatherInitial());

  final WeatherRepository _weatherRepository;

  Future<void> fetchWeather(String? city) async {
    if (city == null || city.isEmpty) return;

    emit(WeatherLoadingState());

    try {
      final weather = await _weatherRepository.getWeather(city);

      emit(WeatherLoadedState(weather: weather));
    } on Exception {
      emit(WeatherErrorState());
    }
  }

  Future<void> refreshWeather(String? city) async {
    try {
      final weather = await _weatherRepository.getWeather(city!);

      emit(WeatherLoadedState(weather: weather));
    } on Exception {
      emit(state);
    }
  }

  @override
  WeatherState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(WeatherState state) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
