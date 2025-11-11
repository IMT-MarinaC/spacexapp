import 'package:flutter/material.dart';
import 'package:spacexapp/data/model/rocket.model.dart';

import '../data/api/rocket.service.dart';

Future<void> showRocketModal(BuildContext context, String rocketId) async {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.black.withValues(alpha: 0.9),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return FutureBuilder<Rocket>(
        future: getRocketById(rocketId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Erreur : ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Aucune donnée fusée'),
            );
          }

          final rocket = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      rocket.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Type : ${rocket.type}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  const Divider(color: Colors.white30, height: 24),

                  Text(
                    'Pays : ${rocket.country}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Entreprise : ${rocket.company}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Étages : ${rocket.stages}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Boosters : ${rocket.boosters}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Hauteur : ${rocket.heightMeters} m',
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Masse : ${rocket.massKg} kg',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    rocket.description,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Fermer'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
