import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spacexapp/data/model/rocket/rocket.model.dart';
import 'package:spacexapp/ui/widgets/rocket_detail_card.dart';

void showRocketModal(BuildContext context, Rocket rocket) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.3),
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.4),
                width: 1.2,
              ),
            ),
            child: _RocketContent(rocket: rocket),
          ),
        ),
      ),
    ),
  );
}

class _RocketContent extends StatelessWidget {
  final Rocket rocket;

  const _RocketContent({required this.rocket});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              // image
              if (rocket.flickrImages.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    rocket.flickrImages.first,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),

              const SizedBox(width: 16),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rocket.name,
                    style: textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "Type : ${rocket.type}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(color: Colors.white24),

          // pays et entrep
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Pays', style: TextStyle(color: Colors.grey)),
              Text(rocket.country, style: const TextStyle(color: Colors.white)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Entreprise', style: TextStyle(color: Colors.grey)),
              Text(rocket.company, style: const TextStyle(color: Colors.white)),
            ],
          ),

          const SizedBox(height: 20),

          // cards
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              RocketDetailCard(
                name: "Hauteur",
                data: rocket.height.meters.toString(),
                unit: "m",
              ),
              RocketDetailCard(
                name: "Diamètre",
                data: rocket.diameter.meters.toString(),
                unit: "m",
              ),
              RocketDetailCard(
                name: 'Masse',
                data: rocket.mass.kg > 1000
                    ? (rocket.mass.kg / 1000).toString()
                    : rocket.mass.kg.toString(),
                unit: rocket.mass.kg > 1000 ? 't' : 'kg',
              ),
              if (rocket.stages != 0)
                RocketDetailCard(
                  name: rocket.stages > 1 ? "Étages" : "Étage",
                  data: rocket.stages.toString(),
                ),
              if (rocket.boosters != 0)
                RocketDetailCard(
                  name: rocket.boosters > 1 ? "Boosters" : "Booster",
                  data: rocket.boosters.toString(),
                ),
              if (rocket.landingLegs.number != 0)
                RocketDetailCard(
                  name: rocket.landingLegs.number > 1
                      ? "Jambes d'attérissage"
                      : "Jambe d'attérissage",
                  data: rocket.landingLegs.number.toString(),
                ),
              if (rocket.engines.number != 0)
                RocketDetailCard(
                  name: rocket.engines.number > 1 ? "Moteurs" : "Moteur",
                  data: rocket.engines.number.toString(),
                ),
            ],
          ),

          const SizedBox(height: 20),

          // charges utiles
          if (rocket.payloadWeights.isNotEmpty) ...[
            Row(
              children: [
                const Text(
                  "Charges utiles max",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            for (final pw in rocket.payloadWeights)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(pw.name, style: const TextStyle(color: Colors.grey)),
                  Text(
                    "${pw.kg} kg",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
          ],

          const SizedBox(height: 12),

          const Divider(color: Colors.white24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('1er vol', style: TextStyle(color: Colors.grey)),
              Text(
                rocket.firstFlight,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Taux de succès',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                '${rocket.successRatePct}%',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Coût lancement',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                '${rocket.costPerLaunch} \$',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),

          // statut
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Statut', style: const TextStyle(color: Colors.grey)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: rocket.active ? Colors.lightGreen : Color(0xFF621302),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  rocket.active ? "Active" : "Inactive",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // DESCRIPTION
          Text(
            rocket.description,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.justify,
          ),

          const SizedBox(height: 24),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text("Fermer"),
            ),
          ),
        ],
      ),
    );
  }
}
