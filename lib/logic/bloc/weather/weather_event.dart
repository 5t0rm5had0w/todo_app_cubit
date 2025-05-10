part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class GetWeatherEvent extends WeatherEvent {
  @override
  List<Object?> get props => [];
}
