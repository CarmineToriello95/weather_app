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
