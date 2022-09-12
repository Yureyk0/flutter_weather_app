import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/weather/cubit/weather_cubit.dart';
import 'package:flutter_weather_app/weather/widget/widgets.dart';
import 'package:intl/intl.dart';

class ForecastDaysScreen extends StatelessWidget {
  const ForecastDaysScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherState>(
        listener: (((context, state) {
      log(state.toString());
    })), builder: (context, state) {
      if (state is WeatherInitial) {
        return const WeatherEmpty();
      }
      if (state is WeatherErrorState) {
        return const WeatherError();
      }
      if (state is WeatherLoadedState) {
        log(state.weather.current.tempC.toString());
        final forecastDays = state.weather.forecast.forecastday;
        // final forecastCurrent = state.weather.current;
        // final String srcImage = forecastCurrent.condition.icon;
        // final String fullSrcImage = srcImage.substring(20, srcImage.length);
        // DateTime date = DateTime.fromMillisecondsSinceEpoch(
        //     state.weather.forecast.forecastday[0].dateEpoch * 1000);
        // final String fullDate = DateFormat('EEEEE, d MMMM').format(date);
        // log(fullSrcImage);
        return Column(
          children: [
            Expanded(
              child: ListView(
                // This next line does the trick.
                scrollDirection: Axis.vertical,
                children: List.generate(forecastDays.length, (index) {
                  DateTime date = DateTime.fromMillisecondsSinceEpoch(
                      forecastDays[index].dateEpoch * 1000);
                  final String fullDate =
                      DateFormat('EEEEE, d MMM').format(date);
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(4),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(fullDate),
                                  Text(
                                    forecastDays[index].day.condition.text,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.network(
                                    'https:${forecastDays[index].day.condition.icon}',
                                    scale: 1.3,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                          '${forecastDays[index].day.maxtempC.round()}°'),
                                      Text(
                                        '${forecastDays[index].day.mintempC.round()}°',
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const Divider()
                    ],
                  );
                }),
              ),
            ),
          ],
        );
      }
      return const SizedBox.shrink();
    });
  }
}
