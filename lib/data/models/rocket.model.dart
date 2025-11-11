class Rocket {
  const Rocket({
    required this.name,
    required this.height,
    required this.diameter,
    required this.mass,
    required this.engineType
  });

  final String name;
  final double height;
  final double diameter;
  final int mass;
  final String engineType;

  static Rocket mock()=>Rocket(
    name: "Falcon Heavy",
    height: 70,
    diameter: 12.2,
    mass: 1420788,
    engineType: "merlin"
  );

  factory Rocket.fromJson(Map<String, dynamic> json) {
    return Rocket(
        name: json["name"],
        height: json["height"]["meters"],
        diameter: json["diameter"]["meters"],
        mass: json["mass"]["kg"],
        engineType: json["engines"]["type"],
    );
  }
}