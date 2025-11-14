import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spacexapp/ui/pages/launch_detail.page.dart';

import '../../data/model/launch.model.dart';
import '../cubit/rocket/rocket.cubit.dart';

class LaunchCard extends StatefulWidget {
  final Launch launch;
  final bool onboardingActive;

  const LaunchCard({
    super.key,
    required this.launch,
    this.onboardingActive = false,
  });

  @override
  State<LaunchCard> createState() => _LaunchCardState();
}

class _LaunchCardState extends State<LaunchCard> {
  late final String formattedDate;

  @override
  void initState() {
    super.initState();

    final date = widget.launch.dateUtc;
    formattedDate = date != null
        ? DateFormat('d MMMM yyyy à HH:mm', 'fr_FR').format(date.toLocal())
        : 'Date inconnue';

    context.read<RocketCubit>().fetchRocket(widget.launch.rocket);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle style = Theme.of(context).textTheme.bodySmall!;

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
                  builder: (context) => LaunchDetailPage(launch: widget.launch),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: widget.onboardingActive
                    ? Colors.amber
                    : Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(12),
              ),

              // 🧩 Données du launch
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nom + Patch
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          widget.launch.name,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: widget.onboardingActive
                                    ? Colors.black
                                    : Colors.white,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Image(
                        image: NetworkImage(
                          widget.launch.links.patch?.small ?? '',
                        ),
                        height: 40,
                        errorBuilder: (_, _, _) => const Icon(
                          Icons.rocket_launch,
                          color: Colors.white24,
                          size: 32,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Text(
                    formattedDate,
                    style: style.copyWith(
                      color: widget.onboardingActive
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 12),

                  BlocBuilder<RocketCubit, RocketState>(
                    builder: (context, rocketState) {
                      if (rocketState.loading) {
                        return const Text(
                          "Chargement de la fusée...",
                          style: TextStyle(color: Colors.grey),
                        );
                      }

                      if (rocketState.error != null) {
                        return Text(
                          "Erreur : ${rocketState.error}",
                          style: const TextStyle(color: Colors.red),
                        );
                      }

                      if (rocketState.rocket == null) {
                        return const Text(
                          "Fusée inconnue",
                          style: TextStyle(color: Colors.white),
                        );
                      }

                      final rocket = rocketState.rocket!;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Fusée",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            rocket.name,
                            style: TextStyle(
                              color: widget.onboardingActive
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Statut",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        widget.launch.success ? "✅" : "❌",
                        style: style.copyWith(
                          color: widget.onboardingActive
                              ? Colors.black
                              : Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Numéro de vol",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        "#${widget.launch.flightNumber}",
                        style: style.copyWith(
                          color: widget.onboardingActive
                              ? Colors.black
                              : Colors.white,
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
