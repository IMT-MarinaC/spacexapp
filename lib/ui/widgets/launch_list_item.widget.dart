import 'package:flutter/material.dart';
import 'package:spacexapp/ui/pages/launch_detail.page.dart';

import '../../data/model/launch.model.dart';

class LaunchListItem extends StatelessWidget {
  final Launch launch;

  const LaunchListItem({super.key, required this.launch});

  @override
  Widget build(BuildContext context) {
    final TextStyle style = Theme.of(context).textTheme.bodyMedium!;
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LaunchDetailPage(launch: launch),
            ),
          );
        },
        child: Row(
          children: [
            Column(
              children: [
                Semantics(
                  header: true,
                  child: Text(
                    launch.name,
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall?.copyWith(color: Colors.white),
                  ),
                ),
                Text(
                  'ID : ${launch.id}',
                  style: style.copyWith(color: Colors.white),
                ),
                Text(launch.rocket, style: style.copyWith(color: Colors.white)),
                Text(
                  launch.dateUtc.toString(),
                  style: style.copyWith(color: Colors.white),
                ),
              ],
            ),
            Image(
              image: NetworkImage(launch.links.patch?.large ?? ''),
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
