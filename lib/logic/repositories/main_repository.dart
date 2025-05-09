import 'package:dartz/dartz.dart';

import '../../exports.dart';

class MainRepository {
  final ApiService apiServices;

  MainRepository({required this.apiServices});

  Future<Either<String, WeatherModel>> getWeather(Position current) async {
    return apiServices.getWeather(current);
  }

}
