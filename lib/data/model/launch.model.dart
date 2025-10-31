// dart model for the provided SpaceX-like API response
// Usage:
//   final launches = Launch.fromJsonList(jsonDecode(jsonString));

import 'dart:convert';

class Launch {
  Launch({
    required this.fairings,
    required this.links,
    this.staticFireDateUtc,
    this.staticFireDateUnix,
    required this.net,
    required this.window,
    required this.rocket,
    required this.success,
    required this.failures,
    this.details,
    required this.crew,
    required this.ships,
    required this.capsules,
    required this.payloads,
    required this.launchpad,
    required this.flightNumber,
    required this.name,
    this.dateUtc,
    this.dateUnix,
    this.dateLocal,
    required this.datePrecision,
    required this.upcoming,
    required this.cores,
    required this.autoUpdate,
    required this.tbd,
    this.launchLibraryId,
    required this.id,
  });

  final Fairings fairings;
  final Links links;
  final DateTime? staticFireDateUtc;
  final int? staticFireDateUnix;
  final bool net;
  final int window;
  final String rocket;
  final bool success;
  final List<Failure> failures;
  final String? details;
  final List<String> crew;
  final List<String> ships;
  final List<String> capsules;
  final List<String> payloads;
  final String launchpad;
  final int flightNumber;
  final String name;
  final DateTime? dateUtc;
  final int? dateUnix;
  final String? dateLocal;
  final String datePrecision;
  final bool upcoming;
  final List<Core> cores;
  final bool autoUpdate;
  final bool tbd;
  final String? launchLibraryId;
  final String id;

  factory Launch.fromJson(Map<String, dynamic> json) => Launch(
    fairings: Fairings.fromJson(json['fairings'] ?? {}),
    links: Links.fromJson(json['links'] ?? {}),
    staticFireDateUtc: _parseNullableDate(json['static_fire_date_utc']),
    staticFireDateUnix: json['static_fire_date_unix'] is int
        ? json['static_fire_date_unix'] as int
        : (json['static_fire_date_unix'] != null
              ? int.tryParse(json['static_fire_date_unix'].toString())
              : null),
    net: json['net'] == true,
    window: json['window'] is int ? json['window'] as int : 0,
    rocket: json['rocket']?.toString() ?? '',
    success: json['success'] == true,
    failures:
        (json['failures'] as List<dynamic>?)
            ?.map((e) => Failure.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    details: json['details'] as String?,
    crew: _stringListFromJson(json['crew']),
    ships: _stringListFromJson(json['ships']),
    capsules: _stringListFromJson(json['capsules']),
    payloads: _stringListFromJson(json['payloads']),
    launchpad: json['launchpad']?.toString() ?? '',
    flightNumber: json['flight_number'] is int
        ? json['flight_number'] as int
        : int.tryParse(json['flight_number']?.toString() ?? '0') ?? 0,
    name: json['name']?.toString() ?? '',
    dateUtc: _parseNullableDate(json['date_utc']),
    dateUnix: json['date_unix'] is int
        ? json['date_unix'] as int
        : (json['date_unix'] != null
              ? int.tryParse(json['date_unix'].toString())
              : null),
    dateLocal: json['date_local'] as String?,
    datePrecision: json['date_precision']?.toString() ?? '',
    upcoming: json['upcoming'] == true,
    cores:
        (json['cores'] as List<dynamic>?)
            ?.map((e) => Core.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    autoUpdate: json['auto_update'] == true,
    tbd: json['tbd'] == true,
    launchLibraryId: json['launch_library_id'] as String?,
    id: json['id']?.toString() ?? '',
  );

  Map<String, dynamic> toJson() => {
    'fairings': fairings.toJson(),
    'links': links.toJson(),
    'static_fire_date_utc': staticFireDateUtc?.toUtc().toIso8601String(),
    'static_fire_date_unix': staticFireDateUnix,
    'net': net,
    'window': window,
    'rocket': rocket,
    'success': success,
    'failures': failures.map((f) => f.toJson()).toList(),
    'details': details,
    'crew': crew,
    'ships': ships,
    'capsules': capsules,
    'payloads': payloads,
    'launchpad': launchpad,
    'flight_number': flightNumber,
    'name': name,
    'date_utc': dateUtc?.toUtc().toIso8601String(),
    'date_unix': dateUnix,
    'date_local': dateLocal,
    'date_precision': datePrecision,
    'upcoming': upcoming,
    'cores': cores.map((c) => c.toJson()).toList(),
    'auto_update': autoUpdate,
    'tbd': tbd,
    'launch_library_id': launchLibraryId,
    'id': id,
  };

  // helper to parse list of Launch from raw JSON string
  static List<Launch> fromJsonList(dynamic jsonData) {
    if (jsonData == null) return [];
    if (jsonData is String) {
      final decoded = jsonDecode(jsonData);
      return fromJsonList(decoded);
    }
    if (jsonData is List) {
      return jsonData
          .map((e) => Launch.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw ArgumentError('Unsupported jsonData for fromJsonList');
  }
}

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
    ships: _stringListFromJson(json['ships']),
  );

  Map<String, dynamic> toJson() => {
    'reused': reused,
    'recovery_attempt': recoveryAttempt,
    'recovered': recovered,
    'ships': ships,
  };
}

class Links {
  Links({
    this.patch,
    required this.reddit,
    required this.flickr,
    this.presskit,
    this.webcast,
    this.youtubeId,
    this.article,
    this.wikipedia,
  });

  final Patch? patch;
  final Reddit reddit;
  final Flickr flickr;
  final String? presskit;
  final String? webcast;
  final String? youtubeId;
  final String? article;
  final String? wikipedia;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    patch: json['patch'] != null ? Patch.fromJson(json['patch']) : null,
    reddit: Reddit.fromJson(json['reddit'] ?? {}),
    flickr: Flickr.fromJson(json['flickr'] ?? {}),
    presskit: json['presskit'] as String?,
    webcast: json['webcast'] as String?,
    youtubeId: json['youtube_id'] as String?,
    article: json['article'] as String?,
    wikipedia: json['wikipedia'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'patch': patch?.toJson(),
    'reddit': reddit.toJson(),
    'flickr': flickr.toJson(),
    'presskit': presskit,
    'webcast': webcast,
    'youtube_id': youtubeId,
    'article': article,
    'wikipedia': wikipedia,
  };
}

class Patch {
  Patch({this.small, this.large});

  final String? small;
  final String? large;

  factory Patch.fromJson(Map<String, dynamic> json) =>
      Patch(small: json['small'] as String?, large: json['large'] as String?);

  Map<String, dynamic> toJson() => {'small': small, 'large': large};
}

class Reddit {
  Reddit({this.campaign, this.launch, this.media, this.recovery});

  final String? campaign;
  final String? launch;
  final String? media;
  final String? recovery;

  factory Reddit.fromJson(Map<String, dynamic> json) => Reddit(
    campaign: json['campaign'] as String?,
    launch: json['launch'] as String?,
    media: json['media'] as String?,
    recovery: json['recovery'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'campaign': campaign,
    'launch': launch,
    'media': media,
    'recovery': recovery,
  };
}

class Flickr {
  Flickr({required this.small, required this.original});

  final List<String> small;
  final List<String> original;

  factory Flickr.fromJson(Map<String, dynamic> json) => Flickr(
    small: _stringListFromJson(json['small']),
    original: _stringListFromJson(json['original']),
  );

  Map<String, dynamic> toJson() => {'small': small, 'original': original};
}

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

/// --- Helpers ---
DateTime? _parseNullableDate(dynamic value) {
  if (value == null) return null;
  try {
    return DateTime.parse(value.toString());
  } catch (_) {
    return null;
  }
}

List<String> _stringListFromJson(dynamic v) {
  if (v == null) return [];
  if (v is List) {
    return v.map((e) => e?.toString() ?? '').toList();
  }
  // if it's a single string, return single-element list
  if (v is String) return [v];
  return [];
}
