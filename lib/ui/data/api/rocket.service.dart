import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../data/model/rocket/rocket.model.dart';

class RocketService {
  final String baseUrl = 'https://api.spacexdata.com/v4/rockets';

  Future<Rocket> fetchRocket(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));

      if (response.statusCode != 200) {
        throw Exception('Erreur API Rocket : ${response.statusCode}');
      }

      final data = jsonDecode(response.body);
      return Rocket.fromJson(data);
    } catch (e) {
      throw Exception('Erreur lors du chargement de la fusée : $e');
    }
  }
}
