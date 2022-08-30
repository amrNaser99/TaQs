abstract class AppState {}

class TaqsInitState extends AppState {}

class TaqsGetCurrentWeatherLoadingState extends AppState {}

class TaqsGetCurrentWeatherSuccessState extends AppState {}

class TaqsGetCurrentWeatherErrorState extends AppState {
  final String error;

  TaqsGetCurrentWeatherErrorState(this.error);
}

class TaqsGetCurrentWeatherByLatLngLoadingState extends AppState {}

class TaqsGetCurrentWeatherByLatLngSuccessState extends AppState {}

class TaqsGetCurrentWeatherByLatLngErrorState extends AppState {
  final String error;

  TaqsGetCurrentWeatherByLatLngErrorState(this.error);
}

class TaqsGetPositionLoadingState extends AppState {}

class TaqsGetPositionSuccessState extends AppState {}

class TaqsGetPositionErrorState extends AppState {
  final String error;

  TaqsGetPositionErrorState(this.error);
}

class TaqsEnableLocationLoadingState extends AppState {}

class TaqsEnableLocationSuccessState extends AppState {}

class TaqsEnableLocationErrorState extends AppState {
  final String error;

  TaqsEnableLocationErrorState(this.error);
}

class TaqsGetCacheDataLoadingState extends AppState {}

class TaqsGetCacheDataSuccessState extends AppState {}

class TaqsGetCacheDataErrorState extends AppState {
  final String error;

  TaqsGetCacheDataErrorState(this.error);
}
class TaqsGetNextFiveDaysWeatherByLatLngLoadingState extends AppState {}

class TaqsGetNextFiveDaysWeatherByLatLngSuccessState extends AppState {}

class TaqsGetNextFiveDaysWeatherByLatLngErrorState extends AppState {
  final String error;

  TaqsGetNextFiveDaysWeatherByLatLngErrorState(this.error);
}
