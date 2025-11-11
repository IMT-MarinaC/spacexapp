import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spacexapp/data/model/launch.model.dart';

const String _baseUrl = 'https://api.spacexdata.com/v4/launches';

Future<List<Launch>> getAll() async {
  try {
    final httpResponse = await http.get(Uri.parse(_baseUrl));

    if (httpResponse.statusCode != 200) {
      throw Exception('Erreur serveur : ${httpResponse.statusCode}');
    }

    final List<dynamic> jsonList = jsonDecode(httpResponse.body);
    final List<Launch> launches = [];

    for (var jsonItem in jsonList) {
      if (jsonItem is Map<String, dynamic>) {
        try {
          final launch = Launch.fromJson(jsonItem);
          launches.add(launch);
        } catch (e) {
          print("❌ Erreur lors du parsing d’un lancement : $e");
        }
      }
    }

    print("✅ Nombre de lancements récupérés : ${launches.length}");
    return launches;
  } catch (e) {
    print('❌ Erreur lors de la récupération des lancements : $e');
    return [];
  }
}

// Récupère un seul lancement via son ID
Future<Launch?> getById(String id) async {
  try {
    final httpResponse = await http.get(Uri.parse('$_baseUrl/$id'));

    if (httpResponse.statusCode != 200) {
      throw Exception('Erreur serveur : ${httpResponse.statusCode}');
    }

    final Map<String, dynamic> jsonItem = jsonDecode(httpResponse.body);
    return Launch.fromJson(jsonItem);
  } catch (e) {
    print('❌ Erreur lors de la récupération du lancement $id : $e');
    return null;
  }
}
