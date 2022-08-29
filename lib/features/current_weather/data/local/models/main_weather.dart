class MainWeather {
  final double? temp;
  final double? feels_like;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? humidity;

  MainWeather({
    this.temp,
    this.feels_like,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

  factory MainWeather.fromJson(Map<String, dynamic> json) {
    return MainWeather(
      temp: json['temp'],
      feels_like: json['feels_like'],
      tempMin: json['temp_min'],
      tempMax: json['temp_max'],
      pressure: json['pressure'],
      humidity: json['humidity'],
    );
  }
}