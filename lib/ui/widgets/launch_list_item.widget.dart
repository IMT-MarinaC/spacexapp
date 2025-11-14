import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacexapp/ui/pages/launch_detail.page.dart';

import '../../data/api/rocket.service.dart';
import '../../data/model/launch.model.dart';
import '../../data/model/rocket/rocket.model.dart';

class LaunchListItem extends StatelessWidget {
  final Launch launch;
  final bool onboardingActive;

  const LaunchListItem({
    super.key,
    required this.launch,
    this.onboardingActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle style = Theme.of(context).textTheme.bodyMedium!;
    final date = launch.dateUtc;
    final formattedDate = date != null
        ? DateFormat('d MMMM yyyy à HH:mm', 'fr_FR').format(date.toLocal())
        : 'Date inconnue';

    return Container(
      margin: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: onboardingActive
                    ? Colors.amber
                    : Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Infos sur le lancement
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          launch.success
                              ? "✅ ${launch.name}"
                              : "❌ ${launch.name}",
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: onboardingActive
                                    ? Colors.black
                                    : Colors.white,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          formattedDate,
                          style: style.copyWith(
                            color: onboardingActive
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 2),
                        FutureBuilder<Rocket>(
                          future: RocketService().fetchRocket(launch.rocket),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
                              'Fusée : ${rocket.name}',
                              style: TextStyle(
                                color: onboardingActive
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '#${launch.flightNumber.toString()}',
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      launch.links.patch?.large ?? '',
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.rocket_launch,
                        color: Colors.white24,
                        size: 40,
                      ),
                    ),
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
