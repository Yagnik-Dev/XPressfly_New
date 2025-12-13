import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Constants/api_constant.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Models/privacypolicy_model.dart';
import 'package:xpressfly_git/Models/termsandcondition_model.dart';
import 'package:xpressfly_git/Services/rest_service.dart';
import 'package:xpressfly_git/Utility/api_error_handler.dart';
import 'package:xpressfly_git/Utility/app_utility.dart';
import 'package:xpressfly_git/Utility/common_imports.dart';

class MetadataController extends GetxController {
  var selectedTabIndex = 0.obs;

  Rx<TermsAndConditionsModel> termsAndConditions = Rx<TermsAndConditionsModel>(
    TermsAndConditionsModel(),
  );
  Rx<PrivacyPolicyModel> privacyPolicy = Rx<PrivacyPolicyModel>(
    PrivacyPolicyModel(),
  );

  void changeTabIndex(int index) {
    selectedTabIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    getdata();
  }

  Future getdata() async {
    await getTermsAndConditions((p0) {});
    await getPrivacyPolicy((p0) {});
  }

  Future getTermsAndConditions(
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
        ApiConstant.termsAndConditions,
        headers,
      );

      if (response == null) {
        hideLoading();
        onCompleteHandler(false);
        return false;
      }

      termsAndConditions.value = TermsAndConditionsModel.fromJson(
        jsonDecode(response),
      );

      hideLoading();
      onCompleteHandler(true);
      // approvedDialog('Success', objUserWiseVehicles.message.toString());

      return termsAndConditions.value;
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

  Future getPrivacyPolicy(
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
        ApiConstant.privacyPolicy,
        headers,
      );

      if (response == null) {
        hideLoading();
        onCompleteHandler(false);
        return false;
      }

      privacyPolicy.value = PrivacyPolicyModel.fromJson(jsonDecode(response));

      hideLoading();
      onCompleteHandler(true);
      // approvedDialog('Success', objUserWiseVehicles.message.toString());

      return privacyPolicy.value;
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
