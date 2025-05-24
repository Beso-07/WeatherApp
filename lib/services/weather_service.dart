import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:watherapp/models/weather_model.dart';

class WeatherService {
  final Dio dio;
  WeatherService(this.dio);
  final String baseUrl = 'https://api.weatherapi.com/v1';
  final String apiKey = '11eda0859d87432683191855252404';

  Future<WeatherModel> getWeather({required String city}) async {
    try {
      Response response = await dio.get(
        '$baseUrl/forecast.json?key=$apiKey&q=$city&days=1',
      );
      WeatherModel weatherModel = WeatherModel.fromJson(response.data);
      return weatherModel;
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['error']['message'] ??
          'An unexpected error occurred. Please try again later.';
      throw Exception(errorMessage);
    } catch (e) {
      log(e.toString());
      throw Exception('An unexpected error occurred. Please try again later.');
    }
  }
}
