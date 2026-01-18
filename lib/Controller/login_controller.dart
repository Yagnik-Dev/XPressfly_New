import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Constants/api_constant.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Models/create_customer_model.dart';
import 'package:xpressfly_git/Models/login_model.dart';
import 'package:xpressfly_git/Models/otp_model.dart';
import 'package:xpressfly_git/Screens/AuthScreens/join_as_screen.dart';
import 'package:xpressfly_git/Screens/AuthScreens/otp_screen.dart';
import 'package:xpressfly_git/Services/rest_service.dart';
import 'package:xpressfly_git/Utility/api_error_handler.dart';
import 'package:xpressfly_git/Utility/app_utility.dart';

// 0 - register
// 1 - login
class LoginController extends GetxController {
  var phoneTextEditingController = TextEditingController();
  var nameTextEditingController = TextEditingController();
  var cityTextEditingController = TextEditingController();
  var pincodeTextEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyYourDetails = GlobalKey<FormState>();

  int loginType = 0; // 0 - customer, 1 - driver

  @override
  void onInit() {
    if (Get.arguments != null) {
      loginType = Get.arguments;
    }
    super.onInit();
  }

  Future<bool> registerApiCall(
    Function(bool) onCompleteHandler, {
    LoginRequestModel? details,
  }) async {
    Future.delayed(Duration.zero, () {
      showLoading();
    });
    var headers = {
      'Content-Type': 'application/json',
      // 'Authorization': GetStorage().read(accessToken),
    };

    try {
      var response = await ServiceCall().post(
        ApiConstant.baseUrl,
        ApiConstant.sendOtp,
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
      Future.delayed(const Duration(seconds: 2)).then((_) {
        Get.close(1);
        Get.to(
          () => OtpScreen(
            mobileNo: objLogin.phone,
            loginType: loginType,
            otp: objLogin.otp ?? '',
          ),
        );
      });
      // Future.delayed(const Duration(seconds: 2)).then((_) {
      //   objLogin.user?.userType == 1
      //       ? Get.offAllNamed('/driver_bottom_bar_screen')
      //       : Get.offAllNamed('/customer_bottom_bar_screen');
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

  Future<bool> loginApiCall(
    Function(bool) onCompleteHandler, {
    LoginRequestModel? details,
  }) async {
    Future.delayed(Duration.zero, () {
      showLoading();
    });
    var headers = {
      'Content-Type': 'application/json',
      // 'Authorization': GetStorage().read(accessToken),
    };

    try {
      var response = await ServiceCall().post(
        ApiConstant.baseUrl,
        ApiConstant.sendOtp,
        details,
        headers,
      );

      if (response == null) {
        hideLoading();
        onCompleteHandler(false);
        return false;
      }

      // var objLogin = LoginResponseModel.fromJson(jsonDecode(response));
      // GetStorage().write(accessToken, 'Bearer ${objLogin.token}');
      // GetStorage().write(userId, objLogin.user?.id);
      // GetStorage().write(userRole, objLogin.user?.userType);
      // GetStorage().write(userName, objLogin.user?.name);
      // GetStorage().write(userPhone, objLogin.user?.mobileNumber);
      // GetStorage().write(userAddress, objLogin.user?.city);
      // GetStorage().write(userPincode, objLogin.user?.pincode);
      // hideLoading();
      // onCompleteHandler(true);
      // approvedDialog('Success', objLogin.message.toString());
      // Future.delayed(const Duration(seconds: 2)).then((_) {
      //   Get.close(1);
      //   Get.to(
      //     () => OtpScreen(
      //       mobileNo: objLogin.user?.mobileNumber,
      //       loginType: loginType,
      //       otp: objLogin.otp ?? '',
      //     ),
      //   );
      // });
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
      Future.delayed(const Duration(seconds: 2)).then((_) {
        Get.close(1);
        Get.to(
          () => OtpScreen(
            mobileNo: objLogin.phone,
            loginType: loginType,
            otp: objLogin.otp ?? '',
          ),
        );
      });
      // Future.delayed(const Duration(seconds: 2)).then((_) {
      //   objLogin.user?.userType == 1
      //       ? Get.offAllNamed('/driver_bottom_bar_screen')
      //       : Get.offAllNamed('/customer_bottom_bar_screen');
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
          ).then((value) {
            Get.offAllNamed('/select_auth_screen');
          });
        }
      } else {
        debugPrint('Error is not a DioException: $error');
        handleError(error);
      }
      return false;
    }
  }

  Future<bool> verifyOtpApiCall(
    Function(bool) onCompleteHandler, {
    LoginRequestModel? details,
  }) async {
    Future.delayed(Duration.zero, () {
      showLoading();
    });
    var headers = {
      'Content-Type': 'application/json',
      // 'Authorization': GetStorage().read(accessToken),
    };

    try {
      var response = await ServiceCall().post(
        ApiConstant.baseUrl,
        ApiConstant.verifyOtp,
        jsonEncode(details?.toJson()),
        headers,
      );

      if (response == null) {
        hideLoading();
        onCompleteHandler(false);
        return false;
      }

      var objVerifyOtp = CreateCustomerResponseModel.fromJson(
        jsonDecode(response),
      );
      GetStorage().write(accessToken, 'Bearer ${objVerifyOtp.accessToken}');
      GetStorage().write(userId, objVerifyOtp.user?.id);
      GetStorage().write(userRole, objVerifyOtp.user?.role);
      GetStorage().write(userName, objVerifyOtp.user?.name);
      GetStorage().write(userPhone, objVerifyOtp.user?.phone);
      GetStorage().write(userAddress, objVerifyOtp.user?.city);
      GetStorage().write(userPincode, objVerifyOtp.user?.pincode);
      GetStorage().write(refreshTokenVal, objVerifyOtp.refreshToken);
      hideLoading();
      onCompleteHandler(true);
      approvedDialog('Success', objVerifyOtp.message.toString());
      Future.delayed(const Duration(seconds: 2)).then((_) {
        Get.close(1);
        objVerifyOtp.user?.isPhoneVerified == true &&
                objVerifyOtp.user?.role == 'customer' &&
                details?.type == "signin"
            ? Get.offAllNamed('/customer_bottom_bar_screen')
            : objVerifyOtp.user?.isPhoneVerified == true &&
                objVerifyOtp.user?.role == 'driver' &&
                details?.type == "signin"
            ? Get.offAllNamed('/driver_bottom_bar_screen')
            : Get.to(
              () => JoinAsScreen(
                mobileNo: details?.phone,
                otp: details?.otp.toString(),
              ),
            );
        // objVerifyOtp.isPhoneVerified == true && loginType == 1
        //     ? Get.offAllNamed('/driver_bottom_bar_screen')
        //     : Get.offAllNamed('/customer_bottom_bar_screen');
      });
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
          ).then((value) {
            // Get.offAllNamed('/select_auth_screen');
          });
        }
      } else {
        debugPrint('Error is not a DioException: $error');
        handleError(error);
      }
      return false;
    }
  }
}
