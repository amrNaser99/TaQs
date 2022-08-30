import 'package:taQs/features/current_weather/data/local/models/weather.dart';
import 'package:taQs/features/next_days_forecast/data/models/temp.dart';

class Forecast {
  final int? dt;
  final Temp? temp;
  final double? pressure;
  final int? humidity;
  final List<Weather>? weather;
  final double? speed;
  final int? deg;
  final double? gust;
  final int? clouds;

  Forecast({
    this.dt,
    this.temp,
    this.pressure,
    this.humidity,
    this.weather,
    this.speed,
    this.deg,
    this.gust,
    this.clouds,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      dt: json['dt'] as int,
      temp: Temp.fromJson(json['temp'] as Map<String, dynamic>),
      pressure: json['pressure'] as double,
      humidity: json['humidity'] as int,
      weather: (json['weather'] as List<dynamic>)
          .map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
      speed: json['speed'] as double,
      deg: json['deg'] as int,
      gust: json['gust'] as double,
      clouds: json['clouds'] as int,
    );
  }
//

}
