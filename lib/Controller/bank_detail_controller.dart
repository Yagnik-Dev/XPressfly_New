import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Constants/api_constant.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Models/create_driver_model.dart';
import 'package:xpressfly_git/Services/rest_service.dart';
import 'package:xpressfly_git/Utility/api_error_handler.dart';
import '../Utility/app_utility.dart';
// ignore: implementation_imports
import 'package:dio/src/form_data.dart' as formdata;

class BankDetailController extends GetxController {
  var bankAccountNumberController = TextEditingController();
  var bankAccountNameController = TextEditingController();
  var bankIFSCController = TextEditingController(text: "HDFC0001234");

  final GlobalKey<FormState> bankDetailFormKey = GlobalKey<FormState>();

  Future<bool> createDriverApiCall(
    Function(bool) onCompleteHandler, {
    formdata.FormData? details,
  }) async {
    Future.delayed(Duration.zero, () {
      showLoading();
    });
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

      var objCreateDriver = CreateDriverResponseModel.fromJson(
        jsonDecode(response),
      );
      GetStorage().write(accessToken, 'Bearer ${objCreateDriver.accessToken}');
      GetStorage().write(userId, objCreateDriver.user?.id);
      GetStorage().write(userRole, objCreateDriver.user?.role);
      GetStorage().write(userName, objCreateDriver.user?.name);
      GetStorage().write(userPhone, objCreateDriver.user?.phone);
      GetStorage().write(userAddress, objCreateDriver.user?.city);
      GetStorage().write(userPincode, objCreateDriver.user?.pincode);
      hideLoading();
      onCompleteHandler(true);
      approvedDialog('Success', objCreateDriver.message.toString());
      Future.delayed(const Duration(seconds: 2)).then((_) {
        Get.offAllNamed('/driver_home_screen');
      });
      return true;
    } catch (error) {
      hideLoading();
      if (error is DioException) {
        final responseData = error.response?.data;
        debugPrint('Response Data: $responseData'); // Debug log

        final errorMessage = _formatErrorMessage(responseData);
        declineDialog("Error", errorMessage);
      } else {
        debugPrint('Error is not a DioException: $error');
        handleError(error);
      }
      return false;
    }
  }
}

String _formatErrorMessage(dynamic responseData) {
  try {
    // If server returned a JSON string, try to decode it
    if (responseData is String) {
      try {
        responseData = jsonDecode(responseData);
      } catch (_) {
        // not JSON, treat as plain text message
        return responseData;
      }
    }

    // If it's a map, handle known keys
    if (responseData is Map<String, dynamic>) {
      // 1) "errors": { "field": ["msg", ...], ... }
      if (responseData.containsKey('errors')) {
        final errors = responseData['errors'];
        if (errors is Map) {
          final messages = <String>[];
          errors.forEach((key, value) {
            if (value is List) {
              messages.add(value.join(', '));
            } else if (value is String) {
              messages.add(value);
            } else {
              messages.add(value.toString());
            }
          });
          return messages.join('\n');
        } else if (errors is List) {
          return errors.join('\n');
        } else {
          return errors.toString();
        }
      }

      // 2) direct message fields: "message", "error"
      final parts = <String>[];
      if (responseData['message'] != null)
        parts.add(responseData['message'].toString());
      if (responseData['error'] != null)
        parts.add(responseData['error'].toString());

      // 3) field-specific top-level messages, e.g. "bank_account": "Failed..."
      responseData.forEach((key, value) {
        if (key != 'message' && key != 'errors' && key != 'error') {
          if (value is String)
            parts.add(value);
          else if (value is List)
            parts.add(value.join(', '));
        }
      });

      if (parts.isNotEmpty) return parts.join('\n');

      // fallback: stringify whole map
      return responseData.toString();
    }

    // fallback for any other types
    return responseData?.toString() ?? 'An unknown error occurred';
  } catch (e) {
    debugPrint('Error formatting response data: $e');
    return 'An unknown error occurred';
  }
}
