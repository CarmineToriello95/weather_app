import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/errors/weather_forecast/failure_messages.dart';
import 'package:weather_app/core/errors/weather_forecast/weather_forecast_failures.dart';
import 'package:weather_app/di_config.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc_event.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc_state.dart';
import 'package:weather_app/features/weather/presentation/widgets/city_search_dialog.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_error_state_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_loading_state_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_populated_widget/weather_page_populated_state_widget.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late final WeatherBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt.get<WeatherBloc>();
    _bloc.add(WeatherBlocFetchWeatherByCityEvent(city: 'Berlin'));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.blue.shade100,
    floatingActionButton: FloatingActionButton(
      onPressed: _onSearchCityPressed,
      child: Icon(Icons.search),
    ),
    body: SafeArea(
      child: BlocBuilder<WeatherBloc, WeatherBlocState>(
        bloc: _bloc,
        builder: (_, state) {
          if (state is WeatherBlocPopulatedState) {
            return WeatherPagePopulatedStateWidget(
              state: state,
              onSelectedWeatherDay:
                  (selectedWeather) => _bloc.add(
                    WeatherBlocWeatherDaySelectedEvent(
                      weatherViewModel: selectedWeather,
                    ),
                  ),
              onSelectedUnit:
                  (selectedTemperatureUnit) => _bloc.add(
                    WeatherBlocTemperatureUnitChangedEvent(
                      temperatureUnit: selectedTemperatureUnit,
                    ),
                  ),
              onRefresh:
                  () async => _bloc.add(
                    WeatherBlocFetchWeatherByCityEvent(city: state.cityName),
                  ),
            );
          }
          if (state is WeatherBlocErrorState) {
            if (state.failure is FetchWeatherForecastCityNotFoundFailure) {
              return WeatherPageErrorStateWidget(
                errorMessage: FailureMessages.cityNotFoundError,
                buttonText: 'Search',
                onButtonPressed: _onSearchCityPressed,
              );
            } else {
              return WeatherPageErrorStateWidget(
                errorMessage: FailureMessages.genericError,
                buttonText: 'Retry',
                onButtonPressed:
                    () => _bloc.add(
                      WeatherBlocFetchWeatherByCityEvent(city: state.cityName),
                    ),
              );
            }
          }
          return WeatherPageLoadingStateWidget();
        },
      ),
    ),
  );

  void _onSearchCityPressed() async {
    final cityName = await showDialog<String>(
      context: context,
      builder: (context) => CitySearchDialog(),
    );
    if (cityName != null && cityName.isNotEmpty) {
      _bloc.add(WeatherBlocFetchWeatherByCityEvent(city: cityName));
    }
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
