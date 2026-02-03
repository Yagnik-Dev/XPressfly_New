import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Models/order_request_model.dart';
import 'package:xpressfly_git/Services/rest_service.dart';
import 'package:xpressfly_git/Constants/api_constant.dart';

class OrderHistoryController extends GetxController {
  final ServiceCall _serviceCall = ServiceCall();

  var isLoading = true.obs;
  var orderList = <OrderData>[].obs;
  var activeOrders = <OrderData>[].obs;
  var pastOrders = <OrderData>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  /// Fetch orders from API
  Future<void> fetchOrders() async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await _serviceCall.get(
        ApiConstant.baseUrl,
        ApiConstant.orderList,
      );

      debugPrint('API Response: $response');

      // Parse the response
      if (response is String) {
        final jsonData = jsonDecode(response);
        final List<dynamic> ordersJson = jsonData['data'] ?? [];

        orderList.assignAll(
          ordersJson
              .map((order) => OrderData.fromJson(order as Map<String, dynamic>))
              .toList(),
        );
      }

      log('Total orders fetched: ${orderList.length}');

      // Separate active and past orders using status checker
      activeOrders.assignAll(
        orderList.where((order) => OrderStatus.isActive(order.status)).toList(),
      );

      pastOrders.assignAll(
        orderList.where((order) => OrderStatus.isPast(order.status)).toList(),
      );

      log('Active orders: ${activeOrders.length}');
      log('Past orders: ${pastOrders.length}');

      if (activeOrders.isEmpty && pastOrders.isEmpty) {
        errorMessage('No orders found');
      }
    } catch (e) {
      errorMessage('Error: ${e.toString()}');
      debugPrint('Error fetching orders in customer flow order history: $e');
      log('Error fetching orders in customer flow order history: $e');
    } finally {
      isLoading(false);
    }
  }

  /// Refresh orders
  Future<void> refreshOrders() async {
    await fetchOrders();
  }

  /// Get status display name
  String getStatusDisplayName(String? status) {
    return OrderStatus.getDisplayName(status);
  }

  /// Get status color
  Map<int, int> getStatusColor(String? status) {
    return OrderStatus.getStatusColor(status);
  }

  /// Format date utility function
  String? formatDate(String? dateString) {
    if (dateString == null) return null;
    try {
      final date = DateTime.parse(dateString);
      return date.toLocal().toString().split(' ')[0];
    } catch (e) {
      return dateString;
    }
  }
}

// ==================== Status Constants ====================

class OrderStatus {
  // Active Order Statuses
  static const String rejected = 'rejected';
  static const String unavailable = 'unavailable';
  static const String accepted = 'accepted';
  // static const String awaitingForDriver = 'awaiting_for_driver';
  static const String inTransit = 'in_transit';
  static const String requestConfirmed = 'request_confirmed';
  static const String delivered = 'delivered';
  static const String failed = 'failed';
  static const String retry = 'retry';

  // Past Order Statuses
  static const String completed = 'completed';
  static const String cancelled = 'cancelled';

  // All Active Statuses List
  static const List<String> activeStatuses = [
    rejected,
    unavailable,
    accepted,
    // awaitingForDriver,
    inTransit,
    requestConfirmed,
    delivered,
    failed,
    retry,
  ];

  // All Past Statuses List
  static const List<String> pastStatuses = [completed, cancelled, delivered];

  // Check if status is active
  static bool isActive(String? status) {
    return status != null && activeStatuses.contains(status);
  }

  // Check if status is past
  static bool isPast(String? status) {
    return status != null && pastStatuses.contains(status);
  }

  // Get status display name
  static String getDisplayName(String? status) {
    switch (status) {
      case rejected:
        return 'Rejected';
      case unavailable:
        return 'Unavailable';
      case accepted:
        return 'Accepted';
      // case awaitingForDriver:
      // return 'Awaiting Driver';
      case inTransit:
        return 'In Transit';
      case requestConfirmed:
        return 'Request Confirmed';
      case delivered:
        return 'Delivered';
      case failed:
        return 'Failed';
      case retry:
        return 'Retry';
      case completed:
        return 'Completed';
      case cancelled:
        return 'Cancelled';
      default:
        return status ?? 'Unknown';
    }
  }

  // Get status color
  static Map<int, int> getStatusColor(String? status) {
    switch (status) {
      case accepted:
        return {0: 0xFF008000}; // Green
      case inTransit:
        return {0: 0xFF1E88E5}; // Blue
      case delivered:
        return {0: 0xFF00AA00}; // Dark Green
      case completed:
        return {0: 0xFF00AA00}; // Dark Green
      case rejected:
      case cancelled:
        return {0: 0xFFD32F2F}; // Red
      case failed:
        return {0: 0xFFFF6F00}; // Orange
      case retry:
        return {0: 0xFFFBC02D}; // Amber
      case unavailable:
      // case awaitingForDriver:
      case requestConfirmed:
        return {0: 0xFF616161}; // Grey
      default:
        return {0: 0xFF757575}; // Default Grey
    }
  }
}
