import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Models/dutystatus_model.dart';
import 'package:xpressfly_git/Models/get_user_wise_vehicle_model.dart';
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
      handleError(error);
      return false;
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
