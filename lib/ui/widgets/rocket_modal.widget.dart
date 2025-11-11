import 'package:flutter/material.dart';
import 'package:spacexapp/data/model/rocket.model.dart';
import 'package:spacexapp/ui/widgets/rocket_detail_card.dart';

import '../data/api/rocket.service.dart';

Future<void> showRocketModal(BuildContext context, String rocketId) async {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.black,
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

                  const Divider(color: Colors.grey, height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pays', style: const TextStyle(color: Colors.grey)),
                      Text(rocket.country),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Entreprise',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Text(rocket.company),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      RocketDetailCard(
                        name: 'Hauteur',
                        data: rocket.heightMeters.toString(),
                        unit: 'm',
                      ),
                      RocketDetailCard(
                        name: 'Diamètre',
                        data: rocket.diameterMeters.toString(),
                        unit: 'm',
                      ),
                      RocketDetailCard(
                        name: 'Masse',
                        data: rocket.massKg > 1000
                            ? (rocket.massKg / 1000).toString()
                            : rocket.massKg.toString(),
                        unit: rocket.massKg > 1000 ? 't' : 'kg',
                      ),
                      RocketDetailCard(
                        name: rocket.stages > 1 ? "Étages" : "Étage",
                        data: rocket.stages.toString(),
                      ),
                      RocketDetailCard(
                        name: rocket.boosters > 1 ? "Boosters" : "Booster",
                        data: rocket.boosters.toString(),
                      ),
                    ],
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
                      child: const Text(
                        'Fermer',
                        style: TextStyle(color: Colors.black),
                      ),
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
