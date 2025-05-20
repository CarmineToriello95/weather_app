import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:weather_app/features/weather/data/datasources/weather_forecast_remote_data_source.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_forecast_repository.dart';

@GenerateMocks([
  http.Client,
  WeatherForecastRemoteDataSource,
  WeatherForecastRepository,
])
class Mocks {}
