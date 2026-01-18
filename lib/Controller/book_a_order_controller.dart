import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:xpressfly_git/Constants/api_constant.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Services/rest_service.dart';
import 'package:xpressfly_git/Utility/api_error_handler.dart';
import 'package:xpressfly_git/Utility/app_utility.dart';
import 'package:xpressfly_git/Utility/common_imports.dart';
import 'package:xpressfly_git/Utility/place_service.dart';
import 'package:dio/src/multipart_file.dart' as multipart_file;
import 'package:dio/src/form_data.dart' as formdata;

class BookAOrderController extends GetxController {
  var intCurrentStep = 0.obs;
  final pageviewController = PageController(initialPage: 0);
  RxInt selectedIndex = 0.obs;
  var imgPicker = ImagePicker();

  // var pickUpPinCodeController = TextEditingController();
  // var dropOffPinCodeController = TextEditingController();
  // var receiverNameController = TextEditingController();
  // var receiverMobileNoController = TextEditingController();
  // var orderWeightController = TextEditingController();
  // var orderTitleController = TextEditingController();
  // var orderPickUpDateController = TextEditingController();
  var pickUpPinCodeController = TextEditingController(text: "394101");
  var dropOffPinCodeController = TextEditingController(text: "364002");
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
      log('Status Code: ${response.statusCode}');
      log('Response: ${response.body}');
    } catch (e) {
      log('Error: $e');
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
        // {"from_time": "", "to_time": ""},
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

  Future<void> createOrder(Function(String) onSuccess) async {
    Future.delayed(Duration.zero, () {
      showLoading();
    });

    var headers = {
      'accept': 'application/json',
      'Authorization': GetStorage().read(accessToken),
    };

    try {
      // Validate images before making API call
      if (pickedImages.isEmpty) {
        hideLoading();
        await declineDialog(
          "Error",
          "Please add at least one image of the order",
        );
        return; // Stop execution
      }

      // Create FormData for multipart upload
      var formData = formdata.FormData.fromMap({
        "title": orderTitleController.text.trim(),
        "receiver_name": receiverNameController.text.trim(),
        "receiver_phone_number": receiverMobileNoController.text.trim(),
        "from_address": "Kuber Nager",
        "to_address": "Nandini Row house",
        "from_zip_code": pickUpPinCodeController.text.trim(),
        "to_zip_code": dropOffPinCodeController.text.trim(),
        "pickup_date": orderPickUpDateController.text.trim(),
        "vehicle_type": vehicleType.toString(),
        "weight_in_kg": orderWeightController.text.trim(),
        "available_times": jsonEncode(timeSlots.toList()),
      });

      // Add images
      for (int i = 0; i < pickedImages.length; i++) {
        formData.files.add(
          MapEntry(
            'images',
            await multipart_file.MultipartFile.fromFile(
              pickedImages[i].path,
              filename: pickedImages[i].path.split('/').last,
            ),
          ),
        );
      }

      dynamic response = await ServiceCall().postMultipart(
        ApiConstant.baseUrl,
        ApiConstant.createOrder,
        formData,
        headers,
      );

      debugPrint('Raw Response: $response');

      final decodedResponse = jsonDecode(response);

      // if (decodedResponse['success'] == true) {
      // Extract order ID from response
      final orderId =
          decodedResponse['id']?.toString() ??
          decodedResponse['id']?.toString() ??
          '';

      if (orderId.isEmpty) {
        hideLoading();
        await declineDialog("Error", "Order created but ID not found");
        return; // Don't call onSuccess
      }

      hideLoading();

      // ONLY call onSuccess when API succeeds
      onSuccess(orderId);
      // } else {
      //   hideLoading();
      //   await declineDialog(
      //     "Error",
      //     decodedResponse['message']?.toString() ?? "Order creation failed",
      //   );
      //   // Don't call onSuccess - just return
      // }
    } catch (error) {
      hideLoading();
      debugPrint('Error occurred: $error');

      if (error is DioException) {
        final responseData = error.response?.data;
        debugPrint('DioError Response Data: $responseData');
        debugPrint('Status Code: ${error.response?.statusCode}');

        String errorMessage = 'An error occurred';

        if (responseData is Map) {
          // Handle specific field errors
          if (responseData.containsKey('images')) {
            final imageErrors = responseData['images'];
            if (imageErrors is List && imageErrors.isNotEmpty) {
              errorMessage = 'Image Error: ${imageErrors[0]}';
            } else {
              errorMessage = 'Please add at least one image';
            }
          } else if (responseData.containsKey('message')) {
            errorMessage = responseData['message']?.toString() ?? errorMessage;
          } else if (responseData.containsKey('error')) {
            errorMessage = responseData['error']?.toString() ?? errorMessage;
          } else {
            // Show first error found
            errorMessage =
                responseData.values.first?.toString() ?? errorMessage;
          }
        } else if (responseData is String) {
          errorMessage = responseData;
        }

        await declineDialog("Error", errorMessage);
      } else {
        debugPrint('Non-Dio Error: $error');

        if (error is FormatException &&
            error.toString().contains("success: true")) {
          final errorString = error.toString();
          final idMatch = RegExp(r"id:\s*(\d+)").firstMatch(errorString);

          if (idMatch != null) {
            final orderId = idMatch.group(1)!;
            hideLoading();
            onSuccess(orderId); // Only call on actual success
            return;
          }
        }

        handleError(error);
        await declineDialog("Error", "An unexpected error occurred");
      }

      // Don't call onSuccess on error - just return
      return;
    }
  }

  @override
  void onClose() {
    fromTimeControllers.forEach((key, controller) => controller.dispose());
    toTimeControllers.forEach((key, controller) => controller.dispose());
    super.onClose();
  }
}
