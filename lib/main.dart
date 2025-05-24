import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watherapp/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:watherapp/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:watherapp/views/home_view.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: Builder(
        builder:
            (context) => BlocBuilder<GetWeatherCubit, WeatherState>(
              builder: (context, state) {
                return MaterialApp(
                  theme: ThemeData(
                    primarySwatch: getThemeColor(
                      BlocProvider.of<GetWeatherCubit>(
                        context,
                      ).weatherModel?.condition,
                    ),
                    useMaterial3: false,
                  ),

                  debugShowCheckedModeBanner: false,
                  home: HomeView(),
                );
              },
            ),
      ),
    );
  }
}

MaterialColor getThemeColor(String? condition) {
  if (condition == null) {
    return Colors.blue;
  }

  if (condition == 'Sunny' || condition == 'Clear') {
    return Colors.orange;
  } else if (condition == 'Partly cloudy' ||
      condition == 'Cloudy' ||
      condition == 'Overcast') {
    return Colors.blueGrey;
  } else if (condition == 'Mist' ||
      condition == 'Fog' ||
      condition == 'Freezing fog') {
    return Colors.grey;
  } else if (condition.contains('rain') ||
      condition.contains('drizzle') ||
      condition.contains('shower')) {
    return Colors.blue;
  } else if (condition.contains('snow') ||
      condition.contains('Blizzard') ||
      condition.contains('sleet') ||
      condition.contains('ice pellets')) {
    return Colors.lightBlue;
  } else if (condition.contains('thunder')) {
    return Colors.deepPurple;
  } else {
    return Colors.blue;
  }
}
