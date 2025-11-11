import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacexapp/ui/pages/launch_detail.page.dart';

import '../../data/model/launch.model.dart';

class LaunchListItem extends StatelessWidget {
  final Launch launch;

  const LaunchListItem({super.key, required this.launch});

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
                color: Colors.black.withValues(alpha: 0.8),
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
                          launch.name,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'ID : ${launch.id}',
                          style: style.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Fusée : ${launch.rocket}',
                          style: style.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 2),

                        Text(
                          'Date : $formattedDate',
                          style: style.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
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
