import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:weather_app/features/weather/data/datasources/weather_forecast_remote_data_source.dart';

@GenerateMocks([http.Client, WeatherForecastRemoteDataSource])
class Mocks {}
