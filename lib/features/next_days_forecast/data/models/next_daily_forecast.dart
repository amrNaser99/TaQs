import 'package:taQs/features/next_days_forecast/data/models/city_model.dart';
import 'package:taQs/features/next_days_forecast/data/models/forcast.dart';

class NextDailyForecast {
  final String? cod;
  final int? message;
  final int? cnt;
  final City? city;
  final List<Forecast>? forecastList;

  NextDailyForecast({
    this.cod,
    this.message,
    this.cnt,
    this.city,
    this.forecastList,
  });

  factory NextDailyForecast.fromJson(Map<String, dynamic> json) {
    return NextDailyForecast(
      cod: json['cod'] as String,
      message: json['message'] as int,
      cnt: json['cnt'] as int,
      city: City.fromJson(json['city'] as Map<String, dynamic>),
      forecastList: (json['list'] as List<dynamic>)
          .map((e) => Forecast.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
