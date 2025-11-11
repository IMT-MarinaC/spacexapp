class Failure {
  Failure({required this.time, this.altitude, required this.reason});

  final int time;
  final int? altitude;
  final String reason;

  factory Failure.fromJson(Map<String, dynamic> json) => Failure(
    time: json['time'] is int
        ? json['time'] as int
        : int.tryParse(json['time']?.toString() ?? '0') ?? 0,
    altitude: json['altitude'] is int
        ? json['altitude'] as int
        : (json['altitude'] != null
              ? int.tryParse(json['altitude'].toString())
              : null),
    reason: json['reason']?.toString() ?? '',
  );

  Map<String, dynamic> toJson() => {
    'time': time,
    'altitude': altitude,
    'reason': reason,
  };
}
