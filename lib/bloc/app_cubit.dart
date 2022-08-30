import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:taQs/bloc/app_state.dart';
import 'package:taQs/core/constants.dart';
import 'package:taQs/core/end_point.dart';
import 'package:taQs/core/services/network/local/cache_helper.dart';
import 'package:taQs/core/services/network/remote/dio_helper.dart';
import 'package:taQs/features/current_weather/data/local/models/current_weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taQs/features/next_days_forecast/data/models/next_daily_forecast.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(TaqsInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  AnimationController? imgPermissionController;
  final AdvancedDrawerController advancedDrawerController =
      AdvancedDrawerController();

  CurrentWeather? currentWeather;

  Future<void> GetCurrentWeatherByQue() async {
    emit(TaqsGetCurrentWeatherLoadingState());
    DioHelper.getData(
      url: baseUrl + CURRENTWEATHER,
      query: {
        'q': 'zagazig',
        'lang': 'en',
        'appid': '2e9497eaa205d973a3c0d8a08107d55c',
      },
      token: apiKey,
    ).then((value) {
      debugPrint('value: ${value.data.toString()}');
      currentWeather = CurrentWeather.fromJson(value.data);
      debugPrint('currentWeather: ${currentWeather}');

      emit(TaqsGetCurrentWeatherSuccessState());
    }).catchError((error) {
      emit(TaqsGetCurrentWeatherErrorState(error));
    });
  }

  Position? position;
  String? positionLat;
  String? positionLong;

  //get weather api using lat and long

  // Future<void> GetCurrentWeatherByLatLng({

  //get weather api using lat and long

  //get weather api using city name

  // Future<void> GetCurrentWeatherByLatLng() async {

  // bool permissionsGranted = false;

  Future enableLocation() async {
    emit(TaqsEnableLocationLoadingState());

    checkGPSEnabled().then((value) {
      checkLocationPermission().then((value) {
        debugPrint('TaqsGetPositionLoadingState');
        emit(TaqsGetPositionLoadingState());
        getPosition().then((value) {
          debugPrint('TaqsGetPositionSuccessState');
          emit(TaqsGetPositionSuccessState());

          permissionsGranted = true;
          emit(TaqsEnableLocationSuccessState());
        }).catchError((error) {
          debugPrint(error.toString());
          emit(TaqsGetPositionErrorState(error));
        });
      }).catchError((error) {
        debugPrint('error: ${error}');
      });
    }).catchError((error) {
      debugPrint('error: ${error}');
    });
  }

  //   emit(TaqsGetCurrentWeatherByLatLngLoadingState());
  //   debugPrint('lat in GetCurrentWeatherByLatLng: ${positionLat} lon in GetCurrentWeatherByLatLng: ${positionLong}');
  //   DioHelper.getData(
  //     // url: baseU,
  //     url: baseUrl + CURRENTWEATHER,
  //     query: {
  //       'lat': {positionLat},
  //       'lon': {positionLong},
  //       // 'lang': 'en',
  //       'appid': apiKey,
  //     },
  //     token: apiKey,
  //   ).then((value) {
  //     debugPrint('value: ${value.data.toString()}');
  //     currentWeather = CurrentWeather.fromJson(value.data);
  //     debugPrint('currentWeather: ${currentWeather}');
  //
  //     emit(TaqsGetCurrentWeatherByLatLngSuccessState());
  //   }).catchError((error) {
  //     emit(TaqsGetCurrentWeatherByLatLngErrorState(error));
  //   });
  // }
// Future<void> GetCurrentWeatherByCityName(String cityName) async {
//     emit(TaqsGetCurrentWeatherLoadingState());
//     DioHelper.getData(
//       url: baseUrl + CURRENTWEATHER,
//       query: {
//         'q': cityName,
//         'lang': 'en',
//         'appid': '2e9497eaa205d973a3c0d8a08107d55c',
//       },
//       token: apiKey,
//     ).then((value) {
//       debugPrint('value: ${value.data.toString()}');
//       currentWeather = CurrentWeather.fromJson(value.data);
//       debugPrint('currentWeather: ${currentWeather}');
//
//       emit(TaqsGetCurrentWeatherSuccessState());
//     }).catchError((error) {
//       emit(TaqsGetCurrentWeatherErrorState(error));
//     });
//   }
  //   required dynamic lat,
  //   required dynamic lon,
  // }) async {
  //   emit(TaqsGetCurrentWeatherLoadingState());
  //   DioHelper.getData(
  //     url:
  //         'https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${apiKey}',
  //     token: apiKey,
  //   ).then((value) {
  //     debugPrint('value: ${value.data.toString()}');
  //     currentWeather = CurrentWeather.fromJson(value.data);
  //     debugPrint('currentWeather: ${currentWeather}');
  //
  //     emit(TaqsGetCurrentWeatherSuccessState());
  //   }).catchError((error) {
  //     emit(TaqsGetCurrentWeatherErrorState(error));
  //   });
  // }
  //   emit(TaqsGetCurrentWeatherLoadingState());
  //   DioHelper.getData(
  //     url: baseUrl + CURRENTWEATHER,
  //     query: {
  //       'lat': lat.toString(),
  //       'lon': long.toString(),
  //       'lang': 'en',
  //       'appid': '2e9497eaa205d973a3c0d8a08107d55c',
  //     },
  //     token: apiKey,
  //   ).then((value) {
  //     debugPrint('value: ${value.data.toString()}');
  //     currentWeather = CurrentWeather.fromJson(value.data);
  //     debugPrint('currentWeather: ${currentWeather}');
  //
  //     emit(TaqsGetCurrentWeatherSuccessState());
  //   }).catchError((error) {
  //     emit(TaqsGetCurrentWeatherErrorState(error));
  //   });
  // }
  //get current weather by location

  // Future<void> GetCurrentWeatherByLatLong(double lat, double long) async {

  Future checkGPSEnabled() async {
    bool serviceStatus = await Geolocator.isLocationServiceEnabled();

    if (serviceStatus) {
      print("GPS service is enabled");
    } else {
      print("GPS service is disabled.");
    }
  }

  Future checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      } else if (permission == LocationPermission.deniedForever) {
        print("'Location permissions are permanently denied");
      } else {
        print("GPS Location service is granted");
      }
    } else {
      permissionsGranted = true;
      CacheHelper.saveData(key: 'permissionsGranted', value: permissionsGranted)
          .then((value) {
        debugPrint('permissionsGranted saved in cache Successfully');
      }).catchError((error) {
        debugPrint('permissionsGranted saved in cache Successfully');
      });
      debugPrint('permissionsGranted became true ');

      print("GPS Location permission granted.");
    }
  }

  Future<bool> checkInterNetConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      print('YAY! Free cute dog pics!');
    } else {
      print('No internet :( Reason: $result');
    }
    return result;
  }

  Future<void> getPosition() async {
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then((value) {
      debugPrint('position: ${value}');
      positionLat = value.latitude.toString();
      positionLong = value.longitude.toString();
      debugPrint('positionLat: ${value.latitude.toString()}');
      debugPrint('positionLong: ${value.longitude.toString()}');
      CacheHelper.saveData(key: 'positionLat', value: positionLat)
          .then((value) {
        debugPrint('positionLat ${positionLat} saved in cache Successfully');
      }).catchError((error) {
        debugPrint('positionLong Failed to save in cache : ${error}');
      });
      CacheHelper.saveData(key: 'positionLong', value: positionLong)
          .then((value) {
        debugPrint('positionLong ${positionLong} saved in cache Successfully');
      }).catchError((error) {
        debugPrint('positionLong Failed to save in cache : ${error}');
      });
      emit(TaqsGetPositionSuccessState());
    }).catchError((error) {
      emit(TaqsGetPositionErrorState(error));
    });
  }

  Future<void> GetCurrentWeatherByLatLng() async {
    emit(TaqsGetCurrentWeatherLoadingState());
    Position? position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    debugPrint('position: ${position}');
    CacheHelper.saveData(
        key: 'positionLat', value: position.latitude.toString());
    CacheHelper.saveData(
        key: 'positionLong', value: position.longitude.toString());
    DioHelper.getData(
      url: baseUrl + CURRENTWEATHER,
      query: {
        'lat': position.latitude.toString(),
        'lon': position.longitude.toString(),
        'lang': 'en',
        'appid': '2e9497eaa205d973a3c0d8a08107d55c',
      },
      token: apiKey,
    ).then((value) {
      debugPrint('value: ${value.data.toString()}');
      currentWeather = CurrentWeather.fromJson(value.data);
      debugPrint('currentWeather: ${currentWeather}');

      emit(TaqsGetCurrentWeatherSuccessState());
    }).catchError((error) {
      emit(TaqsGetCurrentWeatherErrorState(error));
    });
  }

  NextDailyForecast? nextDailyForecast;

  Future<void> GetNextFiveDaysWeatherByLatLng() async {
    emit(TaqsGetNextFiveDaysWeatherByLatLngLoadingState());
    DioHelper.getData(
      url: baseUrl + NEXT5DAYS,
      query: {
        'lat': positionLat,
        'lon': positionLong,
        'cnt': '7',
        'appid': apiKey,
      },
      token: apiKey,
    ).then((value) {
      nextDailyForecast = NextDailyForecast.fromJson(value.data);
      debugPrint('nextDailyForecast: ${nextDailyForecast}');
      emit(TaqsGetNextFiveDaysWeatherByLatLngSuccessState());
    }).catchError((error) {
      emit(TaqsGetNextFiveDaysWeatherByLatLngErrorState(error));
    });
  }

}
