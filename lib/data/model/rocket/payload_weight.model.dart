class PayloadWeight {
  final String id;
  final String name;
  final int kg;
  final int lb;

  PayloadWeight({
    required this.id,
    required this.name,
    required this.kg,
    required this.lb,
  });

  factory PayloadWeight.fromJson(Map<String, dynamic> json) => PayloadWeight(
    id: json['id'],
    name: json['name'],
    kg: json['kg'] ?? 0,
    lb: json['lb'] ?? 0,
  );
}
