import 'package:flutter/material.dart';
import 'package:spacexapp/ui/onboarding/services/rocket_detail.onboarding.service.dart';

import '../widgets/modals/onboarding.modal.dart';

void showRocketDetailOnboarding(
  BuildContext context, {
  required void Function(bool) onHighlightRocketName,
}) {
  onHighlightRocketName(true);

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => OnboardingModal(
      title: "Détail d'une fusée",
      message: "Cliquez sur le nom de la fusée pour voir ses caractéristiques.",
      icon: const Icon(Icons.rocket_launch_rounded),
      onNext: () async {
        await RocketDetailOnboardingService.finish();
        onHighlightRocketName(false);
        Navigator.pop(context);
      },
    ),
  );
}
