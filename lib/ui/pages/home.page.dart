import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacexapp/ui/cubit/launch.cubit.dart';
import 'package:spacexapp/ui/widgets/launch_card.widget.dart';
import 'package:spacexapp/ui/widgets/launch_list_item.widget.dart';

import '../cubit/cubit.state.dart';
import '../cubit/launch.state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LaunchCubit _launchCubit = LaunchCubit();
  bool isListView = false;

  @override
  void initState() {
    super.initState();
    _launchCubit.getLaunches();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle style = Theme.of(context).textTheme.bodyMedium!;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/spacex_logo_white.png', width: 200),
        actions: [
          IconButton(
            icon: Icon(isListView ? Icons.grid_view : Icons.list),
            tooltip: isListView ? "Afficher en grille" : "Afficher en liste",
            onPressed: () {
              setState(() => isListView = !isListView);
            },
          ),
        ],
      ),

      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background7.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            BlocBuilder<LaunchCubit, LaunchState>(
              bloc: _launchCubit,
              builder: (context, state) {
                if (state is LoadingState<LaunchStateData>) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is FailureState<LaunchStateData>) {
                  return Center(
                    child: Text(
                      'Erreur : ${state.message}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }

                if (state is! SuccessState<LaunchStateData>) {
                  return const SizedBox();
                }

                final launches = state.data.launches;

                if (launches.isEmpty) {
                  return const Center(
                    child: Text(
                      'Aucun lancement trouvé',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

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
                        switchInCurve: Curves.easeOut,
                        switchOutCurve: Curves.easeIn,
                        transitionBuilder: (child, animation) =>
                            FadeTransition(opacity: animation, child: child),

                        child: isListView
                            ? ListView(
                                children: [
                                  for (final launch in launches)
                                    LaunchListItem(launch: launch),
                                ],
                              )
                            : GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                padding: const EdgeInsets.all(8),
                                children: [
                                  for (final launch in launches)
                                    LaunchCard(launch: launch),
                                ],
                              ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
