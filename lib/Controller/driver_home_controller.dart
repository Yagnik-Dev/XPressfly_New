import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Models/dutystatus_model.dart';
import 'package:xpressfly_git/Models/get_user_wise_vehicle_model.dart';
import 'package:xpressfly_git/Models/get_vehicle_type.dart';
import 'package:xpressfly_git/Utility/api_error_handler.dart';
import 'package:xpressfly_git/Utility/app_utility.dart';
import '../Constants/api_constant.dart';
import '../Services/rest_service.dart';
import '../Utility/common_imports.dart';

class DriverHomeController extends GetxController {
  var isSwitched = true.obs;
  var isLoading = false.obs;
  var isVehicleLoading = false.obs;
  Rx<GetUserWiseVehicleResponseModel> userWiseVehicleList =
      GetUserWiseVehicleResponseModel().obs;
  Rx<GetVehicleTypeResponseModel> vehicleTypeList =
      GetVehicleTypeResponseModel().obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    await vehicleTypesAPICall();
    await userWiseVehicleListCall();
  }

  Future<void> refreshVehicleList() async {
    isVehicleLoading.value = true;
    await userWiseVehicleListCall();
    Get.back();
    isVehicleLoading.value = false;
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
      handleError(error);
      return false;
    }
  }

  Future<void> vehicleTypesAPICall() async {
    isVehicleLoading.value = true;

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': GetStorage().read(accessToken),
      };

      var response = await ServiceCall().get(
        ApiConstant.baseUrl,
        // "${ApiConstant.userWiseVehicle}/1",
        ApiConstant.vehicleTypes,
        headers,
      );

      if (response == null) {
        throw Exception('No response from server');
      }

      var parsedResponse = GetVehicleTypeResponseModel.fromJson(
        jsonDecode(response),
      );

      // if (parsedResponse.message ?? false) {
      vehicleTypeList.value = parsedResponse;
      // } else {
      //   throw Exception(parsedResponse.message ?? 'Failed to load vehicles');
      // }
    } catch (error) {
      // errorMessage.value = error is DioException
      //     ? error.response?.data?['message'] ?? error.message ?? 'Network error occurred'
      //     : error.toString();
      debugPrint('Error loading vehicle Types: $error');
    } finally {
      isVehicleLoading.value = false;
    }
  }

  Future<void> userWiseVehicleListCall() async {
    isVehicleLoading.value = true;

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': GetStorage().read(accessToken),
      };

      var response = await ServiceCall().get(
        ApiConstant.baseUrl,
        // "${ApiConstant.userWiseVehicle}/1",
        ApiConstant.vehicleList,
        headers,
      );

      if (response == null) {
        throw Exception('No response from server');
      }

      var parsedResponse = GetUserWiseVehicleResponseModel.fromJson(
        jsonDecode(response),
      );

      // if (parsedResponse[] ?? false) {
      userWiseVehicleList.value = parsedResponse;
      // } else {
      //   throw Exception(parsedResponse.message ?? 'Failed to load vehicles');
      // }
    } catch (error) {
      hideLoading();
      String userMessage = 'An unknown error occurred';

      if (error is DioException) {
        final responseData = error.response?.data;
        debugPrint('Response Data: $responseData');

        Map<String, dynamic>? parsedData;
        if (responseData is String) {
          try {
            parsedData = jsonDecode(responseData) as Map<String, dynamic>?;
          } catch (e) {
            debugPrint('Failed to parse responseData string: $e');
          }
        } else if (responseData is Map) {
          parsedData = Map<String, dynamic>.from(responseData);
        }

        if (parsedData != null) {
          // prefer common keys returned by APIs
          if (parsedData['detail'] != null) {
            userMessage = parsedData['detail'].toString();
          } else if (parsedData['message'] != null) {
            userMessage = parsedData['message'].toString();
          } else if (parsedData['error'] != null) {
            userMessage = parsedData['error'].toString();
          } else if (parsedData['errors'] != null) {
            final errors = parsedData['errors'] as Map<String, dynamic>;
            userMessage = errors.entries
                .map((entry) {
                  final value = entry.value;
                  if (value is List) return value.join(', ');
                  return value.toString();
                })
                .join('\n');
          }
        } else {
          // fallback to DioException message if available
          userMessage = error.message ?? userMessage;
        }

        // show to user (use dialog or snackbar as you prefer)
        declineDialog("Error", userMessage).then((_) {
          // optional navigation or other handling
        });
        // or simply show snackbar:
        // showError(userMessage);
      } else {
        debugPrint('Error is not a DioException: $error');
        handleError(error);
      }
    } finally {
      isVehicleLoading.value = false;
    }
  }

  void showError(String message) {
    // You can use your preferred way to show error messages
    Get.snackbar(
      'Error',
      message,
      backgroundColor: ColorConstant.clrError,
      colorText: Colors.white,
    );
  }

  void showSuccess(String message) {
    // You can use your preferred way to show success messages
    Get.snackbar(
      'Success',
      message,
      backgroundColor: ColorConstant.clr242424,
      colorText: Colors.white,
    );
  }
}
