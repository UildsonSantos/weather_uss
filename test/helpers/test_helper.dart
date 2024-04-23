import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:weather_uss/data/data_source/remote_data_source.dart';
import 'package:weather_uss/domain/repositories/weather_repository.dart';
import 'package:weather_uss/domain/usecases/get_current_weather.dart';

@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
    GetCurrentWeatherUseCase,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
