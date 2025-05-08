import 'package:dartz/dartz.dart';

import '../../exports.dart';

class MainRepository {
  final ApiService apiServices;

  MainRepository({required this.apiServices});

  Future<Either<String, WeatherModel>> getWeather() async {
    return apiServices.getWeather();
  }

}
