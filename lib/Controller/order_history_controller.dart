import 'dart:convert';
import 'package:get/get.dart';
import 'package:xpressfly_git/Models/orderlist_model.dart';
import 'package:xpressfly_git/Services/rest_service.dart';
import 'package:xpressfly_git/Constants/api_constant.dart';

class OrderHistoryController extends GetxController {
  var isLoading = true.obs;
  var orderList = <Data>[].obs;
  var activeOrders = <Data>[].obs;
  var pastOrders = <Data>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await ServiceCall().get(
        ApiConstant.baseUrl,
        ApiConstant.orderList,
      );

      // Parse the response
      Map<String, dynamic> jsonResponse;
      if (response is String) {
        jsonResponse = jsonDecode(response);
      } else {
        jsonResponse = response;
      }

      final orderListModel = OrderListResponseModel.fromJson(jsonResponse);
      orderList.assignAll(orderListModel.data ?? []);

      // Separate active and past orders based on status
      activeOrders.assignAll(
        orderList
            .where(
              (order) =>
                  order.status == 'active' ||
                  order.status == 'pending' ||
                  order.status == 'awaiting_for_driver',
            )
            .toList(),
      );

      pastOrders.assignAll(
        orderList
            .where(
              (order) =>
                  order.status == 'completed' ||
                  order.status == 'cancelled' ||
                  order.status == 'delivered',
            )
            .toList(),
      );

      if (activeOrders.isEmpty && pastOrders.isEmpty) {
        errorMessage('No orders found');
      }
    } catch (e) {
      errorMessage('Error: ${e.toString()}');
      print('Error fetching orders: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshOrders() async {
    await fetchOrders();
  }
}
