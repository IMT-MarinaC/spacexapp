class Height {
  final double meters;
  final double feet;

  Height({required this.meters, required this.feet});

  factory Height.fromJson(Map<String, dynamic> json) => Height(
    meters: (json['meters'] ?? 0).toDouble(),
    feet: (json['feet'] ?? 0).toDouble(),
  );
}
