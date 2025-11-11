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
