class Wind {
  final dynamic speed;
  final dynamic deg;

  Wind({
    this.speed,
    this.deg,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    speed: json['speed'],
    deg: json['deg'],
  );

  Map<String, dynamic> toJson() => {
    'speed': speed,
    'deg': deg,
  };
}
