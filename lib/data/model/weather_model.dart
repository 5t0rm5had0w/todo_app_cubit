import '../../exports.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  final double latitude;
  final double longitude;
  final WeatherUnits current_weather_units;
  final CurrentWeather current_weather;

  WeatherModel(this.latitude, this.longitude,this.current_weather_units, this.current_weather);

  factory WeatherModel.fromJson(Map<String, dynamic> json) => _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}

@JsonSerializable()
class WeatherUnits {
  final String time;
  final String temperature;
  final String windspeed;

  WeatherUnits(this.time, this.temperature, this.windspeed);

  factory WeatherUnits.fromJson(Map<String, dynamic> json) => _$WeatherUnitsFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherUnitsToJson(this);
}

@JsonSerializable()
class CurrentWeather {
  final String time;
  final double temperature;
  final double windspeed;

  CurrentWeather(this.time, this.temperature, this.windspeed);

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => _$CurrentWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWeatherToJson(this);
}
