import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../data/model/rocket.model.dart';

Future<Rocket> getRocketById(String id) async {
  final url = Uri.parse('https://api.spacexdata.com/v4/rockets/$id');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    return Rocket.fromJson(jsonData);
  } else {
    throw Exception(
      'Erreur de chargement de la fusée : ${response.statusCode}',
    );
  }
}
