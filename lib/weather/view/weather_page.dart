import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/weather/cubit/weather_cubit.dart';
import 'package:weather_repository/weather_repository.dart';

import 'component/forecast_today_screen.dart';
import 'component/textfield_search_city_w.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: TextfieldSearchCity(),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Today'),
              Tab(text: 'Today'),
              Tab(text: 'Today'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RepositoryProvider(
              create: (context) => WeatherRepository(),
              child: BlocProvider(
                create: (context) =>
                    WeatherCubit(context.read<WeatherRepository>()),
                child: ForecastTodayScreen(),
              ),
            ),
            Icon(Icons.directions_transit, size: 350),
            Icon(Icons.directions_car, size: 350),
          ],
        ),
      ),
    );
  }
}
