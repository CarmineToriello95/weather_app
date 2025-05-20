import 'package:weather_app/features/weather/data/models/api_response_model.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_item/weather_forecast_item_model.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';

List<WeatherEntity> createTestDailyWeatherListFromApiResponseModel(
  ApiResponseModel apiResponseModel,
) {
  final List<WeatherForecastItemModel> threeHourlyWeatherList =
      apiResponseModel.list;

  final dailyWeatherList = <WeatherForecastItemModel>[];

  for (int i = 0; i < threeHourlyWeatherList.length; i += 8) {
    dailyWeatherList.add(threeHourlyWeatherList[i]);
  }

  final dailyWeatherEntityList =
      dailyWeatherList
          .map((e) => e.toEntity(city: apiResponseModel.city.name))
          .toList();
  return dailyWeatherEntityList;
}

List<WeatherEntity> createTestDailyWeatherList() => [
  WeatherEntity(
    id: 1,
    date: DateTime.now(),
    weatherCondition: 'Clouds',
    smallIconPath: 'smallIconPath',
    largeIconPath: 'largeIconPath',
    temp: 10,
    tempMax: 11,
    tempMin: 9,
    humidity: 20,
    pressure: 10,
    wind: 3,
    city: 'Berlin',
  ),
  WeatherEntity(
    id: 2,
    date: DateTime.now(),
    weatherCondition: 'Clouds',
    smallIconPath: 'smallIconPath',
    largeIconPath: 'largeIconPath',
    temp: 10,
    tempMax: 11,
    tempMin: 9,
    humidity: 20,
    pressure: 10,
    wind: 3,
    city: 'Berlin',
  ),
];
