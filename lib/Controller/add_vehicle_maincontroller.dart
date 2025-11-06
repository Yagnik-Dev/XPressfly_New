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
import 'package:xpressfly_git/Models/create_vehicle_model.dart';
import 'package:xpressfly_git/Services/rest_service.dart';
import 'package:xpressfly_git/Utility/api_error_handler.dart';
import 'package:xpressfly_git/Utility/app_utility.dart';

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

  void pickVehicleType(String title, String icon, Color color) {
    selectedVehicleTitle.value = title;
    selectedVehicleIcon.value = icon;
    selectedVehicleColor.value = color;
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
    showLoading();

    // Validate vehicle type is selected
    if (selectedVehicleTitle.value.isEmpty) {
      hideLoading();
      declineDialog("Error", "Please select a vehicle type");
      onCompleteHandler(false);
      return;
    }

    // Validate required images are uploaded
    if (licenceImg.value == null) {
      hideLoading();
      declineDialog("Error", "Please upload licence image");
      onCompleteHandler(false);
      return;
    }

    if (aadharFrontImg.value == null) {
      hideLoading();
      declineDialog("Error", "Please upload Aadhar front image");
      onCompleteHandler(false);
      return;
    }

    if (aadharBackImg.value == null) {
      hideLoading();
      declineDialog("Error", "Please upload Aadhar back image");
      onCompleteHandler(false);
      return;
    }

    if (rcBookFrontImg.value == null) {
      hideLoading();
      declineDialog("Error", "Please upload RC book front image");
      onCompleteHandler(false);
      return;
    }

    if (rcBookBackImg.value == null) {
      hideLoading();
      declineDialog("Error", "Please upload RC book back image");
      onCompleteHandler(false);
      return;
    }

    var headers = {
      'Content-Type': 'multipart/form-data',
      'accept': 'application/json',
      'Authorization': GetStorage().read(accessToken),
    };

    try {
      // Create form data
      var formData = formdata.FormData.fromMap({
        "user_id": GetStorage().read(userId).toString(),
        "full_name": fullNameTextEditingController.text.trim(),
        "mobile_number": mobileNoTextEditingController.text.trim(),
        "license_number": licenseNoTextEditingController.text.trim(),
        "address": addressTextEditingController.text.trim(),
        "vehicle_model": vehicleModelTextEditingController.text.trim(),
        "vehicle_number": vehicleNoTextEditingController.text.trim(),
        "vehicle_type": selectedVehicleTitle.value,
        "delivery_pincodes": [pinCodeTextEditingController.text.trim()],
      });

      // Add files - they won't be null because we validated above
      formData.files.addAll([
        MapEntry(
          "license_image",
          multipart_file.MultipartFile.fromFileSync(
            licenceImg.value!.path,
            filename: licenceImg.value!.path.split('/').last,
          ),
        ),
        MapEntry(
          "adhar_front_image",
          multipart_file.MultipartFile.fromFileSync(
            aadharFrontImg.value!.path,
            filename: aadharFrontImg.value!.path.split('/').last,
          ),
        ),
        MapEntry(
          "adhar_back_image",
          multipart_file.MultipartFile.fromFileSync(
            aadharBackImg.value!.path,
            filename: aadharBackImg.value!.path.split('/').last,
          ),
        ),
        MapEntry(
          "rc_front_image",
          multipart_file.MultipartFile.fromFileSync(
            rcBookFrontImg.value!.path,
            filename: rcBookFrontImg.value!.path.split('/').last,
          ),
        ),
        MapEntry(
          "rc_back_image",
          multipart_file.MultipartFile.fromFileSync(
            rcBookBackImg.value!.path,
            filename: rcBookBackImg.value!.path.split('/').last,
          ),
        ),
      ]);

      // Log the request
      log("Headers: $headers");
      log("Form Data Fields: ${formData.fields}");
      log("Form Data Files: ${formData.files.map((f) => f.key).toList()}");

      var response = await ServiceCall().postMultipart(
        ApiConstant.baseUrl,
        ApiConstant.vehiclesDetails,
        formData,
        headers,
      );

      if (response == null) {
        hideLoading();
        onCompleteHandler(false);
        return;
      }

      var objAddProduct = CreateVehicleResponseModel.fromJson(
        jsonDecode(response),
      );

      hideLoading();
      onCompleteHandler(true);
      approvedDialog("Success", objAddProduct.message.toString());

      // Clear form after successful submission
      clearForm();

      return objAddProduct;
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

        if (parsedData != null && parsedData['data'] != null) {
          final errors = parsedData['data'] as Map<String, dynamic>;
          final errorMessages = errors.entries
              .map((entry) {
                final value = entry.value;
                if (value is List) {
                  return value.join(', ');
                } else {
                  return '$value';
                }
              })
              .join('\n');
          await declineDialog("Validation Error", errorMessages);
        } else {
          await declineDialog(
            "Error",
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
  }
}
