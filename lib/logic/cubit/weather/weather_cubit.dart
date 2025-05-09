import '../../../exports.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final MainRepository _mainRepository;

  WeatherCubit(this._mainRepository) : super(WeatherState());

  Future<void> getWeather() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    var data = await _determinePosition();
    print(data);
    final response = await _mainRepository.getWeather(data);
    response.fold((failure) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, errorMessage: failure));
      emit(state.copyWith(status: FormzSubmissionStatus.initial));
    }, (data) {
      emit(state.copyWith(status: FormzSubmissionStatus.success, weather: data));
    });
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}