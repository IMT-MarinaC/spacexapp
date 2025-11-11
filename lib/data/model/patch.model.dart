class Patch {
  Patch({this.small, this.large});

  final String? small;
  final String? large;

  factory Patch.fromJson(Map<String, dynamic> json) =>
      Patch(small: json['small'] as String?, large: json['large'] as String?);

  Map<String, dynamic> toJson() => {'small': small, 'large': large};
}
