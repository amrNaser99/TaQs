class Sys {
  final int? type;
  final int? id;
  final String? country;
  final int? sunrise;
  final int? sunset;
  Sys({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });
  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        type: json["type"] as int?,
        id: json["id"] as int?,
        country: json["country"] as String?,
        sunrise: json["sunrise"] as int?,
        sunset: json["sunset"] as int?,
      );
  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "country": country,
        "sunrise": sunrise,
        "sunset": sunset,
      };
}