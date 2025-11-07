import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Constants/api_constant.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Models/profile_model.dart';
import 'package:xpressfly_git/Services/rest_service.dart';
import 'package:xpressfly_git/Utility/api_error_handler.dart';
import 'package:xpressfly_git/Utility/app_utility.dart';
import 'package:xpressfly_git/Utility/common_imports.dart';

class ProfileController extends GetxController {
  var mobileTextEditingController = TextEditingController();
  // var emailTextEditingController = TextEditingController();
  // var addressTextEditingController = TextEditingController();
  var nameTextEditingController = TextEditingController();
  var pincodeTextEditingController = TextEditingController();
  var cityTextEditingController = TextEditingController();

  GlobalKey<FormState> formKeyProfile = GlobalKey<FormState>();
  Rx<GetUserProfileDataModel> userDetails = Rx<GetUserProfileDataModel>(
    GetUserProfileDataModel(),
  );

  @override
  void onInit() {
    super.onInit();
    getData().then((value) {
      nameTextEditingController.text = userDetails.value.data?.name ?? '';
      mobileTextEditingController.text =
          userDetails.value.data?.mobileNumber ?? '';
      pincodeTextEditingController.text = userDetails.value.data?.pincode ?? '';
      cityTextEditingController.text = userDetails.value.data?.city ?? '';
    });
  }

  Future getData() async {
    await getUserDetails((p0) {});
  }

  // Update Profile Method
  Future<bool> updateUserProfile(Function(bool) onCompleteHandler) async {
    Future.delayed(Duration.zero, () {
      showLoading();
    });

    var headers = {
      'Authorization': GetStorage().read(accessToken),
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var formData = {
      'name': nameTextEditingController.text.trim(),
      'mobile_number': mobileTextEditingController.text.trim(),
      'pincode': pincodeTextEditingController.text.trim(),
      'city': cityTextEditingController.text.trim(),
      // Add other fields as needed based on your API
    };

    try {
      var response = await ServiceCall().put(
        ApiConstant.baseUrl,
        "${ApiConstant.profile}/${GetStorage().read(userId)}",
        formData,
        headers,
      );

      if (response == null) {
        hideLoading();
        onCompleteHandler(false);
        return false;
      }

      var responseData = jsonDecode(response);

      if (responseData['success'] == true) {
        // Update local user details
        await getUserDetails((success) {});
        hideLoading();
        onCompleteHandler(true);
        showSuccessSnackbar('Profile updated successfully');
        return true;
      } else {
        hideLoading();
        onCompleteHandler(false);
        showErrorSnackbar(
          responseData['message'] ?? 'Failed to update profile',
        );
        return false;
      }
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
          final errorMessage = errors.entries
              .map((entry) {
                final value = entry.value;
                if (value is List) {
                  return value.join(', ');
                } else {
                  return '$value';
                }
              })
              .join('\n');
          showErrorSnackbar(errorMessage);
        } else {
          showErrorSnackbar(
            parsedData?['message'] ?? 'An unknown error occurred',
          );
        }
      } else {
        debugPrint('Error is not a DioException: $error');
        handleError(error);
      }
      onCompleteHandler(false);
      return false;
    }
  }

  void showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future getUserDetails(
    Function(bool) onCompleteHandler, {
    Map<String, dynamic>? details,
  }) async {
    Future.delayed(Duration.zero, () {
      showLoading();
    });

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': GetStorage().read(accessToken),
    };

    try {
      var response = await ServiceCall().get(
        ApiConstant.baseUrl,
        "${ApiConstant.profile}/${GetStorage().read(userId)}",
        headers,
      );

      if (response == null) {
        hideLoading();
        onCompleteHandler(false);
        return false;
      }

      userDetails.value = GetUserProfileDataModel.fromJson(
        jsonDecode(response),
      );

      hideLoading();
      onCompleteHandler(true);
      // approvedDialog('Success', objUserWiseVehicles.message.toString());

      return userDetails.value;
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
