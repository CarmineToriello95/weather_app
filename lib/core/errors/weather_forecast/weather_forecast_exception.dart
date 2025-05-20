class FetchWeatherForecastByCityException implements Exception {
  final int? statusCode;
  final String message;

  FetchWeatherForecastByCityException({required this.message, this.statusCode});
}
