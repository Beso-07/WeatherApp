import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watherapp/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:watherapp/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:watherapp/views/search_view.dart';
import 'package:watherapp/widgets/no_weather_data.dart';
import 'package:watherapp/widgets/weather_info.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          '🌤️Weather App',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return SearchView();
                  },
                ),
              );
            },
            icon: const Icon(Icons.search),
            color: Colors.white,
          ),
        ],
      ),
      body: BlocBuilder<GetWeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is InitialState) {
            return NoWeatherData();
          } else if (state is WeatherLoadedState) {
            return WeatherInfo();
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'oops, there was an error, please try again',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
