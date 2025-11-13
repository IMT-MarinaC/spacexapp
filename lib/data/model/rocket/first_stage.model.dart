class FirstStage {
  final int engines;
  final int burnTimeSec;
  final double fuelAmountTons;
  final bool reusable;

  FirstStage({
    required this.engines,
    required this.burnTimeSec,
    required this.fuelAmountTons,
    required this.reusable,
  });

  factory FirstStage.fromJson(Map<String, dynamic> json) => FirstStage(
    engines: json['engines'] ?? 0,
    burnTimeSec: json['burn_time_sec'] ?? 0,
    fuelAmountTons: json['fuel_amount_tons'].toDouble() ?? 0,
    reusable: json['reusable'] ?? false,
  );
}
