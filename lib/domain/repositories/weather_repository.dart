import 'package:dartz/dartz.dart';
import 'package:weather_uss/core/error/failure.dart';
import 'package:weather_uss/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName);
}
