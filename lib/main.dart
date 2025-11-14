import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacexapp/ui/cubit/favorites/favorites.cubit.dart';
import 'package:spacexapp/ui/pages/home.page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR');

  final prefs = await SharedPreferences.getInstance();
  final hasSeenOnboarding = prefs.getBool('onboarding_done') ?? false;

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => FavoritesCubit())],
      child: MyApp(showOnboarding: !hasSeenOnboarding),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool showOnboarding;

  const MyApp({super.key, required this.showOnboarding});

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
