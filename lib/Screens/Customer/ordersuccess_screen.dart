import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Localization/localization_keys.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),
              // Success Icon
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4CAF50),
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Badge shape background
                        CustomPaint(
                          size: const Size(80, 80),
                          painter: BadgePainter(),
                        ),
                        // Checkmark
                        const Icon(
                          Icons.check,
                          color: Color(0xFF4CAF50),
                          size: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Title
              Text(
                LocalizationKeys.orderSuccessful.tr,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Subtitle
              Text(
                LocalizationKeys
                    .yourOrderHasBeenPlacedAndProcessingHasStarted
                    .tr,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF757575),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              // Buttons
              Row(
                children: [
                  // Close Button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(
                          color: Color(0xFFE0E0E0),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        LocalizationKeys.close.tr,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF212121),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Track Order Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(
                            color: Color(0xFFF44336),
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        LocalizationKeys.trackYourOrder.tr,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFF44336),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom painter for the badge shape
class BadgePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final points = 8;

    for (int i = 0; i < points * 2; i++) {
      final angle = (i * 3.14159) / points;
      final r = i.isEven ? radius : radius * 0.85;
      final x = center.dx + r * cos(angle);
      final y = center.dy + r * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  double cos(double angle) => _cos(angle);
  double sin(double angle) => _sin(angle);

  double _cos(double angle) {
    const table = [
      1.0,
      0.9238795325,
      0.7071067812,
      0.3826834324,
      0.0,
      -0.3826834324,
      -0.7071067812,
      -0.9238795325,
      -1.0,
      -0.9238795325,
      -0.7071067812,
      -0.3826834324,
      0.0,
      0.3826834324,
      0.7071067812,
      0.9238795325,
    ];
    final index = ((angle / 3.14159 * 8) % 16).round();
    return table[index % 16];
  }

  double _sin(double angle) {
    return _cos(angle - 3.14159 / 2);
  }
}
