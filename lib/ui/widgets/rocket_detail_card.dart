import 'package:flutter/material.dart';

class RocketDetailCard extends StatelessWidget {
  final String name;
  final String data;
  final String? unit;

  const RocketDetailCard({
    super.key,
    required this.name,
    required this.data,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle style = Theme.of(context).textTheme.bodySmall!;
    return Container(
      padding: EdgeInsetsGeometry.directional(
        top: 4,
        end: 12,
        bottom: 8,
        start: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: const Color(0xb3303030),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(data, style: TextStyle(fontSize: 24)),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [if (unit != null) Text('$unit, '), Text(name)],
          ),
        ],
      ),
    );
  }
}
