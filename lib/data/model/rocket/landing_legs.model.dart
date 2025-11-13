class LandingLegs {
  final int number;
  final String? material;

  LandingLegs({required this.number, required this.material});

  factory LandingLegs.fromJson(Map<String, dynamic> json) =>
      LandingLegs(number: json['number'] ?? 0, material: json['material']);
}
