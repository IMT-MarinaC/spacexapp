import 'dart:convert';

import '../../utils/utils.dart';
import 'core.model.dart';
import 'failure.model.dart';
import 'fairings.model.dart';
import 'links_launch.model.dart';

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
    staticFireDateUtc: parseNullableDate(json['static_fire_date_utc']),
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
    crew: stringListFromJson(json['crew']),
    ships: stringListFromJson(json['ships']),
    capsules: stringListFromJson(json['capsules']),
    payloads: stringListFromJson(json['payloads']),
    launchpad: json['launchpad']?.toString() ?? '',
    flightNumber: json['flight_number'] is int
        ? json['flight_number'] as int
        : int.tryParse(json['flight_number']?.toString() ?? '0') ?? 0,
    name: json['name']?.toString() ?? '',
    dateUtc: parseNullableDate(json['date_utc']),
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
