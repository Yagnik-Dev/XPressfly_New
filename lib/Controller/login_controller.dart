import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Constants/api_constant.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Models/register_model.dart';
import 'package:xpressfly_git/Services/rest_service.dart';
import 'package:xpressfly_git/Utility/api_error_handler.dart';
import 'package:xpressfly_git/Utility/app_utility.dart';

class LoginController extends GetxController {
  var phoneTextEditingController = TextEditingController();
  var nameTextEditingController = TextEditingController();
  var cityTextEditingController = TextEditingController();
  var pincodeTextEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyYourDetails = GlobalKey<FormState>();

  Future<bool> registerApiCall(
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
        ApiConstant.register,
        details,
        headers,
      );

      if (response == null) {
        hideLoading();
        onCompleteHandler(false);
        return false;
      }

      var objLogin = RegisterUserResponseModel.fromJson(jsonDecode(response));
      GetStorage().write(accessToken, 'Bearer ${objLogin.token}');
      GetStorage().write(userId, objLogin.user?.id);
      GetStorage().write(userType, objLogin.user?.userType);
      GetStorage().write(userName, objLogin.user?.name);
      GetStorage().write(userPhone, objLogin.user?.mobileNumber);
      GetStorage().write(userAddress, objLogin.user?.city);
      GetStorage().write(userPincode, objLogin.user?.pincode);
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
        debugPrint('Response Data: $responseData'); // Debug log

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
}
