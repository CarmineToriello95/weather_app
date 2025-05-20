import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/extensions/etiher_extension.dart';
import 'package:weather_app/core/utils/enums/temperature_unit.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/domain/usecases/fetch_weather_forecast_by_city_usecase.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc_event.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc_state.dart';
import 'package:weather_app/features/weather/presentation/models/weather_view_model.dart';

@injectable
class WeatherBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  final FetchWeatherForecastByCityUsecase _fetchWeatherForecastByCityUsecase;
  WeatherBloc(this._fetchWeatherForecastByCityUsecase)
    : super(WeatherBlocInitialState()) {
    on<WeatherBlocFetchWeatherByCityEvent>(
      _onWeatherBlocFetchWeatherByCityEvent,
    );
    on<WeatherBlocWeatherDaySelectedEvent>(
      _onWeatherBlocWeatherDaySelectedEvent,
    );
    on<WeatherBlocTemperatureUnitChangedEvent>(
      _onWeatherBlocTemperatureUnitChangedEvent,
    );
  }

  void _onWeatherBlocFetchWeatherByCityEvent(
    WeatherBlocFetchWeatherByCityEvent event,
    Emitter<WeatherBlocState> emit,
  ) async {
    emit(WeatherBlocLoadingState());

    final result = await _fetchWeatherForecastByCityUsecase.call(
      params: event.city,
    );

    /// If calling the usecase for fetching the weather forecast is successful
    if (result.isRight()) {
      final List<WeatherEntity> dailyWeatherList = result.asRight();

      emit(
        WeatherBlocPopulatedState(
          selectedWeatherDay: WeatherViewModel.fromEntry(
            dailyWeatherList.first,
          ),
          dailyWeatherList:
              dailyWeatherList
                  .map((e) => WeatherViewModel.fromEntry(e))
                  .toList(),
          selectedTemperatureUnit: TemperatureUnit.celsius,
          cityName: dailyWeatherList.first.city,
        ),
      );
    } else {
      emit(
        WeatherBlocErrorState(failure: result.asLeft(), cityName: event.city),
      );
    }
  }

  void _onWeatherBlocWeatherDaySelectedEvent(
    WeatherBlocWeatherDaySelectedEvent event,
    Emitter<WeatherBlocState> emit,
  ) {
    if (state is WeatherBlocPopulatedState) {
      final populatedState = state as WeatherBlocPopulatedState;
      emit(populatedState.copyWith(selectedWeatherDay: event.weatherViewModel));
    }
  }

  void _onWeatherBlocTemperatureUnitChangedEvent(
    WeatherBlocTemperatureUnitChangedEvent event,
    Emitter<WeatherBlocState> emit,
  ) {
    if (state is WeatherBlocPopulatedState) {
      final populatedState = state as WeatherBlocPopulatedState;
      emit(
        populatedState.copyWith(selectedTemperatureUnit: event.temperatureUnit),
      );
    }
  }
}
