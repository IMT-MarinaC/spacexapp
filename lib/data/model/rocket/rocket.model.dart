import 'diameter.model.dart';
import 'engines.model.dart';
import 'first_stage.model.dart';
import 'height.model.dart';
import 'landing_legs.model.dart';
import 'mass.model.dart';
import 'payload_weight.model.dart';
import 'second_stage.model.dart';

class Rocket {
  final String id;
  final String name;
  final String type;
  final bool active;
  final int stages;
  final int boosters;
  final int costPerLaunch;
  final int successRatePct;
  final String firstFlight;
  final String country;
  final String company;
  final String wikipedia;
  final String description;

  final Height height;
  final Diameter diameter;
  final Mass mass;

  final FirstStage firstStage;
  final SecondStage secondStage;
  final Engines engines;
  final LandingLegs landingLegs;

  final List<PayloadWeight> payloadWeights;
  final List<String> flickrImages;

  Rocket({
    required this.id,
    required this.name,
    required this.type,
    required this.active,
    required this.stages,
    required this.boosters,
    required this.costPerLaunch,
    required this.successRatePct,
    required this.firstFlight,
    required this.country,
    required this.company,
    required this.wikipedia,
    required this.description,
    required this.height,
    required this.diameter,
    required this.mass,
    required this.firstStage,
    required this.secondStage,
    required this.engines,
    required this.landingLegs,
    required this.payloadWeights,
    required this.flickrImages,
  });

  factory Rocket.fromJson(Map<String, dynamic> json) {
    return Rocket(
      id: json['id'],
      name: json['name'],
      type: json['type'] ?? 'rocket',
      active: json['active'] ?? false,
      stages: json['stages'] ?? 0,
      boosters: json['boosters'] ?? 0,
      costPerLaunch: json['cost_per_launch'] ?? 0,
      successRatePct: json['success_rate_pct'] ?? 0,
      firstFlight: json['first_flight'] ?? '',
      country: json['country'] ?? '',
      company: json['company'] ?? '',
      wikipedia: json['wikipedia'] ?? '',
      description: json['description'] ?? '',

      height: Height.fromJson(json['height']),
      diameter: Diameter.fromJson(json['diameter']),
      mass: Mass.fromJson(json['mass']),

      firstStage: FirstStage.fromJson(json['first_stage']),
      secondStage: SecondStage.fromJson(json['second_stage']),
      engines: Engines.fromJson(json['engines']),
      landingLegs: LandingLegs.fromJson(json['landing_legs']),

      payloadWeights: (json['payload_weights'] as List<dynamic>)
          .map((pw) => PayloadWeight.fromJson(pw))
          .toList(),

      flickrImages: List<String>.from(json['flickr_images'] ?? []),
    );
  }
}
