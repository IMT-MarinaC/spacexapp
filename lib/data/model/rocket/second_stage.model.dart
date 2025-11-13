class SecondStage {
  final int engines;
  final int burnTimeSec;
  final double fuelAmountTons;
  final bool reusable;

  SecondStage({
    required this.engines,
    required this.burnTimeSec,
    required this.fuelAmountTons,
    required this.reusable,
  });

  factory SecondStage.fromJson(Map<String, dynamic> json) => SecondStage(
    engines: json['engines'] ?? 0,
    burnTimeSec: json['burn_time_sec'] ?? 0,
    fuelAmountTons: json['fuel_amount_tons'].toDouble() ?? 0,
    reusable: json['reusable'] ?? false,
  );
}
