class Coord {
  final double? lat;
  final double? lng;
  Coord( {this.lat, this.lng});

  Map<String, dynamic> toJson() {
    return {
      "lat": this.lat,
      "lng": this.lng,
    };
  }

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: json["lat"] as double?,
      lng: json["lng"] as double?,
    );
  }


}