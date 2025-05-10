part of 'weather_bloc.dart';

@immutable
class WeatherState extends Equatable {
  final FormzSubmissionStatus status;
  final WeatherModel? weather;
  final String errorMessage;

  const WeatherState({
    this.status = FormzSubmissionStatus.initial,
    this.weather,
    this.errorMessage = "",
  });

  WeatherState copyWith({
    FormzSubmissionStatus? status,
    WeatherModel? weather,
    String? errorMessage,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, weather, errorMessage];
}
