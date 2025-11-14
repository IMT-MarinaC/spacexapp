import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacexapp/data/api/rocket.service.dart';
import 'package:spacexapp/data/model/launch.model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/model/rocket/rocket.model.dart';
import '../cubit/favorites/favorites.cubit.dart';
import '../cubit/favorites/favorites.state.dart';
import '../onboarding/launch_detail.onboarding.dart';
import '../onboarding/services/rocket_detail.onboarding.service.dart';
import '../widgets/modals/rocket_detail.modal.dart';

class LaunchDetailPage extends StatefulWidget {
  final Launch launch;

  const LaunchDetailPage({super.key, required this.launch});

  @override
  State<LaunchDetailPage> createState() => _LaunchDetailPageState();
}

class _LaunchDetailPageState extends State<LaunchDetailPage> {
  Launch get launch => widget.launch;
  bool highlightRocketName = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!await RocketDetailOnboardingService.isDone()) {
        showRocketDetailOnboarding(
          context,
          onHighlightRocketName: (value) =>
              setState(() => highlightRocketName = value),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(launch.name),
        backgroundColor: Colors.transparent,
        elevation: 0,

        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Revoir l’onboarding',
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('rocket_detail_onboarding_done', false);
              if (!await RocketDetailOnboardingService.isDone()) {
                showRocketDetailOnboarding(
                  context,
                  onHighlightRocketName: (value) =>
                      setState(() => highlightRocketName = value),
                );
              }
            },
          ),
          BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              final isFav = state.favoritesIds.contains(launch.id);

              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  context.read<FavoritesCubit>().toggleFavorite(launch.id);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: RichText(
                        text: isFav
                            ? TextSpan(
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                    text: launch.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' a été retiré des favoris 💔️',
                                  ),
                                ],
                              )
                            : TextSpan(
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                    text: launch.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' a été ajouté aux favoris ❤️',
                                  ),
                                ],
                              ),
                      ),
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.black.withValues(alpha: 0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.grey),
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // patch
            if (launch.links.patch?.large != null)
              Center(
                child: Image.network(
                  launch.links.patch!.large!,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
            const SizedBox(height: 20),

            // 1ere setion - fusée, date, succès, num de vol
            Center(
              child: Column(
                children: [
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
                      return ActionChip(
                        avatar: const Icon(
                          Icons.rocket_launch,
                          color: Colors.black,
                          size: 16,
                        ),
                        label: Text(
                          rocket.name,
                          style: const TextStyle(color: Colors.black),
                        ),
                        backgroundColor: highlightRocketName
                            ? Colors.amber
                            : Colors.white,
                        onPressed: () => showRocketModal(context, rocket),
                      );
                    },
                  ),

                  const SizedBox(height: 8),
                  Text(
                    'Date : ${launch.dateUtc?.toLocal().toString().split(' ')[0] ?? 'Inconnue'}',
                    style: theme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    launch.success
                        ? '✅ Mission réussie'
                        : '❌ Échec du lancement',
                    style: theme.bodyMedium?.copyWith(
                      color: launch.success ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Vol n°${launch.flightNumber}', style: theme.bodySmall),
                ],
              ),
            ),

            const Divider(height: 32),

            // 2e section - détails de la mission
            const SizedBox(height: 8),
            if (launch.details != null)
              Text(
                launch.details!,
                style: theme.bodyMedium,
                textAlign: TextAlign.justify,
              ),

            const SizedBox(height: 20),

            // echecs s'il y a
            if (launch.failures.isNotEmpty) ...[
              Text('Échecs enregistrés :', style: theme.titleMedium),
              const SizedBox(height: 8),
              for (final failure in launch.failures)
                Text(
                  '• ${failure.reason} (à T+${failure.time}s)',
                  style: theme.bodySmall?.copyWith(color: Colors.redAccent),
                ),
              const SizedBox(height: 20),
            ],

            // infos des étages
            if (launch.cores.isNotEmpty) ...[
              Text('Détails des coeurs :', style: theme.titleMedium),
              Text('Nombre de coeurs : ${launch.cores.length}'),
              const SizedBox(height: 8),
              for (final core in launch.cores)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Vol : ${core.flight}'),
                    Text('Réutilisé : ${core.reused ? "Oui" : "Non"}'),
                    Text(
                      'Tentative d’atterrissage : ${core.landingAttempt ? "Oui" : "Non"}',
                    ),
                    if (core.landingSuccess != null)
                      Text(
                        'Succès atterrissage : ${core.landingSuccess! ? "Oui" : "Non"}',
                      ),
                    if (core.landingType != null)
                      Text('Type : ${core.landingType}'),

                    const SizedBox(height: 10),
                  ],
                ),
            ],

            const Divider(height: 32),

            // images
            if (launch.links.flickr.original.isNotEmpty) ...[
              Text('Photos de la mission :', style: theme.titleMedium),
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: launch.links.flickr.original.length,
                  itemBuilder: (context, index) {
                    final imgUrl = launch.links.flickr.original[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(imgUrl, height: 200),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],

            // les links
            Wrap(
              spacing: 5,
              children: [
                if (launch.links.webcast != null)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.play_arrow),
                    label: const Text(
                      "Webcast",
                      style: TextStyle(fontSize: 12),
                    ),
                    onPressed: () =>
                        launchUrl(Uri.parse(launch.links.webcast!)),
                  ),

                if (launch.links.article != null)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.article),
                    label: const Text(
                      "Article",
                      style: TextStyle(fontSize: 12),
                    ),
                    onPressed: () =>
                        launchUrl(Uri.parse(launch.links.article!)),
                  ),

                if (launch.links.wikipedia != null)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.public),
                    label: const Text(
                      "Wikipedia",
                      style: TextStyle(fontSize: 12),
                    ),
                    onPressed: () =>
                        launchUrl(Uri.parse(launch.links.wikipedia!)),
                  ),

                if (launch.links.presskit != null)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.newspaper),
                    label: const Text(
                      "Presskit",
                      style: TextStyle(fontSize: 12),
                    ),
                    onPressed: () =>
                        launchUrl(Uri.parse(launch.links.presskit!)),
                  ),
              ],
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
