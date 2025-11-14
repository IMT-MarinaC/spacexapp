import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/rocket/rocket.model.dart';

class RocketService {
  static const String _baseUrl = 'https://api.spacexdata.com/v4/rockets';

  Future<Rocket> fetchRocket(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/$id"));

    if (response.statusCode != 200) {
      throw Exception("Erreur serveur : ${response.statusCode}");
    }

    return Rocket.fromJson(jsonDecode(response.body));
  }

  Future<List<Rocket>> fetchAllRockets() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode != 200) {
      throw Exception("Erreur serveur : ${response.statusCode}");
    }

    final list = jsonDecode(response.body) as List;
    return list.map((e) => Rocket.fromJson(e)).toList();
  }
}
