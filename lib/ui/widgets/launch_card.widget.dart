import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacexapp/ui/pages/launch_detail.page.dart';

import '../../data/model/launch.model.dart';
import '../../data/model/rocket.model.dart';
import '../data/api/rocket.service.dart';

class LaunchCard extends StatelessWidget {
  final Launch launch;

  const LaunchCard({super.key, required this.launch});

  @override
  Widget build(BuildContext context) {
    final TextStyle style = Theme.of(context).textTheme.bodySmall!;
    final date = launch.dateUtc;
    final formattedDate = date != null
        ? DateFormat('d MMMM yyyy à HH:mm', 'fr_FR').format(date.toLocal())
        : 'Date inconnue';

    return Container(
      margin: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LaunchDetailPage(launch: launch),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              // Data
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          launch.name,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Image(
                        image: NetworkImage(launch.links.patch?.small ?? ''),
                        height: 40,
                      ),
                    ],
                  ),

                  FutureBuilder<Rocket>(
                    future: getRocketById(launch.rocket),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          'Chargement...',
                          style: TextStyle(color: Colors.grey),
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          'Erreur : ${snapshot.error}',
                          style: const TextStyle(color: Colors.red),
                        );
                      } else if (!snapshot.hasData) {
                        return const Text(
                          'Fusée inconnue',
                          style: TextStyle(color: Colors.white),
                        );
                      }
                      // Fusée
                      final rocket = snapshot.data!;
                      return Text(
                        rocket.name,
                        style: TextStyle(color: Colors.white),
                      );
                    },
                  ),

                  Text(
                    formattedDate,
                    style: style.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
