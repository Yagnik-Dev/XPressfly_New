import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Constants/api_constant.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Services/rest_service.dart';
import 'package:xpressfly_git/Utility/app_utility.dart';

class HelpSupportController extends GetxController {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var isLoading = false.obs;

  Future<void> submitHelpSupport() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;
    showLoading();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': GetStorage().read(accessToken),
    };

    var body = jsonEncode({
      "subject": subjectController.text.trim(),
      "message": messageController.text.trim(),
    });

    try {
      var response = await ServiceCall().post(
        ApiConstant.baseUrl,
        ApiConstant.helpSupport,
        body,
        headers,
      );

      hideLoading();
      isLoading.value = false;

      if (response != null) {
        final decodedResponse = jsonDecode(response);

        // Show success message from API
        String successMessage =
            decodedResponse['message']?.toString() ??
            'Support request submitted successfully';

        await approvedDialog("Success", successMessage);

        // Auto close dialog after 2 seconds
        // await Future.delayed(Duration(seconds: 2));
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }

        // Clear form and go back
        subjectController.clear();
        messageController.clear();
        Get.back(); // Go back to previous screen
      }
    } catch (error) {
      hideLoading();
      isLoading.value = false;

      debugPrint('Error submitting help support: $error');

      String errorMessage = 'Failed to submit support request';

      if (error.toString().contains('DioException')) {
        // Handle DioException errors
        errorMessage = 'Network error occurred. Please try again.';
      }

      await declineDialog("Error", errorMessage);
    }
  }

  @override
  void onClose() {
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
