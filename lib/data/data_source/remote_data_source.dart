import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:weather_uss/core/constants/constants.dart';
import 'package:weather_uss/core/error/exception.dart';
import 'package:weather_uss/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityname);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String cityname) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName(cityname)));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
