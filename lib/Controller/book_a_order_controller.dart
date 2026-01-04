import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:xpressfly_git/Constants/api_constant.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Models/create_vehicle_model.dart';
import 'package:xpressfly_git/Services/rest_service.dart';
import 'package:xpressfly_git/Utility/api_error_handler.dart';
import 'package:xpressfly_git/Utility/app_utility.dart';
import 'package:xpressfly_git/Utility/common_imports.dart';
import 'package:xpressfly_git/Utility/place_service.dart';

class BookAOrderController extends GetxController {
  var intCurrentStep = 0.obs;
  final pageviewController = PageController(initialPage: 0);
  RxInt selectedIndex = 0.obs;
  var imgPicker = ImagePicker();

  var pickUpPinCodeController = TextEditingController(text: "355356");
  var dropOffPinCodeController = TextEditingController(text: "354654");
  var receiverNameController = TextEditingController(text: "John Doe");
  var receiverMobileNoController = TextEditingController(text: "+919601605752");
  var orderWeightController = TextEditingController(text: "10");
  var orderTitleController = TextEditingController(text: "Sample Order");
  var orderPickUpDateController = TextEditingController(text: "2025-11-21");
  int vehicleType = 0;

  var pickupLatitude = 0.0.obs;
  var pickupLongitude = 0.0.obs;
  var dropoffLatitude = 0.0.obs;
  var dropoffLongitude = 0.0.obs;

  RxString pickupFullAddress = ''.obs;
  RxString dropoffFullAddress = ''.obs;

  // Store extracted pincodes
  RxString pickupPincode = ''.obs;
  RxString dropoffPincode = ''.obs;

  // Add this list to store picked images
  RxList<File> pickedImages = <File>[].obs;

  GlobalKey<FormState> bookAOrderFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> bookAOrderTwoFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> bookAOrderThreeFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    if (Get.arguments != null) {
      vehicleType = Get.arguments['vehicleType'] ?? 0;
      // log('Vehicle Type in Controller: $vehicleType');
    }
    super.onInit();
  }

  Map<int, TextEditingController> fromTimeControllers = {};
  Map<int, TextEditingController> toTimeControllers = {};

  void testGooglePlacesAPI() async {
    final apiKey = 'AIzaSyBk6ueDJ7vlhRhSs9XOIlt6j0XRmIrA4co';
    final testInput = 'surat';

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/autocomplete/json'
      '?input=$testInput'
      '&key=$apiKey'
      '&components=country:in',
    );

    try {
      final response = await http.get(url);
      print('Status Code: ${response.statusCode}');
      print('Response: ${response.body}');
    } catch (e) {
      print('Error: $e');
    }
  }

  String formatTimeIn24Hour(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  TextEditingController getFromTimeController(int index) {
    if (!fromTimeControllers.containsKey(index)) {
      fromTimeControllers[index] = TextEditingController(
        text: timeSlots[index]["from_time"] ?? "",
      );
    }
    return fromTimeControllers[index]!;
  }

  TextEditingController getToTimeController(int index) {
    if (!toTimeControllers.containsKey(index)) {
      toTimeControllers[index] = TextEditingController(
        text: timeSlots[index]["to_time"] ?? "",
      );
    }
    return toTimeControllers[index]!;
  }

  void onPickupLocationSelected(PlaceDetails placeDetails) {
    pickupLatitude.value = placeDetails.latitude;
    pickupLongitude.value = placeDetails.longitude;
    pickupFullAddress.value = placeDetails.formattedAddress;

    // Update pincode if available
    if (placeDetails.pincode != null && placeDetails.pincode!.isNotEmpty) {
      pickupPincode.value = placeDetails.pincode!;
      // Optionally update the controller text with just the pincode
      // pickUpPinCodeController.text = placeDetails.pincode!;
    }

    log('Pickup Location Selected:');
    log('Address: ${placeDetails.formattedAddress}');
    log('Lat: ${pickupLatitude.value}, Lng: ${pickupLongitude.value}');
    log('Pincode: ${placeDetails.pincode ?? "Not found"}');

    update();
  }

  void onDropoffLocationSelected(PlaceDetails placeDetails) {
    dropoffLatitude.value = placeDetails.latitude;
    dropoffLongitude.value = placeDetails.longitude;
    dropoffFullAddress.value = placeDetails.formattedAddress;

    // Update pincode if available
    if (placeDetails.pincode != null && placeDetails.pincode!.isNotEmpty) {
      dropoffPincode.value = placeDetails.pincode!;
      // Optionally update the controller text with just the pincode
      // dropOffPinCodeController.text = placeDetails.pincode!;
    }

    log('Dropoff Location Selected:');
    log('Address: ${placeDetails.formattedAddress}');
    log('Lat: ${dropoffLatitude.value}, Lng: ${dropoffLongitude.value}');
    log('Pincode: ${placeDetails.pincode ?? "Not found"}');

    update();
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await imgPicker.pickImage(source: source);

    if (pickedFile != null) {
      pickedImages.add(File(pickedFile.path));
    }
  }

  // Remove image from list
  void removeImage(int index) {
    pickedImages.removeAt(index);
  }

  RxList<Map<String, String>> timeSlots =
      <Map<String, String>>[
        {"from_time": "", "to_time": ""},
        {"from_time": "", "to_time": ""},
      ].obs;

  void addTimeSlot() {
    timeSlots.add({"from_time": "", "to_time": ""});
    // Clear controllers so new ones are created for new slot
    fromTimeControllers.remove(timeSlots.length - 1);
    toTimeControllers.remove(timeSlots.length - 1);
  }

  void removeTimeSlot(int index) {
    if (timeSlots.length > 1) {
      timeSlots.removeAt(index);
      // Dispose controllers for removed slot
      fromTimeControllers[index]?.dispose();
      toTimeControllers[index]?.dispose();
      fromTimeControllers.remove(index);
      toTimeControllers.remove(index);
    }
  }

  void updateTimeSlot(int index, String fromTime, String toTime) {
    timeSlots[index] = {"from_time": fromTime, "to_time": toTime};

    // Update controllers with new values
    if (fromTimeControllers.containsKey(index)) {
      fromTimeControllers[index]!.text = fromTime;
    }
    if (toTimeControllers.containsKey(index)) {
      toTimeControllers[index]!.text = toTime;
    }

    timeSlots.refresh();
  }

  selectPickUpDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      String formattedDate =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      orderPickUpDateController.text = formattedDate;
    }
  }

  Future createOrder(Function(bool) onCompleteHandler) async {
    showLoading();

    // For create mode, validate all required images
    // if (!isUpdateMode.value) {}

    var headers = {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Authorization': GetStorage().read(accessToken),
    };

    try {
      // Create form data
      var reqData = {
        "title": orderTitleController.text.trim(),
        "receiver_name": receiverNameController.text.trim(),
        "receiver_phone_number": "919601605752",
        // "receiver_phone_number": receiverMobileNoController.text.trim(),
        "from_address": "Kuber Nager",
        "to_address": "Nandini Row house",
        "from_zip_code": pickUpPinCodeController.text.trim(),
        "to_zip_code": dropOffPinCodeController.text.trim(),
        "pickup_date": orderPickUpDateController.text.trim(),
        "vehicle_type": vehicleType,
        "weight_in_kg": orderWeightController.text.trim(),
        "available_times": timeSlots.toList(),
      };

      dynamic response;

      // if (isUpdateMode.value) {
      //   // Use PUT request for update
      //   response = await ServiceCall().patchMultipart(
      //     ApiConstant.baseUrl,
      //     "${ApiConstant.updateVehicles}${vehicleId.value}/",
      //     formData,
      //     headers,
      //   );
      // } else {
      // Use POST request for create
      response = await ServiceCall().post(
        ApiConstant.baseUrl,
        ApiConstant.createOrder,
        reqData,
        headers,
      );
      // }

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
        if (response is String) {
          // Try to manually parse the response
          // if (response.contains("success: true") &&
          //     response.contains("message:")) {
          hideLoading();
          onCompleteHandler(true);
          approvedDialog("Success", "Vehicle updated successfully");

          // Don't clear form in update mode
          // if (!isUpdateMode.value) {
          //   clearForm();
          // }
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
      // if (!isUpdateMode.value) {
      //   clearForm();
      // }

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

          // if (!isUpdateMode.value) {
          //   clearForm();
          // }
          return;
        }

        handleError(error);
        await declineDialog("Error", "An unexpected error occurred");
      }
      onCompleteHandler(false);
      return false;
    }
  }

  @override
  void onClose() {
    fromTimeControllers.forEach((key, controller) => controller.dispose());
    toTimeControllers.forEach((key, controller) => controller.dispose());
    super.onClose();
  }
}
