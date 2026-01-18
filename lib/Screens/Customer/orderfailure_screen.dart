import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Localization/localization_keys.dart';
import 'package:xpressfly_git/Routes/app_routes.dart';
import 'package:xpressfly_git/Services/rest_service.dart';
import 'package:xpressfly_git/Constants/api_constant.dart';
import 'dart:convert';

class OrderFailureScreen extends StatefulWidget {
  const OrderFailureScreen({super.key});

  @override
  State<OrderFailureScreen> createState() => _OrderFailureScreenState();
}

class _OrderFailureScreenState extends State<OrderFailureScreen> {
  bool _isRetrying = false;

  @override
  Widget build(BuildContext context) {
    final orderId = Get.arguments?['orderId'];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cancel_outlined, size: 80, color: Colors.red),
            const SizedBox(height: 24),
            Text(
              LocalizationKeys.orderNotConfirmed.tr,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              LocalizationKeys.noDriverAcceptedYourRequest.tr,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 48),
            _isRetrying
                ? const CircularProgressIndicator()
                : Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => _retryOrder(orderId),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.clrSecondary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 14,
                        ),
                      ),
                      child: Text(
                        LocalizationKeys.tryAgain.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Get.offAllNamed(AppRoutes.customerBottomBarScreen);
                      },
                      child: Text(
                        LocalizationKeys.backToHome.tr,
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }

  Future<void> _retryOrder(String? orderId) async {
    if (orderId == null || orderId.isEmpty) {
      Get.snackbar('Error', 'Order ID not found');
      return;
    }

    setState(() => _isRetrying = true);

    try {
      final ServiceCall serviceCall = ServiceCall();
      final String endpoint = '${ApiConstant.retryOrder}$orderId/';

      final response = await serviceCall.patch(
        ApiConstant.baseUrl,
        endpoint,
        {},
      );

      setState(() => _isRetrying = false);

      if (response != null) {
        final decodedResponse = jsonDecode(response);

        if (decodedResponse['success'] == true) {
          // Navigate back to booking screen with order data
          Get.offAllNamed(
            AppRoutes.bookAOrderMainScreen,
            arguments: {'orderId': orderId, 'isRetry': true},
          );
        } else {
          Get.snackbar('Error', 'Failed to retry order');
        }
      }
    } catch (e) {
      setState(() => _isRetrying = false);
      Get.snackbar('Error', 'Error retrying order: $e');
    }
  }
}
