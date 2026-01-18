// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:xpressfly_git/Constants/image_constant.dart';
// import 'package:xpressfly_git/Constants/text_style_constant.dart';

// class WaitForResponseTimerScreen extends StatelessWidget {
//   const WaitForResponseTimerScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 Image.asset(ImageConstant.imgTimer, height: 200.h),
//                 Text(
//                   "07:40:47",
//                   style: TextStyleConstant().subTitleTextStyle35w700clr242424,
//                 ),
//               ],
//             ),
//             SizedBox(height: 24.h),
//             Text(
//               "Almost there",
//               style: TextStyleConstant().subTitleTextStyle25w700clr242424,
//             ),
//             SizedBox(height: 8.h),

//             Text(
//               "Looking for nearby drivers…\nYou’ll be redirected once your request is accepted.",
//               textAlign: TextAlign.center,
//               style: TextStyleConstant().subTitleTextStyle14w400ClrSubText,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Constants/api_constant.dart';
import 'package:xpressfly_git/Localization/localization_keys.dart';
import 'package:xpressfly_git/Routes/app_routes.dart';
import 'package:xpressfly_git/Screens/Customer/timer_service.dart';
import 'package:xpressfly_git/Services/rest_service.dart';
import 'package:xpressfly_git/Utility/common_imports.dart';

class WaitForResponseTimerScreen extends StatefulWidget {
  const WaitForResponseTimerScreen({super.key});

  @override
  State<WaitForResponseTimerScreen> createState() =>
      _WaitForResponseTimerScreenState();
}

class _WaitForResponseTimerScreenState extends State<WaitForResponseTimerScreen>
    with WidgetsBindingObserver {
  late Timer _timer;
  late TimerService _timerService;
  int _remainingSeconds = 600;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _timerService = TimerService();

    // Get remaining time from storage
    _remainingSeconds = _timerService.getRemainingSeconds();

    // If no active timer, start new one
    if (_remainingSeconds == 0) {
      _remainingSeconds = 600;
      _timerService.startTimer(600);
    }

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _remainingSeconds = _timerService.getRemainingSeconds();
        });

        if (_remainingSeconds <= 0) {
          timer.cancel();
          _timerService.clearTimer();
          _onTimerComplete();
        }
      }
    });
  }

  void _onTimerComplete() async {
    _timerService.clearTimer();
    if (mounted) {
      // Call the order status API to mark as delivered
      await _updateOrderStatusToDelivered();
    }
  }

  Future<void> _updateOrderStatusToDelivered() async {
    try {
      // Get order ID from storage
      final orderId = _timerService.getOrderId();

      if (orderId == null || orderId.isEmpty) {
        _navigateToFailureScreen();
        return;
      }

      final ServiceCall serviceCall = ServiceCall();
      final String endpoint = '${ApiConstant.updateOrderStatus}$orderId/';

      final Map<String, dynamic> requestBody = {"status": "delivered"};

      final response = await serviceCall.patch(
        ApiConstant.baseUrl,
        endpoint,
        requestBody,
      );

      if (response != null) {
        final decodedResponse = jsonDecode(response);

        if (decodedResponse['success'] == true ||
            decodedResponse['status'] == 'delivered') {
          _navigateToSuccessScreen();
        } else {
          _navigateToFailureScreen();
        }
      } else {
        _navigateToFailureScreen();
      }
    } catch (e) {
      debugPrint('Error updating order status: $e');
      _navigateToFailureScreen();
    }
  }

  void _navigateToSuccessScreen() {
    Get.offAllNamed(
      AppRoutes.orderSuccessScreen,
      arguments: {'orderId': _timerService.getOrderId(), 'status': 'delivered'},
    );
  }

  void _navigateToFailureScreen() {
    Get.offAllNamed(
      AppRoutes.orderFailureScreen,
      arguments: {'orderId': _timerService.getOrderId()},
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App resumed from background
      debugPrint('App resumed - checking timer status');
      _remainingSeconds = _timerService.getRemainingSeconds();

      if (_remainingSeconds <= 0) {
        // Timer expired while app was in background
        debugPrint('Timer expired while app was backgrounded');
        _onTimerComplete();
      } else {
        // Timer still running, restart it
        debugPrint(
          'Timer still active with $_remainingSeconds seconds remaining',
        );
        _timer.cancel();
        _startTimer();
      }
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      // App going to background or being terminated
      debugPrint('App paused/detached - timer continues in background');
      _timer.cancel();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  String _formatTime() {
    int hours = _remainingSeconds ~/ 3600;
    int minutes = (_remainingSeconds % 3600) ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    double progress = 1 - (_remainingSeconds / 600);

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Circular Progress Timer
              SizedBox(
                width: 260.w,
                height: 260.h,
                child: CustomPaint(
                  painter: CircularProgressPainter(progress: progress),
                  child: Center(
                    child: Text(
                      _formatTime(),
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Title
              Text(
                LocalizationKeys.almostThere.tr,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              // Subtitle
              Text(
                LocalizationKeys.lookingForNearbyDrivers.tr,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                LocalizationKeys.youllBeRedirectedOnceYourRequestIsAccepted.tr,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;

  CircularProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 20;
    final strokeWidth = 18.0;

    // Background arc (light gray)
    final backgroundPaint =
        Paint()
          ..color = Colors.grey.shade200
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Inner thin circle (closer to main circle)
    final innerCirclePaint =
        Paint()
          ..color = Colors.grey.shade300
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5;

    canvas.drawCircle(center, radius - 15.5, innerCirclePaint);

    // Only draw progress if progress > 0 to avoid gradient assertion error
    if (progress > 0) {
      // Inner progress circle (animated with gradient)
      final innerProgressRadius = radius - 15.5;
      final innerProgressRect = Rect.fromCircle(
        center: center,
        radius: innerProgressRadius,
      );

      // Ensure we have a valid angle range for SweepGradient
      final endAngle = max(-pi / 2 + 0.01, -pi / 2 + (2 * pi * progress));

      final innerGradient = SweepGradient(
        startAngle: -pi / 2,
        endAngle: endAngle,
        colors: const [
          Color(0xFFFF9500), // Orange
          Color(0xFFFF8C42), // Light orange
          Color(0xFFFF7B5F), // Coral
          Color(0xFFFF6B7A), // Pink coral
        ],
        transform: const GradientRotation(-pi / 2),
      );

      final innerProgressPaint =
          Paint()
            ..shader = innerGradient.createShader(innerProgressRect)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.5
            ..strokeCap = StrokeCap.round;

      // Draw inner progress arc
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: innerProgressRadius),
        -pi / 2,
        2 * pi * progress,
        false,
        innerProgressPaint,
      );

      // Progress gradient (orange to coral) - outer circle
      final progressRect = Rect.fromCircle(center: center, radius: radius);
      final gradient = SweepGradient(
        startAngle: -pi / 2,
        endAngle: endAngle,
        colors: const [
          Color(0xFFFF9500), // Orange
          Color(0xFFFF8C42), // Light orange
          Color(0xFFFF7B5F), // Coral
          Color(0xFFFF6B7A), // Pink coral
        ],
        transform: const GradientRotation(-pi / 2),
      );

      final progressPaint =
          Paint()
            ..shader = gradient.createShader(progressRect)
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth
            ..strokeCap = StrokeCap.round;

      // Draw progress arc
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2,
        2 * pi * progress,
        false,
        progressPaint,
      );

      // Draw circle at current progress position
      final currentAngle = -pi / 2 + (2 * pi * progress);
      final currentX = center.dx + radius * cos(currentAngle);
      final currentY = center.dy + radius * sin(currentAngle);

      final currentCirclePaint =
          Paint()
            ..color = const Color(0xFFFF6B7A)
            ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(currentX, currentY), 8, currentCirclePaint);
    }

    // Draw small circle at start of progress (always visible)
    final startAngle = -pi / 2;
    final startX = center.dx + radius * cos(startAngle);
    final startY = center.dy + radius * sin(startAngle);
    final startCirclePaint =
        Paint()
          ..color = const Color(0xFFFF9500)
          ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(startX, startY), 8, startCirclePaint);
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
