class City {
  final int? geoname_id;
  final String? name;
  final double? lat;
  final double? lon;
  final String? country;
  final String? iso2;
  final String? type;
  final dynamic population;

  City({
    this.geoname_id,
    this.name,
    this.lat,
    this.lon,
    this.country,
    this.iso2,
    this.type,
    this.population,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      geoname_id:json["geoname_id"],
      name: json["name"],
      lat: json["lat"],
      lon: json["lon"],
      country: json["country"],
      iso2: json["iso2"],
      type: json["type"],
      population: json["population"],
    );
  }
//

}
