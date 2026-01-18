import 'dart:convert';
import 'dart:io';
// ignore: implementation_imports
import 'package:dio/src/form_data.dart' as formdata;
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xpressfly_git/Constants/api_constant.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Controller/profile_controller.dart';
import 'package:xpressfly_git/Models/create_customer_model.dart';
import 'package:xpressfly_git/Services/rest_service.dart';
import 'package:xpressfly_git/Utility/api_error_handler.dart';
import 'package:xpressfly_git/Utility/app_utility.dart';
import 'package:xpressfly_git/Utility/common_imports.dart';

class VerificationController extends GetxController {
  Rx<File?> aadharFrontImg = Rx<File?>(null);
  Rx<File?> aadharBackImg = Rx<File?>(null);
  Rx<File?> licenseFrontImg = Rx<File?>(null);
  Rx<File?> licenseBackImg = Rx<File?>(null);
  var imgPicker = ImagePicker();

  Future<void> pickImage(ImageSource source, Rx<File?> imageFile) async {
    final pickedFile = await imgPicker.pickImage(source: source);

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  Future<bool> createCustomerApiCall(
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
      var response = await ServiceCall().postMultipartNoAuth(
        ApiConstant.baseUrl,
        ApiConstant.createCustomer,
        details,
        headers,
      );

      if (response == null) {
        hideLoading();
        onCompleteHandler(false);
        return false;
      }

      var objLogin = CreateCustomerResponseModel.fromJson(jsonDecode(response));
      GetStorage().write(accessToken, 'Bearer ${objLogin.accessToken}');
      GetStorage().write(userId, objLogin.user?.id);
      GetStorage().write(userRole, objLogin.user?.role);
      GetStorage().write(userName, objLogin.user?.name);
      GetStorage().write(userPhone, objLogin.user?.phone);
      GetStorage().write(userAddress, objLogin.user?.city);
      GetStorage().write(userPincode, objLogin.user?.pincode);
      GetStorage().write(refreshTokenVal, objLogin.refreshToken);
      hideLoading();
      onCompleteHandler(true);
      approvedDialog('Success', objLogin.message.toString());
      if (Get.isRegistered<ProfileController>()) {
        Get.delete<ProfileController>();
      }
      Get.put(ProfileController());
      Future.delayed(const Duration(seconds: 2)).then((_) {
        Get.offAllNamed('/customer_bottom_bar_screen');
      });
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
