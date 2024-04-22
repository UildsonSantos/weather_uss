import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_uss/data/models/weather_model.dart';
import 'package:weather_uss/domain/entities/weather.dart';

import '../../helpers/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clouds',
    description: 'overcast clouds',
    iconCode: '04n',
    temperature: 282.39,
    pressure: 1017,
    humidity: 85,
  );

  test('should be a subclass of weather entity', () async {
    // assert
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test('should return a valid model from json', () async {
    //arrange
    final Map<String, dynamic> jsonMap =
        jsonDecode(readJson('helpers/dummy_data/dummy_weather_response.json'));

    //act
    final result = WeatherModel.fromJson(jsonMap);

    expect(result, equals(testWeatherModel));
  });

  test('should return a json map containing proper data', () async {
    //act
    final result = testWeatherModel.toJson();

    //assert

    final expectedJsonMap = {
      'weather': [
        {
          'main': 'Clouds',
          'description': 'overcast clouds',
          'icon': '04n',
        },
      ],
      'main': {
        'temp': 282.39,
        'pressure': 1017,
        'humidity': 85,
      },
      'name': 'New York',
    };

    expect(result, equals(expectedJsonMap));
  });
}
