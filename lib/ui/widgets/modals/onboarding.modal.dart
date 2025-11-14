import 'dart:ui';

import 'package:flutter/material.dart';

class OnboardingModal extends StatelessWidget {
  final String title;
  final String message;
  final Icon icon;
  final VoidCallback onNext;

  const OnboardingModal({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: const Alignment(0, 0.4),
      backgroundColor: Colors.black.withValues(alpha: 0.4),
      insetPadding: const EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall?.copyWith(color: Colors.white),
                ),
                Icon(icon.icon, size: 48, color: Colors.amber),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 6,
                  ),
                  child: const Text('Suivant'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
