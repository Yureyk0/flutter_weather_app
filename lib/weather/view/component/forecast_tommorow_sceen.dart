import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/weather/cubit/weather_cubit.dart';
import 'package:flutter_weather_app/weather/widget/widgets.dart';
import 'package:intl/intl.dart';

import 'forecast_hourly_list.dart';

class ForecastTommorowScreen extends StatelessWidget {
  const ForecastTommorowScreen({Key? key}) : super(key: key);

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

        final forecastCurrent = state.weather.current;
        final String srcImage = forecastCurrent.condition.icon;
        final String fullSrcImage = srcImage.substring(20, srcImage.length);
        DateTime date = DateTime.fromMillisecondsSinceEpoch(
            forecastCurrent.lastUpdatedEpoch * 1000);
        final String fullDate = DateFormat('EEEEE, d MMMM').format(date);
        log(fullSrcImage);
        return Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff06C7F1),
                    Color(0xff07B9E0),
                    Color(0xff0648F1),
                  ],
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_pin,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        state.weather.location.name.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.network(
                    'https:$srcImage',
                    scale: 0.4,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${forecastCurrent.tempC.toString()}°',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 110,
                            fontWeight: FontWeight.w500,
                            height: 0.9),
                      ),
                      Text(
                        forecastCurrent.condition.text,
                        style: const TextStyle(
                          color: Color(0xffFAFD74),
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        fullDate,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color(0xffE8E8E8),
                    thickness: 1.1,
                    height: 25,
                    indent: 55,
                    endIndent: 55,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 75,
                        child: Column(
                          children: [
                            const Icon(
                              Icons.wind_power_outlined,
                              color: Colors.white,
                              size: 27,
                            ),
                            Text(
                              '${forecastCurrent.windKph.toString()} km/h',
                              style: const TextStyle(
                                fontSize: 13.25,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffE8E8E8),
                              ),
                            ),
                            const Text(
                              'Wind',
                              style: TextStyle(
                                fontSize: 13.25,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(201, 232, 232, 232),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 75,
                        child: Column(
                          children: [
                            const Icon(
                              Icons.water_drop_outlined,
                              color: Colors.white,
                              size: 27,
                            ),
                            Text(
                              '${forecastCurrent.humidity.toString()}%',
                              style: const TextStyle(
                                fontSize: 13.25,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffE8E8E8),
                              ),
                            ),
                            const Text(
                              'Humidity',
                              style: TextStyle(
                                fontSize: 13.25,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(201, 232, 232, 232),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 75,
                        child: Column(
                          children: [
                            const Icon(
                              Icons.water_rounded,
                              color: Colors.white,
                              size: 27,
                            ),
                            Text(
                              '${state.weather.forecast.forecastday[0].day.dailyChanceOfRain}%',
                              style: const TextStyle(
                                fontSize: 13.25,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffE8E8E8),
                              ),
                            ),
                            const Text(
                              'Chance of rain',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13.25,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(201, 232, 232, 232),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            HourlyList(
              hourlyList: state.weather.forecast.forecastday[0].hour,
            ),
          ],
        );
      }
      return const SizedBox.shrink();
    });
  }
}
