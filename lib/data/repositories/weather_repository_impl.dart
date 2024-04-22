import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather_uss/core/error/exception.dart';
import 'package:weather_uss/core/error/failure.dart';
import 'package:weather_uss/data/data_source/remote_data_source.dart';
import 'package:weather_uss/domain/entities/weather.dart';
import 'package:weather_uss/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String cityName) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
