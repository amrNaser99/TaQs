import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:taQs/bloc/app_state.dart';
import 'package:taQs/core/end_point.dart';
import 'package:taQs/core/services/network/local/cache_helper.dart';
import 'package:taQs/core/services/network/remote/dio_helper.dart';
import 'package:taQs/features/current_weather/data/local/models/current_weather.dart';
import 'package:geolocator/geolocator.dart';

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
      url: baseUrl+CURRENTWEATHER,
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

  //get weather api using lat and long
  Future<void> GetCurrentWeatherByLatLong(double lat, double long) async {
    emit(TaqsGetCurrentWeatherLoadingState());
    DioHelper.getData(
      url: baseUrl+CURRENTWEATHER,
      query: {
        'lat': lat.toString(),
        'lon': long.toString(),
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

  // Future<void> GetCurrentWeatherByLatLng({
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

  Future<void> GetCurrentWeatherByLatLng({
    required dynamic lat,
    required dynamic lon,
  }) async {
    emit(TaqsGetCurrentWeatherByLatLngLoadingState());
    DioHelper.getData(
      url: baseUrl+CURRENTWEATHER,
      query: {
        'lat': {lat}.toString(),
        'lon': {lon}.toString(),
        'lang': 'en',
        'appid': '2e9497eaa205d973a3c0d8a08107d55c',
      },
      token: apiKey,
    ).then((value) {
      debugPrint('value: ${value.data.toString()}');
      currentWeather = CurrentWeather.fromJson(value.data);
      debugPrint('currentWeather: ${currentWeather}');

      emit(TaqsGetCurrentWeatherByLatLngSuccessState());
    }).catchError((error) {
      emit(TaqsGetCurrentWeatherByLatLngErrorState(error));
    });
  }

  Position? position;

  Future enableLocation() async {
    emit(TaqsEnableLocationLoadingState());

    checkGPSEnabled().then((value) {
      checkLocationPermission().then((value) {
        debugPrint('TaqsGetPositionLoadingState');
        emit(TaqsGetPositionLoadingState());
        getPosition().then((value) {
          debugPrint('TaqsGetPositionSuccessState');
          emit(TaqsGetPositionSuccessState());

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

  bool permissionsGranted = false;
  bool once = true;

  Future getCacheData() async {
    emit(TaqsGetCacheDataLoadingState());
    if (once == false) {
      permissionsGranted = await CacheHelper.getData(key: 'permissionsGranted');
      debugPrint('permissionsGranted: ${permissionsGranted.toString()}');
    } else {
      once = false;
    }
    emit(TaqsGetCacheDataSuccessState());
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
      // lon = value.longitude;
      // lat = value.latitude;
      debugPrint('position: ${value}');
      // debugPrint('lat: ${lat}');
      // debugPrint('lon: ${lon}');
      emit(TaqsEnableLocationSuccessState());
    }).catchError((error) {
      emit(TaqsEnableLocationErrorState(error));
    });
  }

}
