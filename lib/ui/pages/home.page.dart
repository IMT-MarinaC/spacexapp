import 'package:flutter/material.dart';
import 'package:spacexapp/data/model/launch.model.dart';
import 'package:spacexapp/ui/widgets/launch_card.widget.dart';
import 'package:spacexapp/ui/widgets/launch_list_item.widget.dart';

import '../../data/api/launch.service.dart';
import 'favorites.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Launch>> _launchFuture;
  var isListView = false;

  @override
  void initState() {
    super.initState();
    _launchFuture = getAll().then((list) {
      return list;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle style = Theme.of(context).textTheme.bodyMedium!;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/spacex_logo_white.png', width: 200),

        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.white),
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
            icon: Icon(isListView ? Icons.grid_view : Icons.list),
            tooltip: isListView ? "Afficher en grille" : "Afficher en liste",
            onPressed: () {
              setState(() {
                isListView = !isListView;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background7.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            FutureBuilder(
              future: _launchFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erreur : ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Aucun lancement trouvé'));
                } else {
                  final launches = snapshot.data!;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Nombre de lancements : ${launches.length}.',
                          style: style.copyWith(color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          switchInCurve: Curves.decelerate,
                          switchOutCurve: Curves.decelerate,
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
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
