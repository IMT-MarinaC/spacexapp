import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/launch/launch.cubit.dart';
import '../cubit/rocket/rocket_list.cubit.dart';
import '../onboarding/home.onboarding.dart';
import '../onboarding/services/onboarding.service.dart';
import '../widgets/launch_card.widget.dart';
import '../widgets/launch_list_item.widget.dart';
import 'favorites.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isListView = false;
  bool highlightFav = false;
  bool highlightSwitch = false;
  int onboardingStep = -1;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<RocketListCubit>().fetchRockets();

      if (!await OnboardingService.isDone()) {
        setState(() => onboardingStep = 0);
        await showHomeOnboarding(
          context,
          onHighlightFav: (v) => setState(() => highlightFav = v),
          onHighlightSwitch: (v) => setState(() => highlightSwitch = v),
          onStepChanged: (s) => setState(() => onboardingStep = s),
        );
        setState(() => onboardingStep = -1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium!;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/spacex_logo_white.png', width: 200),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Revoir l’onboarding',
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('onboarding_done', false);
              setState(() => onboardingStep = 0);
              await showHomeOnboarding(
                context,
                onHighlightFav: (v) => setState(() => highlightFav = v),
                onHighlightSwitch: (v) => setState(() => highlightSwitch = v),
                onStepChanged: (s) => setState(() => onboardingStep = s),
              );
              setState(() => onboardingStep = -1);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: highlightFav ? Colors.amber : Colors.white,
            ),
            tooltip: "Mes favoris",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavoritesPage(isListView: isListView),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              isListView ? Icons.grid_view : Icons.format_list_bulleted_rounded,
              color: highlightSwitch ? Colors.amber : Colors.white,
            ),
            tooltip: isListView ? "Afficher en grille" : "Afficher en liste",
            onPressed: () => setState(() => isListView = !isListView),
          ),
          IconButton(
            icon: const Icon(Icons.filter_alt),
            tooltip: 'Filtrer par fusée',
            onPressed: () {
              final rockets = context.read<RocketListCubit>().state.rockets;
              showModalBottomSheet(
                context: context,
                builder: (_) => ListView(
                  children: rockets
                      .map(
                        (r) => ListTile(
                          title: Text(r.name),
                          onTap: () {
                            context.read<LaunchCubit>().filterByRocket(r.id);
                            Navigator.pop(context);
                          },
                        ),
                      )
                      .toList(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<LaunchCubit, LaunchState>(
          builder: (context, state) {
            if (state.loading)
              return const Center(child: CircularProgressIndicator());
            if (state.error != null)
              return Center(child: Text("Erreur : ${state.error}"));

            final launches = state.filteredLaunches;
            final highlightCards = onboardingStep == 1;

            if (launches.isEmpty)
              return const Center(child: Text("Aucun lancement trouvé"));

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Nombre de lancements : ${launches.length}',
                    style: style.copyWith(color: Colors.grey),
                  ),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: isListView
                        ? ListView(
                            children: [
                              for (final launch in launches)
                                LaunchListItem(
                                  launch: launch,
                                  onboardingActive: highlightCards,
                                ),
                            ],
                          )
                        : GridView.count(
                            crossAxisCount: 2,
                            children: [
                              for (final launch in launches)
                                LaunchCard(
                                  launch: launch,
                                  onboardingActive: highlightCards,
                                ),
                            ],
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
