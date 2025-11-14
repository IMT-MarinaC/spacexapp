import 'package:flutter/material.dart';

import '../widgets/modals/onboarding.modal.dart';
import 'services/onboarding.service.dart';

Future<void> showHomeOnboarding(
  BuildContext context, {
  required void Function(bool) onHighlightFav,
  required void Function(bool) onHighlightSwitch,
  required void Function(int) onStepChanged,
}) async {
  await _showStep0(
    context,
    onHighlightFav: onHighlightFav,
    onHighlightSwitch: onHighlightSwitch,
    onStepChanged: onStepChanged,
  );
}

Future<void> _showStep0(
  BuildContext context, {
  required void Function(bool) onHighlightFav,
  required void Function(bool) onHighlightSwitch,
  required void Function(int) onStepChanged,
}) async {
  onStepChanged(0);
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => OnboardingModal(
      title: "Bienvenue",
      message:
          "Découvrez comment utiliser cette application et ses fonctions principales :) \nElle vous présente des lancements spatiaux effectués par Space X.",
      icon: const Icon(Icons.info_outline_rounded),
      onNext: () {
        Navigator.pop(context);
      },
    ),
  );

  await _showStep1(
    context,
    onHighlightFav: onHighlightFav,
    onHighlightSwitch: onHighlightSwitch,
    onStepChanged: onStepChanged,
  );
}

Future<void> _showStep1(
  BuildContext context, {
  required void Function(bool) onHighlightFav,
  required void Function(bool) onHighlightSwitch,
  required void Function(int) onStepChanged,
}) async {
  onStepChanged(1);
  onHighlightFav(false);
  onHighlightSwitch(false);

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => OnboardingModal(
      title: "Voir le détail",
      message: "Touchez un lancement pour afficher sa fiche détaillée.",
      icon: const Icon(Icons.rectangle_rounded),
      onNext: () {
        onHighlightFav(false);
        onHighlightSwitch(true);
        Navigator.pop(context);
      },
    ),
  );

  await _showStep2(
    context,
    onHighlightFav: onHighlightFav,
    onHighlightSwitch: onHighlightSwitch,
    onStepChanged: onStepChanged,
  );
}

Future<void> _showStep2(
  BuildContext context, {
  required void Function(bool) onHighlightFav,
  required void Function(bool) onHighlightSwitch,
  required void Function(int) onStepChanged,
}) async {
  onStepChanged(2);
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => OnboardingModal(
      title: "Changer de vue d'affichage",
      message:
          "Basculez entre la vue liste et la vue grille.\n(Jetez un coup d'oeil en haut ! Icône en haut à droite)",
      icon: const Icon(Icons.format_list_bulleted_sharp),
      onNext: () {
        onHighlightSwitch(false);
        onHighlightFav(true);
        Navigator.pop(context);
      },
    ),
  );

  await _showStep3(
    context,
    onHighlightFav: onHighlightFav,
    onStepChanged: onStepChanged,
  );
}

Future<void> _showStep3(
  BuildContext context, {
  required void Function(bool) onHighlightFav,
  required void Function(int) onStepChanged,
}) async {
  onStepChanged(3);
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => OnboardingModal(
      title: "Les favoris",
      message:
          "Accédez à vos lancements préférés via les favoris.\n(Deuxième icône en haut à droite)",
      icon: const Icon(Icons.favorite),
      onNext: () async {
        onHighlightFav(false);
        await OnboardingService.finish();
        Navigator.pop(context);
        onStepChanged(-1);
      },
      nextLabel: 'Fermer',
    ),
  );
}
