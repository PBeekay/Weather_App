import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        WeatherFactory wf = WeatherFactory("487dc3d34148d77033ca1204468a6ad7", language: Language.ENGLISH);

        // Eskişehir'in koordinatları: 39.7669° N, 30.5256° E
        double eskisehirLatitude = 39.7669;
        double eskisehirLongitude = 30.5256;

        Weather weather = await wf.currentWeatherByLocation(
          eskisehirLatitude,
          eskisehirLongitude,
        );
        print(weather);
        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}

