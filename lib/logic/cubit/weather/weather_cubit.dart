import '../../../exports.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final MainRepository _mainRepository;

  WeatherCubit(this._mainRepository) : super(WeatherState());

  Future<void> getWeather() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final response = await _mainRepository.getWeather();
    response.fold((failure) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, errorMessage: failure));
      emit(state.copyWith(status: FormzSubmissionStatus.initial));
    }, (data) {
      emit(state.copyWith(status: FormzSubmissionStatus.success, weather: data));
    });
  }
}
