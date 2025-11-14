import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/launch.model.dart';

const String _baseUrl = 'https://api.spacexdata.com/v4/launches';

Future<List<Launch>> getAll() async {
  try {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode != 200) {
      throw Exception('Erreur serveur : ${response.statusCode}');
    }

    final List<dynamic> jsonList = jsonDecode(response.body);

    return jsonList
        .whereType<Map<String, dynamic>>()
        .map((json) {
          try {
            return Launch.fromJson(json);
          } catch (e) {
            print("❌ Erreur parsing d’un lancement : $e");
            return null;
          }
        })
        .where((launch) => launch != null)
        .cast<Launch>()
        .toList();
  } catch (e) {
    print('❌ Erreur récupération lancements : $e');
    throw Exception("Impossible de récupérer les lancements");
  }
}

Future<Launch?> getById(String id) async {
  try {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Erreur serveur : ${response.statusCode}');
    }

    final Map<String, dynamic> json = jsonDecode(response.body);
    return Launch.fromJson(json);
  } catch (e) {
    print('❌ Erreur récupération du lancement $id : $e');
    return null;
  }
}
