import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/errors/failure.dart';
import 'package:weather_app/core/errors/weather_forecast/failure_messages.dart';
import 'package:weather_app/core/errors/weather_forecast/weather_forecast_exception.dart';
import 'package:weather_app/core/errors/weather_forecast/weather_forecast_failures.dart';
import 'package:weather_app/features/weather/data/datasources/weather_forecast_remote_data_source.dart';
import 'package:weather_app/features/weather/data/models/api_response_model.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_item/weather_forecast_item_model.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_forecast_repository.dart';

@Injectable(as: WeatherForecastRepository)
class WeatherForecastRepositoryImpl implements WeatherForecastRepository {
  final WeatherForecastRemoteDataSource _remoteDataSource;

  WeatherForecastRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<WeatherEntity>>> fetchWeatherForecastByCity({
    required String cityName,
  }) async {
    try {
      final ApiResponseModel apiResponseModel = await _remoteDataSource
          .fetchWeatherForecastByCity(cityName: cityName);

      /// The list received by the api contains a list of 40 items,
      /// providing weather forecast data in 3-hour intervals for the next 5 days.
      /// https://openweathermap.org/forecast5
      ///
      /// Example of date and time corresponding to items in the list at a certain index:
      /// threeHourlyWeatherList[0] = 2025-05-20 21:00:00
      /// threeHourlyWeatherList[8] = 2025-05-21 21:00:00
      /// threeHourlyWeatherList[16] = 2025-05-22 21:00:00
      /// threeHourlyWeatherList[24] = 2025-05-23 21:00:00
      /// threeHourlyWeatherList[32] = 2025-05-24 21:00:00
      /// threeHourlyWeatherList[39] = 2025-05-25 18:00:00
      final List<WeatherForecastItemModel> threeHourlyWeatherList =
          apiResponseModel.list;

      /// In this application, the daily weather is extracted by selecting
      /// one weather forecast entry per day at the same time of day.
      /// This approach ensures consistency across days.
      /// Taking the above example, the following list will contain the elements at
      /// position [0,8,16,24,32].
      final List<WeatherForecastItemModel> dailyWeatherList =
          <WeatherForecastItemModel>[];

      /// Take the elements at index [0,8,16,24,32],
      /// selecting one weather forecast entry per day at the same time of day.
      /// Please check the example above to have an idea of what the list will contain
      for (int i = 0; i < threeHourlyWeatherList.length; i += 8) {
        dailyWeatherList.add(threeHourlyWeatherList[i]);
      }

      final List<WeatherEntity> weatherEntityList =
          dailyWeatherList
              .map((e) => e.toEntity(city: apiResponseModel.city.name))
              .toList();

      return Right(weatherEntityList);
    } on FetchWeatherForecastByCityException catch (e) {
      if (e.statusCode == 404) {
        return Left(
          FetchWeatherForecastCityNotFoundFailure(
            FailureMessages.cityNotFoundError,
          ),
        );
      } else {
        return Left(FetchWeatherForecastGenericFailure(e.toString()));
      }
    } catch (e) {
      return Left(FetchWeatherForecastGenericFailure(e.toString()));
    }
  }
}
