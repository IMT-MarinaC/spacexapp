import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacexapp/ui/pages/launch_detail.page.dart';

import '../../data/api/rocket.service.dart';
import '../../data/model/launch.model.dart';
import '../../data/model/rocket/rocket.model.dart';

class LaunchCard extends StatelessWidget {
  final Launch launch;
  final bool onboardingActive;

  const LaunchCard({
    super.key,
    required this.launch,
    this.onboardingActive = false,
  });

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
                color: onboardingActive
                    ? Colors.amber
                    : Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              // Data
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          launch.name,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: onboardingActive
                                    ? Colors.black
                                    : Colors.white,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Image(
                        image: NetworkImage(launch.links.patch?.small ?? ''),
                        height: 40,
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Text(
                    formattedDate,
                    style: style.copyWith(
                      color: onboardingActive ? Colors.black : Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 12),

                  FutureBuilder<Rocket>(
                    future: RocketService().fetchRocket(launch.rocket),
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
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Fusée', style: TextStyle(color: Colors.grey)),
                          Text(
                            rocket.name,
                            style: TextStyle(
                              color: onboardingActive
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Statut', style: TextStyle(color: Colors.grey)),
                      Text(
                        launch.success ? '✅' : '❌',
                        style: style.copyWith(
                          color: onboardingActive ? Colors.black : Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Numéro de vol',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        '#${launch.flightNumber}',
                        style: style.copyWith(
                          color: onboardingActive ? Colors.black : Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
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
