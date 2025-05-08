// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      WeatherUnits.fromJson(
          json['current_weather_units'] as Map<String, dynamic>),
      CurrentWeather.fromJson(json['current_weather'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'current_weather_units': instance.current_weather_units,
      'current_weather': instance.current_weather,
    };

WeatherUnits _$WeatherUnitsFromJson(Map<String, dynamic> json) => WeatherUnits(
      json['time'] as String,
      json['temperature'] as String,
      json['windspeed'] as String,
    );

Map<String, dynamic> _$WeatherUnitsToJson(WeatherUnits instance) =>
    <String, dynamic>{
      'time': instance.time,
      'temperature': instance.temperature,
      'windspeed': instance.windspeed,
    };

CurrentWeather _$CurrentWeatherFromJson(Map<String, dynamic> json) =>
    CurrentWeather(
      json['time'] as String,
      (json['temperature'] as num).toDouble(),
      (json['windspeed'] as num).toDouble(),
    );

Map<String, dynamic> _$CurrentWeatherToJson(CurrentWeather instance) =>
    <String, dynamic>{
      'time': instance.time,
      'temperature': instance.temperature,
      'windspeed': instance.windspeed,
    };
