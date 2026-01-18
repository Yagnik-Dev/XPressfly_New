import 'dart:convert';
import 'dart:developer';
import 'dart:io';
// ignore: implementation_imports
import 'package:dio/src/form_data.dart' as formdata;
// ignore: implementation_imports
import 'package:dio/src/multipart_file.dart' as multipart_file;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xpressfly_git/Constants/api_constant.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Controller/driver_home_controller.dart';
import 'package:xpressfly_git/Controller/profile_controller.dart';
import 'package:xpressfly_git/Models/create_vehicle_model.dart';
import 'package:xpressfly_git/Models/get_vehicle_Details_model.dart';
import 'package:xpressfly_git/Services/rest_service.dart';
import 'package:xpressfly_git/Utility/api_error_handler.dart';
import 'package:xpressfly_git/Utility/app_utility.dart';
import 'package:xpressfly_git/Localization/localization_keys.dart';

class AddVehicleMainController extends GetxController {
  var fullNameTextEditingController = TextEditingController();
  var mobileNoTextEditingController = TextEditingController();
  var licenseNoTextEditingController = TextEditingController();
  var addressTextEditingController = TextEditingController();
  var vehicleModelTextEditingController = TextEditingController();
  var vehicleNoTextEditingController = TextEditingController();
  var dobTextEditingController = TextEditingController();
  var vehicleConditionTextEditingController = TextEditingController();
  var pinCodeTextEditingController = TextEditingController();

  GlobalKey<FormState> addVehicleFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> addVehicleTwoFormKey = GlobalKey<FormState>();

  Rx<File?> licenceImg = Rx<File?>(null);
  Rx<File?> aadharFrontImg = Rx<File?>(null);
  Rx<File?> aadharBackImg = Rx<File?>(null);
  Rx<File?> rcBookFrontImg = Rx<File?>(null);
  Rx<File?> rcBookBackImg = Rx<File?>(null);

  var imgPicker = ImagePicker();
  var intCurrentStep = 0.obs;
  final pageviewController = PageController(initialPage: 0);
  RxInt selectedIndex = 0.obs;

  RxString selectedVehicleTitle = "".obs;
  RxString selectedVehicleIcon = "".obs;
  Rx<Color> selectedVehicleColor = Color(0xffffffff).obs;

  // New properties for update functionality
  RxBool isUpdateMode = false.obs;
  RxInt vehicleId = 0.obs;
  Rx<VehicleDetailsData?> existingVehicleData = Rx<VehicleDetailsData?>(null);

  @override
  void onInit() {
    super.onInit();
    final ProfileController profileController = Get.find<ProfileController>();
    fullNameTextEditingController.text =
        profileController.userDetails.value.user?.name ?? '';
    mobileNoTextEditingController.text =
        profileController.userDetails.value.user?.phone ?? '';
    // licenseNoTextEditingController.text = vehicleData.licenseNumber ?? '';
    addressTextEditingController.text =
        profileController.userDetails.value.user?.address ?? '';
    // Check if we're in update mode and get vehicle data
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final args = Get.arguments as Map<String, dynamic>;
      if (args['isUpdate'] == true && args['vehicleId'] != null) {
        isUpdateMode.value = true;
        vehicleId.value = args['vehicleId'];
        loadVehicleData(args['vehicleData']);
      }
    }
  }

  // Load existing vehicle data into form
  void loadVehicleData(VehicleDetailsData vehicleData) {
    existingVehicleData.value = vehicleData;

    // Populate form fields with existing data
    vehicleModelTextEditingController.text = vehicleData.vehicleModel ?? '';
    vehicleNoTextEditingController.text = vehicleData.vehicleNumber ?? '';
    selectedVehicleTitle.value = vehicleData.vehicleType?.name ?? '';
    selectedVehicleIcon.value = vehicleData.vehicleType?.logo ?? '';
    selectedVehicleColor.value = Color(
      parseColorCode(vehicleData.vehicleType?.colorCode),
    );
    pinCodeTextEditingController.text = vehicleData.zipCode?.join(', ') ?? '';
    rcBookFrontImg.value =
        vehicleData.rcBookFront != null ? File(vehicleData.rcBookFront!) : null;
    rcBookBackImg.value =
        vehicleData.rcBookBack != null ? File(vehicleData.rcBookBack!) : null;
  }

  void pickVehicleType(String title, String icon, int color) {
    selectedVehicleTitle.value = title;
    selectedVehicleIcon.value = icon;
    selectedVehicleColor.value = Color(color);
    update();
    Get.back();
  }

  Future<void> pickImage(ImageSource source, Rx<File?> imageFile) async {
    final pickedFile = await imgPicker.pickImage(source: source);

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  Future createVehicle(Function(bool) onCompleteHandler) async {
    Future.delayed(Duration.zero, () {
      showLoading();
    });
    // Validate vehicle type is selected
    if (selectedVehicleTitle.value.isEmpty) {
      hideLoading();
      declineDialog(
        LocalizationKeys.error.tr,
        LocalizationKeys.pleaseSelectVehicleType.tr,
      );
      onCompleteHandler(false);
      return;
    }

    // For create mode, validate all required images
    if (!isUpdateMode.value) {
      // if (licenceImg.value == null) {
      //   hideLoading();
      //   declineDialog("Error", "Please upload licence image");
      //   onCompleteHandler(false);
      //   return;
      // }

      // if (aadharFrontImg.value == null) {
      //   hideLoading();
      //   declineDialog("Error", "Please upload Aadhar front image");
      //   onCompleteHandler(false);
      //   return;
      // }

      // if (aadharBackImg.value == null) {
      //   hideLoading();
      //   declineDialog("Error", "Please upload Aadhar back image");
      //   onCompleteHandler(false);
      //   return;
      // }

      if (rcBookFrontImg.value == null) {
        hideLoading();
        // declineDialog("Error", "Please upload RC book front image");
        declineDialog(
          LocalizationKeys.error.tr,
          LocalizationKeys.pleaseUploadRCBookFrontImage.tr,
        );
        onCompleteHandler(false);
        return;
      }

      if (rcBookBackImg.value == null) {
        hideLoading();
        declineDialog(
          LocalizationKeys.error.tr,
          LocalizationKeys.pleaseUploadRCBookBackImage.tr,
        );
        onCompleteHandler(false);
        return;
      }
    }

    var headers = {
      'Content-Type': 'multipart/form-data',
      'accept': 'application/json',
      'Authorization': GetStorage().read(accessToken),
    };

    try {
      // Create form data
      var formData = formdata.FormData.fromMap({
        // "user_id": GetStorage().read(userId).toString(),
        // "full_name": fullNameTextEditingController.text.trim(),
        // "mobile_number": mobileNoTextEditingController.text.trim(),
        // "license_number": licenseNoTextEditingController.text.trim(),
        // "address": addressTextEditingController.text.trim(),
        "vehicle_model": vehicleModelTextEditingController.text.trim(),
        "vehicle_number": vehicleNoTextEditingController.text.trim(),
        "vehicle_type":
            Get.find<DriverHomeController>().vehicleTypeList.value.data
                ?.firstWhere((type) => type.name == selectedVehicleTitle.value)
                .id
                .toString(),
        "zip_code": jsonEncode(
          pinCodeTextEditingController.text
              .split(',')
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList(),
        ),
      });

      // Add files only if they are selected (for update) or required (for create)
      // if (licenceImg.value != null) {
      //   formData.files.add(
      //     MapEntry(
      //       "license_image",
      //       multipart_file.MultipartFile.fromFileSync(
      //         licenceImg.value!.path,
      //         filename: licenceImg.value!.path.split('/').last,
      //       ),
      //     ),
      //   );
      // }

      // if (aadharFrontImg.value != null) {
      //   formData.files.add(
      //     MapEntry(
      //       "adhar_front_image",
      //       multipart_file.MultipartFile.fromFileSync(
      //         aadharFrontImg.value!.path,
      //         filename: aadharFrontImg.value!.path.split('/').last,
      //       ),
      //     ),
      //   );
      // }

      // if (aadharBackImg.value != null) {
      //   formData.files.add(
      //     MapEntry(
      //       "adhar_back_image",
      //       multipart_file.MultipartFile.fromFileSync(
      //         aadharBackImg.value!.path,
      //         filename: aadharBackImg.value!.path.split('/').last,
      //       ),
      //     ),
      //   );
      // }

      if (rcBookFrontImg.value != null) {
        formData.files.add(
          MapEntry(
            "rc_book_front",
            multipart_file.MultipartFile.fromFileSync(
              rcBookFrontImg.value!.path,
              filename: rcBookFrontImg.value!.path.split('/').last,
            ),
          ),
        );
      }

      if (rcBookBackImg.value != null) {
        formData.files.add(
          MapEntry(
            "rc_book_back",
            multipart_file.MultipartFile.fromFileSync(
              rcBookBackImg.value!.path,
              filename: rcBookBackImg.value!.path.split('/').last,
            ),
          ),
        );
      }

      // Log the request
      log("Headers: $headers");
      log("Form Data Fields: ${formData.fields}");
      log("Form Data Files: ${formData.files.map((f) => f.key).toList()}");

      dynamic response;

      if (isUpdateMode.value) {
        // Use PUT request for update
        response = await ServiceCall().patchMultipart(
          ApiConstant.baseUrl,
          "${ApiConstant.updateVehicles}${vehicleId.value}/",
          formData,
          headers,
        );
      } else {
        // Use POST request for create
        response = await ServiceCall().postMultipart(
          ApiConstant.baseUrl,
          ApiConstant.createVehicles,
          formData,
          headers,
        );
      }

      if (response == null) {
        hideLoading();
        onCompleteHandler(false);
        return;
      }

      debugPrint('Raw Response: $response');

      // Handle the response - it might not be valid JSON
      dynamic parsedResponse;
      try {
        // First try to parse as regular JSON
        parsedResponse = jsonDecode(response);
      } catch (e) {
        debugPrint(
          'JSON decode failed, trying to handle non-standard format: $e',
        );

        // If JSON parsing fails, try to handle the non-standard format
        // The response appears to be in a Map-like format but not proper JSON
        if (response is String) {
          // Try to manually parse the response
          // if (response.contains("success: true") &&
          //     response.contains("message:")) {
          // This is a successful response in non-JSON format
          hideLoading();
          onCompleteHandler(true);
          approvedDialog("Success", "Vehicle updated successfully");

          // Don't clear form in update mode
          if (!isUpdateMode.value) {
            clearForm();
          }
          return;
          // }
        }

        // If we can't parse it, show error
        hideLoading();
        declineDialog("Error", "Failed to process server response");
        onCompleteHandler(false);
        return;
      }

      // If we successfully parsed JSON, process normally
      var objAddProduct = CreateVehicleResponseModel.fromJson(parsedResponse);

      hideLoading();
      onCompleteHandler(true);
      approvedDialog("Success", objAddProduct.message.toString());

      // Clear form after successful submission only in create mode
      if (!isUpdateMode.value) {
        clearForm();
      }

      return objAddProduct;
    } catch (error) {
      hideLoading();
      if (error is DioException) {
        final responseData = error.response?.data;
        debugPrint('DioError Response Data: $responseData');

        // Handle Dio errors
        String errorMessage = 'An error occurred';

        if (responseData is String) {
          // Try to extract error message from non-JSON response
          if (responseData.contains("message:")) {
            // Extract message from the non-JSON format
            final messageMatch = RegExp(
              r"message:\s*([^,]+)",
            ).firstMatch(responseData);
            if (messageMatch != null) {
              errorMessage = messageMatch.group(1)?.trim() ?? errorMessage;
            }
          } else {
            errorMessage = responseData;
          }
        } else if (responseData is Map) {
          errorMessage = responseData['message']?.toString() ?? errorMessage;
        }

        await declineDialog("Error", errorMessage);
      } else {
        debugPrint('Non-Dio Error: $error');

        // Check if this is the successful but malformed response case
        if (error is FormatException &&
            error.toString().contains("success: true")) {
          // This is actually a success case with malformed JSON
          hideLoading();
          onCompleteHandler(true);
          approvedDialog("Success", "Vehicle updated successfully");

          if (!isUpdateMode.value) {
            clearForm();
          }
          return;
        }

        handleError(error);
        await declineDialog("Error", "An unexpected error occurred");
      }
      onCompleteHandler(false);
      return false;
    }
  }

  void clearForm() {
    fullNameTextEditingController.clear();
    mobileNoTextEditingController.clear();
    licenseNoTextEditingController.clear();
    addressTextEditingController.clear();
    vehicleModelTextEditingController.clear();
    vehicleNoTextEditingController.clear();
    pinCodeTextEditingController.clear();
    licenceImg.value = null;
    aadharFrontImg.value = null;
    aadharBackImg.value = null;
    rcBookFrontImg.value = null;
    rcBookBackImg.value = null;
    selectedVehicleTitle.value = "";
    selectedVehicleIcon.value = "";
    selectedVehicleColor.value = Color(0xffffffff);
    intCurrentStep.value = 0;
    pageviewController.jumpToPage(0);
    isUpdateMode.value = false;
    vehicleId.value = 0;
    existingVehicleData.value = null;
  }
}
