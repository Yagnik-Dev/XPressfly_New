import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Models/dutystatus_model.dart';
import 'package:xpressfly_git/Models/get_user_wise_vehicle_model.dart';
import 'package:xpressfly_git/Utility/app_utility.dart';
import '../Constants/api_constant.dart';
import '../Services/rest_service.dart';
import '../Utility/common_imports.dart';

class DriverHomeController extends GetxController {
  var isSwitched = true.obs;
  var isLoading = false.obs;
  var isVehicleLoading = false.obs;
  // var hasError = false.obs;
  // var errorMessage = ''.obs;

  Rx<GetUserWiseVehicleResponseModel> userWiseVehicleList =
      GetUserWiseVehicleResponseModel().obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    await userWiseVehicleListCall();
  }

  Future<bool> toggleDutyApiCall({Map<String, dynamic>? details}) async {
    showLoading();

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': GetStorage().read(accessToken),
      };

      var response = await ServiceCall().post(
        ApiConstant.baseUrl,
        ApiConstant.toggleDuty,
        details,
        headers,
      );

      if (response == null) {
        hideLoading();
        showError('No response from server');
        return false;
      }

      var objLogin = DutyStatusResponseModel.fromJson(jsonDecode(response));
      hideLoading();

      if (objLogin.success ?? false) {
        showSuccess(objLogin.message ?? 'Duty status updated successfully');
        return true;
      } else {
        showError(objLogin.message ?? 'Failed to update duty status');
        return false;
      }
    } catch (error) {
      hideLoading();
      handleApiError(error);
      return false;
    }
  }

  Future<void> userWiseVehicleListCall() async {
    isVehicleLoading.value = true;

    try {
      var headers = {
        'Content-Type': 'application/json',
        // 'Authorization': GetStorage().read(accessToken),
      };

      var response = await ServiceCall().get(
        ApiConstant.baseUrl,
        "${ApiConstant.userWiseVehicle}/1",
        // "${ApiConstant.userWiseVehicle}/${GetStorage().read(userId)}",
        headers,
      );

      if (response == null) {
        throw Exception('No response from server');
      }

      var parsedResponse = GetUserWiseVehicleResponseModel.fromJson(
        jsonDecode(response),
      );

      if (parsedResponse.success ?? false) {
        userWiseVehicleList.value = parsedResponse;
      } else {
        throw Exception(parsedResponse.message ?? 'Failed to load vehicles');
      }
    } catch (error) {
      // errorMessage.value = error is DioException
      //     ? error.response?.data?['message'] ?? error.message ?? 'Network error occurred'
      //     : error.toString();
      debugPrint('Error loading vehicles: $error');
    } finally {
      isVehicleLoading.value = false;
    }
  }

  void handleApiError(dynamic error) {
    if (error is DioException) {
      final responseData = error.response?.data;
      Map<String, dynamic>? parsedData;

      if (responseData is String) {
        try {
          parsedData = jsonDecode(responseData);
        } catch (e) {
          debugPrint('Failed to parse responseData: $e');
        }
      } else if (responseData is Map<String, dynamic>) {
        parsedData = responseData;
      }

      if (parsedData != null && parsedData['errors'] != null) {
        final errors = parsedData['errors'] as Map<String, dynamic>;
        final errorMessages = errors.entries
            .map((entry) {
              final value = entry.value;
              if (value is List) {
                return value.join(', ');
              } else {
                return '$value';
              }
            })
            .join('\n');
        showError(errorMessages);
      } else {
        showError(parsedData?['message'] ?? 'An unknown error occurred');
      }
    } else {
      debugPrint('Error is not a DioException: $error');
      showError('An unexpected error occurred');
    }
  }

  void showError(String message) {
    // You can use your preferred way to show error messages
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void showSuccess(String message) {
    // You can use your preferred way to show success messages
    Get.snackbar(
      'Success',
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
