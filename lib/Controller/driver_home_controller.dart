import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Models/get_user_wise_vehicle_model.dart';
import 'package:xpressfly_git/Models/get_vehicle_type.dart';
import 'package:xpressfly_git/Utility/api_error_handler.dart';
import '../Constants/api_constant.dart';
import '../Services/rest_service.dart';
import '../Utility/app_utility.dart';
import '../Utility/common_imports.dart';

class DriverHomeController extends GetxController {
  var isSwitched = true.obs;
  var isLoading = false.obs;
  var isVehicleLoading = false.obs;
  var searchQuery = ''.obs;
  var selectedVehicleType = RxnInt();
  Rx<GetUserWiseVehicleResponseModel> userWiseVehicleList =
      GetUserWiseVehicleResponseModel().obs;
  Rx<GetVehicleTypeResponseModel> vehicleTypeList =
      GetVehicleTypeResponseModel().obs;
  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    getData();
    ever(searchQuery, (_) {
      _debounceSearch();
    });
  }

  Future<void> getData() async {
    await vehicleTypesAPICall();
    await userWiseVehicleListCall();
  }

  void _debounceSearch() {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      userWiseVehicleListCall();
    });
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }

  Future<void> refreshVehicleList() async {
    isVehicleLoading.value = true;
    await userWiseVehicleListCall();
    Get.back();
    isVehicleLoading.value = false;
  }

  Future<void> searchVehicles(String query) async {
    searchQuery.value = query;
    // await userWiseVehicleListCall();
  }

  // Add method to filter by vehicle type
  Future<void> filterByVehicleType(int? vehicleTypeId) async {
    selectedVehicleType.value = vehicleTypeId;
    await userWiseVehicleListCall();
  }

  // Add method to clear filters
  Future<void> clearFilters() async {
    searchQuery.value = '';
    selectedVehicleType.value = null;
    await userWiseVehicleListCall();
  }

  Future<bool> toggleDutyApiCall({Map<String, dynamic>? details}) async {
    // Future.delayed(Duration.zero, () => showLoading());
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': GetStorage().read(accessToken),
      };

      var response = await ServiceCall().patch(
        ApiConstant.baseUrl,
        ApiConstant.updateDriverProfile,
        details,
        headers,
      );

      if (response == null) {
        // hideLoading();
        showError('No response from server');
        return false;
      }
      // hideLoading();
      Future.delayed(Duration(milliseconds: 300));
      // Use approvedDialog instead of showSuccess
      await approvedDialog('Success', 'Duty status updated successfully');
      return true;
    } catch (error) {
      debugPrint('Error toggling duty: $error');
      showError('Failed to update duty status');
      return false;
    }
  }

  Future<void> vehicleTypesAPICall() async {
    isVehicleLoading.value = true;

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': GetStorage().read(accessToken),
      };

      var response = await ServiceCall().get(
        ApiConstant.baseUrl,
        // "${ApiConstant.userWiseVehicle}/1",
        ApiConstant.vehicleTypes,
        headers,
      );

      if (response == null) {
        throw Exception('No response from server');
      }

      var parsedResponse = GetVehicleTypeResponseModel.fromJson(
        jsonDecode(response),
      );

      // if (parsedResponse.message ?? false) {
      vehicleTypeList.value = parsedResponse;
      // } else {
      //   throw Exception(parsedResponse.message ?? 'Failed to load vehicles');
      // }
    } catch (error) {
      // errorMessage.value = error is DioException
      //     ? error.response?.data?['message'] ?? error.message ?? 'Network error occurred'
      //     : error.toString();
      debugPrint('Error loading vehicle Types: $error');
    } finally {
      isVehicleLoading.value = false;
    }
  }

  Future<void> userWiseVehicleListCall() async {
    isVehicleLoading.value = true;

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': GetStorage().read(accessToken),
      };

      // Build the API endpoint with query parameters
      String endpoint = ApiConstant.vehicleList;
      List<String> queryParams = [];

      // Add vehicle_type filter if selected
      if (selectedVehicleType.value != null) {
        queryParams.add('vehicle_type=${selectedVehicleType.value}');
      }

      // Add search query if not empty
      if (searchQuery.value.isNotEmpty) {
        queryParams.add('search=${Uri.encodeComponent(searchQuery.value)}');
      }

      // Combine query parameters
      if (queryParams.isNotEmpty) {
        endpoint += '?${queryParams.join('&')}';
      }

      debugPrint('Fetching vehicles with endpoint: $endpoint');

      var response = await ServiceCall().get(
        ApiConstant.baseUrl,
        endpoint,
        headers,
      );

      if (response == null) {
        throw Exception('No response from server');
      }

      var parsedResponse = GetUserWiseVehicleResponseModel.fromJson(
        jsonDecode(response),
      );

      userWiseVehicleList.value = parsedResponse;
    } catch (error) {
      hideLoading();
      String userMessage = 'An unknown error occurred';

      if (error is DioException) {
        final responseData = error.response?.data;
        debugPrint('Response Data: $responseData');

        Map<String, dynamic>? parsedData;
        if (responseData is String) {
          try {
            parsedData = jsonDecode(responseData) as Map<String, dynamic>?;
          } catch (e) {
            debugPrint('Failed to parse responseData string: $e');
          }
        } else if (responseData is Map) {
          parsedData = Map<String, dynamic>.from(responseData);
        }

        if (parsedData != null) {
          if (parsedData['detail'] != null) {
            userMessage = parsedData['detail'].toString();
          } else if (parsedData['message'] != null) {
            userMessage = parsedData['message'].toString();
          } else if (parsedData['error'] != null) {
            userMessage = parsedData['error'].toString();
          } else if (parsedData['errors'] != null) {
            final errors = parsedData['errors'] as Map<String, dynamic>;
            userMessage = errors.entries
                .map((entry) {
                  final value = entry.value;
                  if (value is List) return value.join(', ');
                  return value.toString();
                })
                .join('\n');
          }
        } else {
          userMessage = error.message ?? userMessage;
        }

        declineDialog("Error", userMessage).then((_) {});
      } else {
        debugPrint('Error is not a DioException: $error');
        handleError(error);
      }
    } finally {
      isVehicleLoading.value = false;
    }
  }

  void showError(String message) {
    // You can use your preferred way to show error messages
    Get.snackbar(
      'Error',
      message,
      backgroundColor: ColorConstant.clrError,
      colorText: Colors.white,
    );
  }
}
