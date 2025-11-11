import '../../utils/utils.dart';

class Fairings {
  Fairings({
    required this.reused,
    required this.recoveryAttempt,
    required this.recovered,
    required this.ships,
  });

  final bool reused;
  final bool recoveryAttempt;
  final bool recovered;
  final List<String> ships;

  factory Fairings.fromJson(Map<String, dynamic> json) => Fairings(
    reused: json['reused'] == true,
    recoveryAttempt: json['recovery_attempt'] == true,
    recovered: json['recovered'] == true,
    ships: stringListFromJson(json['ships']),
  );

  Map<String, dynamic> toJson() => {
    'reused': reused,
    'recovery_attempt': recoveryAttempt,
    'recovered': recovered,
    'ships': ships,
  };
}
