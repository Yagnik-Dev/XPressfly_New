import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Models/get_vehicle_type.dart';
import 'package:xpressfly_git/Screens/Customer/select_delivery_area_dialog.dart';
import 'package:xpressfly_git/Services/rest_service.dart';
import 'package:xpressfly_git/Utility/common_imports.dart';
import '../Constants/api_constant.dart';
import '../Constants/storage_constant.dart';

class CustomerHomeController extends GetxController {
  var isVehicleLoading = false.obs;
  Rx<GetVehicleTypeResponseModel> vehicleTypeList =
      GetVehicleTypeResponseModel().obs;
  @override
  void onInit() {
    getData();
    Future.delayed(Duration(seconds: 1), () {
      Get.dialog(const SelectDeliveryAreaDialog());
    });

    super.onInit();
  }

  Future<void> getData() async {
    await vehicleTypesAPICall();
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
}
