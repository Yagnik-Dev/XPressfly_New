import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Models/order_track_model.dart';
import 'package:xpressfly_git/Services/rest_service.dart';
import 'package:xpressfly_git/Constants/api_constant.dart';
import 'package:xpressfly_git/Screens/Customer/timer_service.dart';

class CustomerHistoryController extends GetxController {
  final ServiceCall _serviceCall = ServiceCall();
  final TimerService _timerService = TimerService();

  var isLoading = true.obs;
  var orderData = Rxn<OrderTrackModel>();
  var errorMessage = ''.obs;
  String? currentOrderId;

  @override
  void onInit() {
    super.onInit();
    // Get order ID from TimerService or route arguments
    _getOrderId();
  }

  /// Get order ID from TimerService or route arguments
  void _getOrderId() {
    // Try to get from route arguments first
    if (Get.arguments != null && Get.arguments['orderId'] != null) {
      currentOrderId = Get.arguments['orderId'].toString();
    } else {
      // Fallback to TimerService
      currentOrderId = _timerService.getOrderId();
    }

    if (currentOrderId != null && currentOrderId!.isNotEmpty) {
      fetchOrderProfile(currentOrderId!);
    } else {
      isLoading(false);
      errorMessage('No order ID found. Please create an order first.');
      debugPrint('No order ID found');
    }
  }

  /// Fetch order profile by order ID
  Future<void> fetchOrderProfile(String orderId) async {
    try {
      isLoading(true);
      errorMessage('');

      // Build API endpoint: /delivery/orders/:order_id/
      final apiEndpoint = '${ApiConstant.orderProfile}$orderId/';

      final response = await _serviceCall.get(ApiConstant.baseUrl, apiEndpoint);

      debugPrint('Order Profile API Response: $response');

      // Parse the response
      if (response is String) {
        final jsonData = jsonDecode(response);

        // Handle both direct OrderData or wrapped in 'data' key
        final orderJson = jsonData['data'] ?? jsonData;

        orderData.value = OrderTrackModel.fromJson(
          orderJson as Map<String, dynamic>,
        );

        log('Order Profile fetched successfully: ${orderData.value?.data?.id}');
      }
    } catch (e) {
      errorMessage('Error: ${e.toString()}');
      debugPrint('Error fetching order profile: $e');
      log('Error fetching order profile: $e');
    } finally {
      isLoading(false);
    }
  }

  /// Refresh order profile
  Future<void> refreshOrderProfile() async {
    if (currentOrderId != null && currentOrderId!.isNotEmpty) {
      await fetchOrderProfile(currentOrderId!);
    }
  }

  /// Get status display name
  String getStatusDisplayName(String? status) {
    if (status == null) return 'Unknown';

    switch (status) {
      case 'request_confirmed':
        return 'Request Confirmed';
      case 'accepted':
        return 'Accepted';
      case 'in_transit':
        return 'In Transit';
      case 'out_for_delivery':
        return 'Out for Delivery';
      case 'delivered':
        return 'Delivered';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      case 'rejected':
        return 'Rejected';
      default:
        return status;
    }
  }

  /// Check if status is active based on order status
  bool isStatusActive(String? status) {
    if (status == null) return false;

    const activeStatuses = [
      'request_confirmed',
      'accepted',
      'in_transit',
      'out_for_delivery',
    ];

    return activeStatuses.contains(status);
  }

  /// Get timeline step status based on order status
  Map<String, bool> getTimelineStatuses() {
    final status = orderData.value?.data?.status;

    return {
      'requestConfirmation':
          status != null &&
          [
            'request_confirmed',
            'accepted',
            'in_transit',
            'out_for_delivery',
            'delivered',
            'completed',
          ].contains(status),
      'inTransit':
          status != null &&
          [
            'in_transit',
            'out_for_delivery',
            'delivered',
            'completed',
          ].contains(status),
      'outForDelivery':
          status != null &&
          ['out_for_delivery', 'delivered', 'completed'].contains(status),
      'delivered':
          status != null && ['delivered', 'completed'].contains(status),
    };
  }
}
