import 'dart:convert';
import 'package:dio/dio.dart';
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
  Rx<GetUserWiseVehicleResponseModel> userWiseVehicleList =
      Rx<GetUserWiseVehicleResponseModel>(GetUserWiseVehicleResponseModel());

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<bool> toggleDutyApiCall(
    Function(bool) onCompleteHandler, {
    Map<String, dynamic>? details,
  }) async {
    showLoading();
    var headers = {
      'Content-Type': 'application/json',
      // 'Authorization': GetStorage().read(accessToken),
    };

    try {
      var response = await ServiceCall().post(
        ApiConstant.baseUrl,
        ApiConstant.toggleDuty,
        details,
        headers,
      );

      if (response == null) {
        hideLoading();
        onCompleteHandler(false);
        return false;
      }

      var objLogin = DutyStatusResponseModel.fromJson(jsonDecode(response));
      hideLoading();
      onCompleteHandler(true);
      // approvedDialog(
      //   LocalizationStrings.success.tr,
      //   objLogin.message.toString(),
      // );
      // Future.delayed(const Duration(seconds: 2)).then((_) {
      //   objLogin.data?.userType == 0
      //       ? Get.offAllNamed('/bottomBarScreen')
      //       : Get.offAllNamed('/customerBottomBarScreen');
      // });
      return true;
    } catch (error) {
      hideLoading();
      if (error is DioException) {
        final responseData = error.response?.data;
        debugPrint('Response Data: $responseData');

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
                // final key = entry.key;
                final value = entry.value;
                if (value is List) {
                  return value.join(', ');
                  // return '$key: ${value.join(', ')}';
                } else {
                  return '$value';
                  // return '$key: $value';
                }
              })
              .join('\n');
          // declineDialog(
          //   LocalizationStrings.validationError.tr,
          //   errorMessages,
          // ).then((value) {
          //   Get.offAllNamed('/login_screen');
          // });
        } else {
          // declineDialog(
          //   LocalizationStrings.error.tr,
          //   parsedData?['message'] ?? 'An unknown error occurred',
          // );
        }
      } else {
        debugPrint('Error is not a DioException: $error');
        handleError(error);
      }
      return false;
    }
  }

  Future getData() async {
    await userWiseVehicleListCall((p0) {});
  }

  Future userWiseVehicleListCall(
    Function(bool) onCompleteHandler, {
    Map<String, dynamic>? details,
  }) async {
    Future.delayed(Duration.zero, () {
      showLoading();
    });

    var headers = {
      'Content-Type': 'application/json',
      // 'Authorization': GetStorage().read(accessToken),
    };

    try {
      var response = await ServiceCall().get(
        ApiConstant.baseUrl,
        // "${ApiConstant.userWiseVehicle}/${GetStorage().read(userId)}",
        "${ApiConstant.userWiseVehicle}/1", 
        headers,
      );

      if (response == null) {
        hideLoading();
        onCompleteHandler(false);
        return false;
      }

      userWiseVehicleList.value = GetUserWiseVehicleResponseModel.fromJson(
        jsonDecode(response),
      );

      hideLoading();
      onCompleteHandler(true);
      // approvedDialog('Success', objUserWiseVehicles.message.toString());

      return userWiseVehicleList.value;
    } catch (error) {
      hideLoading();
      if (error is DioException) {
        final responseData = error.response?.data;
        debugPrint('Response Data: $responseData');

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
          errors.entries
              .map((entry) {
                // final key = entry.key;
                final value = entry.value;
                if (value is List) {
                  return value.join(', ');
                  // return '$key: ${value.join(', ')}';
                } else {
                  return '$value';
                  // return '$key: $value';
                }
              })
              .join('\n');
        } else {
          // declineDialog(
          //   LocalizationStrings.error.tr,
          //   parsedData?['message'] ?? 'An unknown error occurred',
          // );
        }
      } else {
        debugPrint('Error is not a DioException: $error'); // Debug log
        handleError(error);
      }
      return false;
    }
  }
}
