import 'package:flutter/material.dart';
import 'package:spacexapp/data/model/launch.model.dart';
import 'package:spacexapp/data/model/rocket.model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/api/rocket.service.dart';
import '../widgets/rocket_modal.widget.dart';

class LaunchDetailPage extends StatefulWidget {
  final Launch launch;

  const LaunchDetailPage({super.key, required this.launch});

  @override
  State<StatefulWidget> createState() => _LaunchDetailPageState();
}

class _LaunchDetailPageState extends State<LaunchDetailPage> {
  var isFavorite = false;
  late Future<Rocket> _rocketFuture;

  @override
  void initState() {
    super.initState();
    _rocketFuture = getRocketById(widget.launch.rocket);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle style = Theme.of(context).textTheme.bodyMedium!;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar avec image
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.transparent,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.rectangle,
              ),
              child: const BackButton(color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });

                  // Messages pour les favoris
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Center(
                        child: RichText(
                          text: isFavorite
                              ? TextSpan(
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: widget.launch.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: ' a été ajouté aux favoris ❤️',
                                    ),
                                  ],
                                )
                              : TextSpan(
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: widget.launch.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: ' a été retiré des favoris 💔️',
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.black.withValues(alpha: 0.7),
                    ),
                  );
                },
              ),
            ],
            title: Text(widget.launch.name),
          ),

          SliverFillRemaining(
            hasScrollBody: true,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo / patch de mission
                  if (widget.launch.links?.patch?.large != null)
                    Center(
                      child: Image.network(
                        widget.launch.links!.patch!.large!,
                        height: 150,
                      ),
                    ),

                  const SizedBox(height: 16),

                  // Nom du lancement et de la fusée
                  Row(
                    children: [
                      Text(
                        widget.launch.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(width: 8),
                      FutureBuilder<Rocket>(
                        future: getRocketById(widget.launch.rocket),
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

                          final rocket = snapshot.data!;
                          return ActionChip(
                            avatar: const Icon(
                              Icons.rocket_launch,
                              color: Colors.white,
                              size: 18,
                            ),
                            label: Text(
                              rocket.name ?? "...",
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.blueAccent,
                            onPressed: () =>
                                showRocketModal(context, widget.launch.rocket),
                          );
                        },
                      ),
                    ],
                  ),

                  // Date formatée
                  /*
                  Text(
                    'Date : ${DateFormat('EEEE d MMMM y, HH:mm', 'fr_FR').format(widget.launch.dateUtc)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),*/

                  // Succès ou échec
                  Text(
                    widget.launch.success == true ? '✅ Succès' : '❌ Échec',
                    style: TextStyle(
                      color: widget.launch.success == true
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Description
                  if (widget.launch.details != null)
                    Text(widget.launch.details!),

                  const SizedBox(height: 16),

                  // Liens utiles
                  Wrap(
                    spacing: 8,
                    children: [
                      if (widget.launch.links?.webcast != null)
                        ElevatedButton.icon(
                          icon: const Icon(Icons.play_arrow),
                          label: const Text("Webcast"),
                          onPressed: () => launchUrl(
                            Uri.parse(widget.launch.links!.webcast!),
                          ),
                        ),
                      if (widget.launch.links?.article != null)
                        ElevatedButton.icon(
                          icon: const Icon(Icons.article),
                          label: const Text("Article"),
                          onPressed: () => launchUrl(
                            Uri.parse(widget.launch.links!.article!),
                          ),
                        ),
                      if (widget.launch.links?.wikipedia != null)
                        ElevatedButton.icon(
                          icon: const Icon(Icons.public),
                          label: const Text("Wikipedia"),
                          onPressed: () => launchUrl(
                            Uri.parse(widget.launch.links!.wikipedia!),
                          ),
                        ),
                    ],
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
