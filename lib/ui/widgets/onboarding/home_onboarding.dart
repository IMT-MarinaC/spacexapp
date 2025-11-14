import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_onboarding_overlay.dart';

Future<void> showHomeOnboarding2(
  BuildContext context, {
  required Rect favRect,
  required Rect viewSwitchRect,
  required Rect cardRect,
}) async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('onboarding_done') == true) return;

  await _showOverlay(
    context,
    target: favRect,
    title: "Les favoris",
    message: "Accédez à vos lancements préférés via les favoris.",
  );

  await _showOverlay(
    context,
    target: viewSwitchRect,
    title: "Changer de vue d'affichage",
    message: "Basculez entre la vue liste et la vue grille.",
  );

  await _showOverlay(
    context,
    target: cardRect,
    title: "Voir le détail",
    message: "Touchez un lancement pour afficher sa fiche détaillée.",
  );

  await prefs.setBool('onboarding_done', false);
}

Future<void> _showOverlay(
  BuildContext context, {
  required Rect target,
  required String title,
  required String message,
}) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => OnboardingOverlay(
      target: target,
      title: title,
      message: message,
      onNext: () => Navigator.pop(context),
    ),
  );
}
