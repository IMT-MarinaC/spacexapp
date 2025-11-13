class Mass {
  final int kg;
  final int lb;

  Mass({required this.kg, required this.lb});

  factory Mass.fromJson(Map<String, dynamic> json) =>
      Mass(kg: json['kg'] ?? 0, lb: json['lb'] ?? 0);
}
