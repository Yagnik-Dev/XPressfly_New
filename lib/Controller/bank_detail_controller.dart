import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Constants/api_constant.dart';
import 'package:xpressfly_git/Models/otp_model.dart';
import 'package:xpressfly_git/Services/rest_service.dart';
import 'package:xpressfly_git/Utility/api_error_handler.dart';
import '../Utility/app_utility.dart';
import 'package:dio/src/form_data.dart' as formdata;

class BankDetailController extends GetxController {
  var bankAccountNumberController = TextEditingController();
  var bankAccountNameController = TextEditingController();
  var bankIFSCController = TextEditingController();

  final GlobalKey<FormState> bankDetailFormKey = GlobalKey<FormState>();

  Future<bool> createDriverApiCall(
    Function(bool) onCompleteHandler, {
    formdata.FormData? details,
  }) async {
    showLoading();
    var headers = {
      'Content-Type': 'application/json',
      // 'Authorization': GetStorage().read(accessToken),
    };

    try {
      var response = await ServiceCall().postMultipart(
        ApiConstant.baseUrl,
        ApiConstant.createDriver,
        details,
        headers,
      );

      if (response == null) {
        hideLoading();
        onCompleteHandler(false);
        return false;
      }

      var objLogin = OtpResponseModel.fromJson(jsonDecode(response));
      // GetStorage().write(accessToken, 'Bearer ${objLogin.token}');
      // GetStorage().write(userId, objLogin.user?.id);
      // GetStorage().write(userType, objLogin.user?.userType);
      // GetStorage().write(userName, objLogin.user?.name);
      // GetStorage().write(userPhone, objLogin.user?.mobileNumber);
      // GetStorage().write(userAddress, objLogin.user?.city);
      // GetStorage().write(userPincode, objLogin.user?.pincode);
      hideLoading();
      onCompleteHandler(true);
      approvedDialog('Success', objLogin.message.toString());
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
          declineDialog(
            "Error",
            parsedData?['message'] ?? 'An unknown error occurred',
          );
        }
      } else {
        debugPrint('Error is not a DioException: $error');
        handleError(error);
      }
      return false;
    }
  }
}
