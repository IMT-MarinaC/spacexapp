import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spacexapp/ui/pages/launch_detail.page.dart';

import '../../data/model/launch.model.dart';
import '../cubit/rocket/rocket.cubit.dart';

class LaunchListItem extends StatefulWidget {
  final Launch launch;
  final bool onboardingActive;

  const LaunchListItem({
    super.key,
    required this.launch,
    this.onboardingActive = false,
  });

  @override
  State<LaunchListItem> createState() => _LaunchListItemState();
}

class _LaunchListItemState extends State<LaunchListItem> {
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
    final TextStyle style = Theme.of(context).textTheme.bodyMedium!;

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
                  builder: (context) => LaunchDetailPage(launch: widget.launch),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: widget.onboardingActive
                    ? Colors.amber
                    : Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.launch.success
                              ? "✅ ${widget.launch.name}"
                              : "❌ ${widget.launch.name}",
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: widget.onboardingActive
                                    ? Colors.black
                                    : Colors.white,
                              ),
                          overflow: TextOverflow.ellipsis,
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

                        const SizedBox(height: 2),

                        BlocBuilder<RocketCubit, RocketState>(
                          builder: (context, rocketState) {
                            if (rocketState.loading) {
                              return const Text(
                                "Chargement...",
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

                            return Text(
                              "Fusée : ${rocketState.rocket!.name}",
                              style: TextStyle(
                                color: widget.onboardingActive
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
                    '#${widget.launch.flightNumber}',
                    style: const TextStyle(fontSize: 32, color: Colors.white),
                  ),

                  const SizedBox(width: 8),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      widget.launch.links.patch?.large ?? '',
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
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
