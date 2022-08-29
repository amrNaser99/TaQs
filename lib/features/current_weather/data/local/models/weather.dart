class Weather {
  final int? id;
  final String? main;
  final String? description;
  final dynamic icon;

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json["id"] as int?,
      main: json["main"]  as String?,
      description: json["description"] as String?,
      icon: json["icon"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "main": this.main,
      "description": this.description,
      "icon": this.icon,
    };
  }



}
