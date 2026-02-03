import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Constants/api_constant.dart';
import 'package:xpressfly_git/Models/order_request_model.dart';
import 'package:xpressfly_git/Services/rest_service.dart';
import 'package:xpressfly_git/Controller/order_history_controller.dart';

class OrderRequestController extends GetxController {
  // Observable variables
  final RxList<OrderData> orderList = <OrderData>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString processingOrderId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrderList();
  }

  /// Fetch order list from API
  Future<void> fetchOrderList({String status = 'awaiting'}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await ServiceCall().getWithQueryParameters(
        ApiConstant.baseUrl,
        ApiConstant.orderList,
        {'status': status},
      );

      debugPrint('API Response: $response');

      if (response is String) {
        final jsonData = jsonDecode(response);
        final List<dynamic> ordersJson = jsonData['data'] ?? [];

        orderList.value =
            ordersJson
                .map(
                  (order) => OrderData.fromJson(order as Map<String, dynamic>),
                )
                .toList();
      } else {
        orderList.value = [];
      }
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.statusCode}');
      if (e.response?.statusCode == 403) {
        errorMessage.value =
            'Your account is not verified. Please verify your account to accept orders.';
      } else {
        // errorMessage.value = e.message ?? 'Error fetching orders';
      }
    } catch (e) {
      debugPrint('Error fetching orders: $e');
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// Accept order - calls PATCH endpoint
  Future<bool> acceptOrder(String orderId, int vehicleTypeId) async {
    try {
      processingOrderId.value = orderId;
      debugPrint('Accepting order: $orderId');
      debugPrint('Vehicle Type ID: $vehicleTypeId');

      final requestBody = {'vehicle': vehicleTypeId, 'status': 'accepted'};
      debugPrint('Request Body: $requestBody');

      final response = await ServiceCall().patch(
        ApiConstant.baseUrl,
        "${ApiConstant.updateOrderStatus}$orderId/",
        requestBody,
      );

      debugPrint('Accept Order Response: $response');

      if (response != null) {
        orderList.removeWhere((order) => order.id == orderId);

        // Refresh order history controller and wait for it to complete
        await _refreshOrderHistoryAsync();

        debugPrint('Order accepted successfully: $orderId');
        return true;
      }

      return false;
    } catch (e) {
      debugPrint('Error accepting order: $e');
      errorMessage.value = 'Failed to accept order: ${e.toString()}';
      return false;
    } finally {
      processingOrderId.value = '';
    }
  }

  /// Reject order - calls PATCH endpoint
  Future<bool> rejectOrder(String orderId, int vehicleTypeId) async {
    try {
      processingOrderId.value = orderId;
      debugPrint('Rejecting order: $orderId');
      debugPrint('Vehicle Type ID: $vehicleTypeId');

      final requestBody = {'vehicle': vehicleTypeId, 'status': 'rejected'};
      debugPrint('Request Body: $requestBody');

      final response = await ServiceCall().patch(
        ApiConstant.baseUrl,
        "${ApiConstant.updateOrderStatus}$orderId/",
        requestBody,
      );

      debugPrint('Reject Order Response: $response');

      if (response != null) {
        orderList.removeWhere((order) => order.id == orderId);

        // Refresh order history controller and wait for it to complete
        await _refreshOrderHistoryAsync();

        debugPrint('Order rejected successfully: $orderId');
        return true;
      }

      return false;
    } catch (e) {
      debugPrint('Error rejecting order: $e');
      errorMessage.value = 'Failed to reject order: ${e.toString()}';
      return false;
    } finally {
      processingOrderId.value = '';
    }
  }

  /// Refresh order history if controller exists (async version)
  Future<void> _refreshOrderHistoryAsync() async {
    try {
      if (Get.isRegistered<OrderHistoryController>()) {
        final historyController = Get.find<OrderHistoryController>();
        await historyController.fetchOrders();
      }
    } catch (e) {
      debugPrint('Error refreshing order history: $e');
    }
  }

  /// Refresh order list
  Future<void> refreshOrderList() async {
    await fetchOrderList();
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

  /// Clear error message
  void clearError() {
    errorMessage.value = '';
  }

  /// Check if order is processing
  bool isOrderProcessing(String orderId) {
    return processingOrderId.value == orderId;
  }
}
