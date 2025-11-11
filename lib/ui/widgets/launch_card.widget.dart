import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spacexapp/ui/pages/launch_detail.page.dart';

import '../../data/model/launch.model.dart';

class LaunchCard extends StatelessWidget {
  final Launch launch;

  const LaunchCard({super.key, required this.launch});

  @override
  Widget build(BuildContext context) {
    final TextStyle style = Theme.of(context).textTheme.bodySmall!;
    return Container(
      margin: const EdgeInsets.all(8),
      child: Stack(
        children: [
          // Dégradé
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              gradient: const LinearGradient(
                colors: [Colors.white38, Colors.blueGrey],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // FLou
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.white.withValues(alpha: 0.5)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LaunchDetailPage(launch: launch),
                  ),
                );
              },

              // Data
              child: Column(
                children: [
                  Row(
                    children: [
                      Image(
                        image: NetworkImage(launch.links.patch?.large ?? ''),
                        height: 40,
                      ),
                      Semantics(
                        header: true,
                        child: Text(
                          launch.name,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'ID : ${launch.id}',
                    style: style.copyWith(color: Colors.black),
                  ),
                  Text(
                    'Fusée : ${launch.rocket}',
                    style: style.copyWith(color: Colors.black),
                  ),
                  Text(
                    'Date de lancement : ${launch.dateUtc.toString()}',
                    style: style.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
