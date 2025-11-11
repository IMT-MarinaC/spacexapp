import 'package:spacexapp/data/model/patch.model.dart';
import 'package:spacexapp/data/model/reddit_launch.model.dart';

import 'filckr.model.dart';

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
