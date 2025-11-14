import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacexapp/data/api/launch.service.dart';
import 'package:spacexapp/data/model/launch.model.dart';
import 'package:spacexapp/ui/widgets/launch_list_item.widget.dart';

import '../cubit/favorites/favorites.cubit.dart';
import '../cubit/favorites/favorites.state.dart';
import '../widgets/launch_card.widget.dart';

class FavoritesPage extends StatefulWidget {
  final bool isListView;

  const FavoritesPage({super.key, required this.isListView});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<List<Launch>> _launches;

  @override
  void initState() {
    super.initState();
    _launches = getAll();
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium!;

    return Scaffold(
      appBar: AppBar(title: const Text("Mes favoris")),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, favState) {
          return FutureBuilder(
            future: _launches,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final allLaunches = snapshot.data!;
              final favLaunches = allLaunches
                  .where((launch) => favState.isFavorite(launch.id))
                  .toList();

              if (favLaunches.isEmpty) {
                return Center(
                  child: Text(
                    "Aucun favori pour le moment ❤️",
                    style: style.copyWith(color: Colors.grey),
                  ),
                );
              }

              return widget.isListView
                  ? ListView(
                      padding: const EdgeInsets.all(8),
                      children: [
                        for (final launch in favLaunches)
                          LaunchListItem(launch: launch),
                      ],
                    )
                  : GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      padding: const EdgeInsets.all(8),
                      children: [
                        for (final launch in favLaunches)
                          LaunchCard(launch: launch),
                      ],
                    );
            },
          );
        },
      ),
    );
  }
}
