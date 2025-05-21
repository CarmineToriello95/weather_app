import 'package:flutter/material.dart';
import 'package:weather_app/core/utils/enums/temperature_unit.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc_state.dart';
import 'package:weather_app/features/weather/presentation/models/weather_view_model.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_populated_widget/horizontal_layout_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_populated_widget/vertical_layout_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_populated_widget/weather_header_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_populated_widget/weather_image_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_populated_widget/weather_metrics_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_page_populated_widget/weather_tile_widget.dart';

class WeatherPagePopulatedStateWidget extends StatelessWidget {
  final WeatherBlocPopulatedState state;
  final void Function(WeatherViewModel) onSelectedWeatherDay;
  final void Function(TemperatureUnit) onSelectedUnit;
  final RefreshCallback onRefresh;
  const WeatherPagePopulatedStateWidget({
    super.key,
    required this.state,
    required this.onSelectedWeatherDay,
    required this.onSelectedUnit,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final titleWidget = Text(
      state.selectedWeatherDay.longDayFormat,
      style: TextStyle(fontSize: 24.0),
    );
    final headerWidget = WeatherHeaderWidget(
      weatherCondition: state.selectedWeatherDay.weatherCondition,
      selectedTemperatureUnit: state.selectedTemperatureUnit,
      onSelectedTemperatureUnit: onSelectedUnit,
    );

    final imageWidget = WeatherImageWidget(
      imagePath: state.selectedWeatherDay.largeIconPath,
    );

    final metricsWidget = WeatherMetricsWidget(
      temperature: state.selectedWeatherDay.formattedTemperature(
        state.selectedTemperatureUnit,
      ),
      pressure: state.selectedWeatherDay.pressureWithUnit,
      humidity: state.selectedWeatherDay.humidityWithPercentage,
      wind: state.selectedWeatherDay.windWithUnit,
      cityName: state.cityName,
    );
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              MediaQuery.of(context).orientation == Orientation.landscape
                  ? HorizontalLayoutWidget(
                    titleWidget: titleWidget,
                    headerWidget: headerWidget,
                    imageWidget: imageWidget,
                    metricsWidget: metricsWidget,
                  )
                  : VerticalLayoutWidget(
                    titleWidget: titleWidget,
                    headerWidget: headerWidget,
                    imageWidget: imageWidget,
                    metricsWidget: metricsWidget,
                  ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.dailyWeatherList.length,
                  itemBuilder: (_, i) {
                    final weatherViewModel = state.dailyWeatherList[i];
                    return WeatherTileWidget(
                      day: weatherViewModel.shortDayFormat,
                      temperatureRange: weatherViewModel.formattedTempRange(
                        state.selectedTemperatureUnit,
                      ),
                      imagePath: weatherViewModel.smallIconPath,
                      isSelected:
                          weatherViewModel.id == state.selectedWeatherDay.id,
                      onTap: () => onSelectedWeatherDay(weatherViewModel),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
