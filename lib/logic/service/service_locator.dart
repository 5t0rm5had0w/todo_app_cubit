import '../../../exports.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  ///Service
  locator.registerLazySingleton<ApiService>(() => ApiService());

  ///Repository
  locator.registerLazySingleton<MainRepository>(() => MainRepository(apiServices: locator()));

  ///Cubit
  // locator.registerFactory(() => TodoCubit());
  locator.registerFactory(() => TodoBloc());
  // locator.registerFactory(() => WeatherCubit(locator()));
  locator.registerFactory(() => WeatherBloc(locator()));
}
