class Rocket {
  final String id;
  final String name;
  final String type;
  final String country;
  final String company;
  final int stages;
  final int boosters;
  final double heightMeters;
  final double diameterMeters;
  final double massKg;
  final String description;

  Rocket({
    required this.id,
    required this.name,
    required this.type,
    required this.country,
    required this.company,
    required this.stages,
    required this.boosters,
    required this.heightMeters,
    required this.diameterMeters,
    required this.massKg,
    required this.description,
  });

  factory Rocket.fromJson(Map<String, dynamic> json) {
    return Rocket(
      id: json['id'],
      name: json['name'],
      type: json['type'] ?? 'Inconnu',
      country: json['country'] ?? 'N/A',
      company: json['company'] ?? 'SpaceX',
      stages: json['stages'] ?? 0,
      boosters: json['boosters'] ?? 0,
      heightMeters: (json['height']?['meters'] ?? 0).toDouble(),
      diameterMeters: (json['diameter']?['meters'] ?? 0).toDouble(),
      massKg: (json['mass']?['kg'] ?? 0).toDouble(),
      description: json['description'] ?? '',
    );
  }
}
