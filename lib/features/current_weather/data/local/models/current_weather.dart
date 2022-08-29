import 'package:taQs/features/current_weather/data/local/models/clouds.dart';
import 'package:taQs/features/current_weather/data/local/models/coord.dart';
import 'package:taQs/features/current_weather/data/local/models/main_weather.dart';
import 'package:taQs/features/current_weather/data/local/models/sys.dart';
import 'package:taQs/features/current_weather/data/local/models/weather.dart';
import 'package:taQs/features/current_weather/data/local/models/wind.dart';

class CurrentWeather {
  final Coord? coord;
  final List<Weather>? weather;
  final String? base;
  final MainWeather? main;
  final int? visibility;
  final Wind? wind;
  final Clouds? clouds;
  final int? dt;
  final Sys? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  CurrentWeather({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      coord: json['coord'] != null ? Coord.fromJson(json['coord']) : null,
      weather: json['weather'] != null
          ? (json['weather'] as List<dynamic>)
              .map((e) => Weather.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      base: json['base'],
      main: json['main'] != null ? MainWeather.fromJson(json['main']) : null,
      visibility: json['visibility'],
      wind: json['wind'] != null ? Wind.fromJson(json['wind']) : null,
      clouds: json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null,
      dt: json['dt'],
      sys: json['sys'] != null ? Sys.fromJson(json['sys']) : null,
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }
}
