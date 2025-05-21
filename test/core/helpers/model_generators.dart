import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/features/weather/data/models/api_response_model.dart';
import 'package:weather_app/features/weather/presentation/models/weather_view_model.dart';

import '../../fixtures/fixture_reader.dart';
import 'entity_generators.dart';

http.Response createTestApiResponseSuccess() =>
    http.Response(fixture('api_response_success.json'), 200);

http.Response createTestApiResponseCityNotFound() =>
    http.Response(fixture('api_response_city_not_found.json'), 404);

ApiResponseModel createTestApiResponseModel() =>
    ApiResponseModel.fromJson(jsonDecode(fixture('api_response_success.json')));

List<WeatherViewModel> createTestWeatherViewModelList() {
  final weatherEntityList = createTestDailyWeatherList();
  return weatherEntityList.map((e) => WeatherViewModel.fromEntry(e)).toList();
}
