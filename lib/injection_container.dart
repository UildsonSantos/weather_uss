import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:weather_uss/data/data_source/remote_data_source.dart';
import 'package:weather_uss/data/repositories/weather_repository_impl.dart';
import 'package:weather_uss/domain/repositories/weather_repository.dart';
import 'package:weather_uss/domain/usecases/get_current_weather.dart';
import 'package:weather_uss/presentation/bloc/weather_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {

  // bloc
  locator.registerFactory(() => WeatherBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetCurrentWeatherUseCase(locator()));

  // repository
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(weatherRemoteDataSource: locator()),
  );

   // datasource
  locator.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(client: locator()),
  );

   // external
  locator.registerLazySingleton(() => http.Client());
}
