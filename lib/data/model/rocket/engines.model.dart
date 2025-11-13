class Engines {
  final int number;
  final String type;
  final String version;
  final String layout;
  final int engineLossMax;
  final String propellant1;
  final String propellant2;

  Engines({
    required this.number,
    required this.type,
    required this.version,
    required this.layout,
    required this.engineLossMax,
    required this.propellant1,
    required this.propellant2,
  });

  factory Engines.fromJson(Map<String, dynamic> json) => Engines(
    number: json['number'] ?? 0,
    type: json['type'] ?? '',
    version: json['version'] ?? '',
    layout: json['layout'] ?? '',
    engineLossMax: json['engine_loss_max'] ?? 0,
    propellant1: json['propellant_1'] ?? '',
    propellant2: json['propellant_2'] ?? '',
  );
}
