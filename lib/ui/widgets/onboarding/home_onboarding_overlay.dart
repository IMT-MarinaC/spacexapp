import 'dart:ui';

import 'package:flutter/material.dart';

class OnboardingOverlay extends StatelessWidget {
  final Rect target;
  final String title;
  final String message;
  final VoidCallback onNext;
  final ArrowPosition arrow;

  const OnboardingOverlay({
    super.key,
    required this.target,
    required this.title,
    required this.message,
    required this.onNext,
    this.arrow = ArrowPosition.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: CustomPaint(
            size: MediaQuery.of(context).size,
            painter: _HighlightPainter(target),
          ),
        ),

        Positioned(
          left: target.center.dx - 15,
          top: arrow == ArrowPosition.top
              ? target.top - 40
              : target.bottom + 10,
          child: Icon(
            arrow == ArrowPosition.top
                ? Icons.keyboard_arrow_down
                : Icons.keyboard_arrow_up,
            size: 40,
            color: Colors.white,
          ),
        ),

        Positioned(
          top: target.bottom + 70,
          left: 20,
          right: 20,
          child: _bubble(context),
        ),
      ],
    );
  }

  Widget _bubble(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            border: Border.all(color: Colors.white24),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: onNext, child: const Text("Suivant")),
            ],
          ),
        ),
      ),
    );
  }
}

enum ArrowPosition { top, bottom }

class _HighlightPainter extends CustomPainter {
  final Rect target;

  _HighlightPainter(this.target);

  @override
  void paint(Canvas canvas, Size size) {
    final overlayPaint = Paint()..color = Colors.black.withOpacity(0.75);

    final holePath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(
        RRect.fromRectAndRadius(target.inflate(8), const Radius.circular(12)),
      )
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(holePath, overlayPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
