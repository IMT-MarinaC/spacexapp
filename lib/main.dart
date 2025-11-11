import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:spacexapp/ui/pages/home.page.dart';

void main() async {
  await initializeDateFormatting('fr_FR');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Space X Launches App',
    theme: ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Roboto',
      useMaterial3: true,
    ),
    home: HomePage(),
  );
}
