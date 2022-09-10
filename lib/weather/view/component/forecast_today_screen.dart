import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/weather/cubit/weather_cubit.dart';

class ForecastTodayScreen extends StatelessWidget {
  const ForecastTodayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WeatherCubit>().fetchWeather('Zhytomyr');
    return BlocConsumer<WeatherCubit, WeatherState>(
        listener: (((context, state) {
      log(state.toString());
    })), builder: (context, state) {
      if (state is WeatherLoadedState) {
        log(state.weather.current.tempC.toString());
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
                    children: const [
                      Icon(
                        Icons.location_pin,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Zhytomyr',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Image.network(
                    'http://openweathermap.org/img/wn/10d@2x.png',
                    scale: 0.5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '22',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 110,
                            fontWeight: FontWeight.w500,
                            height: 0.9),
                      ),
                      Text(
                        'Cloudy',
                        style: TextStyle(
                          color: Color(0xffFAFD74),
                          fontSize: 53,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Monday, 17 May',
                        style: TextStyle(color: Colors.white),
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
                        width: 50,
                        child: Column(
                          children: const [
                            Icon(
                              Icons.wind_power_outlined,
                              color: Colors.white,
                              size: 27,
                            ),
                            Text(
                              '13 km/h',
                              style: TextStyle(
                                fontSize: 13.25,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffE8E8E8),
                              ),
                            ),
                            Text(
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
                        width: 55,
                        child: Column(
                          children: const [
                            Icon(
                              Icons.water_drop_outlined,
                              color: Colors.white,
                              size: 27,
                            ),
                            Text(
                              '24%',
                              style: TextStyle(
                                fontSize: 13.25,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffE8E8E8),
                              ),
                            ),
                            Text(
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
                        width: 50,
                        child: Column(
                          children: const [
                            Icon(
                              Icons.water_rounded,
                              color: Colors.white,
                              size: 27,
                            ),
                            Text(
                              '82%',
                              style: TextStyle(
                                fontSize: 13.25,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffE8E8E8),
                              ),
                            ),
                            Text(
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
            Container(
              height: 150,
            )
          ],
        );
      }
      return const SizedBox.shrink();
    });
  }
}
