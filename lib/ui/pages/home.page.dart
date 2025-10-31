import 'package:flutter/material.dart';
import 'package:spacexapp/data/model/launch.model.dart';
import 'package:spacexapp/ui/widgets/launch.widget.dart';

import '../data/api/launch.service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Launch>> _launchFuture;

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
      body: SafeArea(
        child: FutureBuilder(
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
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Nombre de lancements : ${launches.length}',
                      style: style.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  for (final launch in launches) LaunchListItem(launch: launch),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
