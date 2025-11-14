import 'package:flutter/material.dart';

import '../../services/onboarding.service.dart';
import 'home_onboarding.modal.dart';

void showHomeOnboarding(BuildContext context) {
  _showStep1(context);
}

void _showStep1(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => OnboardingModal(
      title: "Les favoris",
      message: "Accédez à vos lancements préférés via les favoris.",
      onNext: () {
        Navigator.pop(context);
        _showStep2(context);
      },
    ),
  );
}

void _showStep2(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => OnboardingModal(
      title: "Changer de vue d'affichage",
      message: "Basculez entre la vue liste et la vue grille.",
      onNext: () {
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
      onNext: () async {
        await OnboardingService.finish();
        Navigator.pop(context);
      },
    ),
  );
}
