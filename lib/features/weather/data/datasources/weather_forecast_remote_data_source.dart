import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/errors/exception.dart';
import 'package:weather_app/core/errors/weather_forecast/weather_forecast_exception.dart';
import 'package:weather_app/core/utils/api_utils.dart';
import 'package:weather_app/features/weather/data/models/api_response_model.dart';

abstract class WeatherForecastRemoteDataSource {
  /// Calls the api for fetching the weather forecast for the given city.
  ///
  /// Returns a [ApiResponseModel] if successful.
  ///
  /// Throws a [FetchWeatherForecastByCityException] if an error occurs.
  Future<ApiResponseModel> fetchWeatherForecastByCity({
    required String cityName,
  });
}

class WeatherForecastRemoteDataSourceImpl
    implements WeatherForecastRemoteDataSource {
  final http.Client _client;

  WeatherForecastRemoteDataSourceImpl(this._client);

  @override
  Future<ApiResponseModel> fetchWeatherForecastByCity({
    required String cityName,
  }) async {
    try {
      final queryParameters = {
        ApiUtils.queryParamCityName: cityName,
        ApiUtils.apiKeyName: ApiUtils.apiKeyValue,
        ApiUtils.queryParamUnitsName: ApiUtils.queryParamUnitsValue,
      };

      final url = Uri.https(
        ApiUtils.authority,
        ApiUtils.weatherForecastPath,
        queryParameters,
      );

      final response = await _client
          .get(url)
          .timeout(const Duration(seconds: 3));

      if (response.statusCode == 200) {
        final apiResponseModel = ApiResponseModel.fromJson(
          jsonDecode(response.body),
        );
        return apiResponseModel;
      } else {
        throw HttpStatusCodeException(
          statusCode: response.statusCode,
          message: 'Status code is ${response.statusCode}',
        );
      }
    } on HttpStatusCodeException catch (e) {
      throw FetchWeatherForecastByCityException(
        message: e.toString(),
        statusCode: e.statusCode,
      );
    } catch (e) {
      throw FetchWeatherForecastByCityException(message: e.toString());
    }
  }
}
