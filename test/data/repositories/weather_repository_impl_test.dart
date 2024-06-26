import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_uss/core/error/exception.dart';
import 'package:weather_uss/core/error/failure.dart';
import 'package:weather_uss/data/models/weather_model.dart';
import 'package:weather_uss/data/repositories/weather_repository_impl.dart';
import 'package:weather_uss/domain/entities/weather.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(
      weatherRemoteDataSource: mockWeatherRemoteDataSource,
    );
  });

  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clouds',
    description: 'overcast clouds',
    iconCode: '04n',
    temperature: 282.39,
    pressure: 1017,
    humidity: 85,
  );

  const testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'overcast clouds',
    iconCode: '04n',
    temperature: 282.39,
    pressure: 1017,
    humidity: 85,
  );

  const testCityName = 'New York';

  group('get current weather', () {
    test('should return current weather when a call to data source is success',
        () async {
      // arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenAnswer((_) async => testWeatherModel);

      // act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);
      // assert
      expect(result, equals(const Right(testWeatherEntity)));
    });

    test(
        'should return server failure when a call to data source is unsuccessful',
        () async {
      // arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenThrow(ServerException());

      // act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);
      // assert
      expect(
          result, equals(const Left(ServerFailure('An error has occurred'))));
    });

    test('should return connection failure when the device has no internet',
        () async {
      // arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenThrow(const SocketException('Failed to connect to the network'));

      // act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);
      // assert
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });
}
