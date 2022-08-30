class Temp {
  final double? day;
  final double? min;
  final double? max;
  final double? night;
  final double? eve;
  final double? morn;

  Temp({
    this.day,
    this.min,
    this.max,
    this.night,
    this.eve,
    this.morn,
  });

  factory Temp.fromJson(Map<String, dynamic> json) {
    return Temp(
      day: json['day'] as double,
      min: json['min'] as double,
      max: json['max'] as double,
      night: json['night'] as double,
      eve: json['eve'] as double,
      morn: json['morn'] as double,
    );
  }
}
