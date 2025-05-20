import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/utils/api_utils.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_item/weather_forecast_item_model.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';

void main() {
  group('$WeatherForecastItemModel', () {
    final String tWeatherForecastItemModelJsonFormat = jsonEncode({
      "dt": 1747699200,
      "main": {
        "temp": 285.76,
        "feels_like": 285.3,
        "temp_min": 285.01,
        "temp_max": 285.76,
        "pressure": 1018,
        "sea_level": 1018,
        "grnd_level": 1013,
        "humidity": 85,
        "temp_kf": 0.75,
      },
      "weather": [
        {
          "id": 804,
          "main": "Clouds",
          "description": "overcast clouds",
          "icon": "04n",
        },
      ],
      "clouds": {"all": 85},
      "wind": {"speed": 0.78, "deg": 356, "gust": 0.84},
      "visibility": 10000,
      "pop": 0,
      "sys": {"pod": "n"},
      "dt_txt": "2025-05-20 00:00:00",
    });

    final WeatherEntity tWeatherEntity = WeatherEntity(
      id: 1747699200,
      date: DateTime.parse('2025-05-20 00:00:00'),
      weatherCondition: 'overcast clouds',
      smallIconPath:
          Uri.https(
            ApiUtils.iconApiAuthority,
            '${ApiUtils.weatherIconPath}04n${ApiUtils.weatherIconExtension2x}',
          ).toString(),
      largeIconPath:
          Uri.https(
            ApiUtils.iconApiAuthority,
            '${ApiUtils.weatherIconPath}04n${ApiUtils.weatherIconExtension4x}',
          ).toString(),
      temp: 285.76,
      tempMax: 285.76,
      tempMin: 285.01,
      humidity: 85,
      pressure: 1018,
      wind: 0.78,
      city: 'Berlin',
    );
    test(
      'WHEN the method toEntity is called THEN return a $WeatherEntity with correct data',
      () {
        /// arrange
        final WeatherForecastItemModel tWeatherForecastItemModel =
            WeatherForecastItemModel.fromJson(
              jsonDecode(tWeatherForecastItemModelJsonFormat),
            );

        /// act
        final result = tWeatherForecastItemModel.toEntity(city: 'Berlin');

        /// assert
        expect(result, tWeatherEntity);
      },
    );
  });
}
