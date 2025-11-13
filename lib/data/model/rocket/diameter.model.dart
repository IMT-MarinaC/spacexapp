class Diameter {
  final double meters;
  final double feet;

  Diameter({required this.meters, required this.feet});

  factory Diameter.fromJson(Map<String, dynamic> json) => Diameter(
    meters: (json['meters'] ?? 0).toDouble(),
    feet: (json['feet'] ?? 0).toDouble(),
  );
}
