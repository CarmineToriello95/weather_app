// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import 'di_config.dart' as _i9;
import 'features/weather/data/datasources/weather_forecast_remote_data_source.dart'
    as _i4;
import 'features/weather/data/repositories/weather_forecast_repository_impl.dart'
    as _i6;
import 'features/weather/domain/repositories/weather_forecast_repository.dart'
    as _i5;
import 'features/weather/domain/usecases/fetch_weather_forecast_by_city_usecase.dart'
    as _i7;
import 'features/weather/presentation/bloc/weather_bloc.dart' as _i8;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i3.Client>(() => registerModule.client);
    gh.factory<_i4.WeatherForecastRemoteDataSource>(
        () => _i4.WeatherForecastRemoteDataSourceImpl(gh<_i3.Client>()));
    gh.factory<_i5.WeatherForecastRepository>(() =>
        _i6.WeatherForecastRepositoryImpl(
            gh<_i4.WeatherForecastRemoteDataSource>()));
    gh.factory<_i7.FetchWeatherForecastByCityUsecase>(() =>
        _i7.FetchWeatherForecastByCityUsecase(
            gh<_i5.WeatherForecastRepository>()));
    gh.factory<_i8.WeatherBloc>(
        () => _i8.WeatherBloc(gh<_i7.FetchWeatherForecastByCityUsecase>()));
    return this;
  }
}

class _$RegisterModule extends _i9.RegisterModule {}
