import 'package:flutter/material.dart';

import '../widgets/modals/onboarding.modal.dart';
import 'services/onboarding.service.dart';

void showHomeOnboarding(
  BuildContext context, {
  required void Function(bool) onHighlightFav,
  required void Function(bool) onHighlightSwitch,
}) {
  _showStep0(
    context,
    onHighlightFav: onHighlightFav,
    onHighlightSwitch: onHighlightSwitch,
  );
}

void _showStep0(
  BuildContext context, {
  required void Function(bool) onHighlightFav,
  required void Function(bool) onHighlightSwitch,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => OnboardingModal(
      title: "Bienvenue",
      message:
          "Découvrez comment utiliser cette application et ses fonctions principales :) \nElle vous présente des lancements spatiaux effectués par Space X.",
      icon: const Icon(Icons.info_outline_rounded, color: Colors.transparent),
      onNext: () {
        Navigator.pop(context);
        _showStep1(
          context,
          onHighlightFav: onHighlightFav,
          onHighlightSwitch: onHighlightSwitch,
        );
      },
    ),
  );
}

void _showStep1(
  BuildContext context, {
  required void Function(bool) onHighlightFav,
  required void Function(bool) onHighlightSwitch,
}) {
  onHighlightFav(true);
  onHighlightSwitch(false);

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => OnboardingModal(
      title: "Les favoris",
      message: "Accédez à vos lancements préférés via les favoris.",
      icon: const Icon(Icons.favorite),
      onNext: () {
        onHighlightFav(false);
        onHighlightSwitch(true);
        Navigator.pop(context);
        _showStep2(
          context,
          onHighlightFav: onHighlightFav,
          onHighlightSwitch: onHighlightSwitch,
        );
      },
    ),
  );
}

void _showStep2(
  BuildContext context, {
  required void Function(bool) onHighlightFav,
  required void Function(bool) onHighlightSwitch,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => OnboardingModal(
      title: "Changer de vue d'affichage",
      message: "Basculez entre la vue liste et la vue grille.",
      icon: const Icon(Icons.format_list_bulleted_sharp),
      onNext: () {
        onHighlightSwitch(false);
        Navigator.pop(context);
        _showStep3(context);
      },
    ),
  );
}

void _showStep3(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => OnboardingModal(
      title: "Voir le détail",
      message: "Touchez un lancement pour afficher sa fiche détaillée.",
      icon: const Icon(Icons.rectangle_rounded),
      onNext: () async {
        await OnboardingService.finish();
        Navigator.pop(context);
      },
    ),
  );
}
