import 'package:dartz/dartz.dart';

import '../../exports.dart';

class ApiService {
  final dio = Dio();

  ApiService() {
    dio.options.baseUrl = "https://api.open-meteo.com/v1/";
    dio.options.connectTimeout = apiServiceTimeOut;
    dio.options.receiveTimeout = apiServiceTimeOut;
    dio.options.sendTimeout = apiServiceTimeOut;
    dio.interceptors.add(MyApp.alice.getDioInterceptor());
  }

  Future<Either<String, WeatherModel>> getWeather(Position current) async {
    try {
      final response = await dio.get(
        "forecast",
        queryParameters: {
          "latitude": current.latitude,
          "longitude": current.longitude,
          "current_weather": true,
        },
      );
      if (response.statusCode == 200) {
        return Right(WeatherModel.fromJson(response.data));
      } else {
        return Left(response.statusMessage ?? "Error response!");
      }
    } on DioException catch (e) {
      return Left(e.message ?? "Error");
    }
  }
}
