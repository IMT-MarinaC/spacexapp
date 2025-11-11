class Core {
  Core({
    this.core,
    required this.flight,
    required this.gridfins,
    required this.legs,
    required this.reused,
    required this.landingAttempt,
    this.landingSuccess,
    this.landingType,
    this.landpad,
  });

  final String? core;
  final int flight;
  final bool gridfins;
  final bool legs;
  final bool reused;
  final bool landingAttempt;
  final bool? landingSuccess;
  final String? landingType;
  final String? landpad;

  factory Core.fromJson(Map<String, dynamic> json) => Core(
    core: json['core'] as String?,
    flight: json['flight'] is int
        ? json['flight'] as int
        : int.tryParse(json['flight']?.toString() ?? '0') ?? 0,
    gridfins: json['gridfins'] == true,
    legs: json['legs'] == true,
    reused: json['reused'] == true,
    landingAttempt: json['landing_attempt'] == true,
    landingSuccess: json['landing_success'] as bool?,
    landingType: json['landing_type'] as String?,
    landpad: json['landpad'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'core': core,
    'flight': flight,
    'gridfins': gridfins,
    'legs': legs,
    'reused': reused,
    'landing_attempt': landingAttempt,
    'landing_success': landingSuccess,
    'landing_type': landingType,
    'landpad': landpad,
  };
}
