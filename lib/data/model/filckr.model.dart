import '../../utils/utils.dart';

class Flickr {
  Flickr({required this.small, required this.original});

  final List<String> small;
  final List<String> original;

  factory Flickr.fromJson(Map<String, dynamic> json) => Flickr(
    small: stringListFromJson(json['small']),
    original: stringListFromJson(json['original']),
  );

  Map<String, dynamic> toJson() => {'small': small, 'original': original};
}
