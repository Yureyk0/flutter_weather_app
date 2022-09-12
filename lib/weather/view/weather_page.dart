import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/search/search.dart';
import 'package:flutter_weather_app/weather/cubit/weather_cubit.dart';

import 'package:weather_repository/weather_repository.dart';

import 'component/component.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(context.read<WeatherRepository>()),
      child: const WeatherView(),
    );
  }
}

class WeatherView extends StatelessWidget {
  const WeatherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: RepositoryProvider(
        create: (context) => WeatherRepository(),
        child: BlocProvider(
          create: (context) => WeatherCubit(context.read<WeatherRepository>()),
          child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 33,
                  ),
                  onPressed: () async {
                    final city =
                        await Navigator.of(context).push(SearchPage.route());

                    await context.read<WeatherCubit>().fetchWeather(city);
                  },
                ),
              ],
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Today'),
                  Tab(text: 'Tommorow'),
                  Tab(text: '10 days'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                BlocProvider.value(
                  value: context.read<WeatherCubit>(),
                  child: const ForecastTodayScreen(),
                ),
                BlocProvider.value(
                  value: context.read<WeatherCubit>(),
                  child: const ForecastTommorowScreen(),
                ),
                BlocProvider.value(
                  value: context.read<WeatherCubit>(),
                  child: ForecastDaysScreen(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
