import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Constants/api_constant.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Models/get_vehicle_Details_model.dart';
import 'package:xpressfly_git/Utility/app_utility.dart';
import '../Services/rest_service.dart';

class VehicleDetailsController extends GetxController {
  var isVehicleLoading = false.obs;
  Rx<GetVehicleResponseModel> vehicleDetails = GetVehicleResponseModel().obs;
  int vehicleId = 0;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is int) {
      vehicleId = Get.arguments as int;
    }
    getData();
  }

  Future<void> getData() async {
    await getVehicleDetailsCall(vehicleId);
  }

  Future<void> getVehicleDetailsCall(int vehicleId) async {
    Future.delayed(Duration.zero, () {
      showLoading();
    });

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': GetStorage().read(accessToken),
      };

      var response = await ServiceCall().get(
        ApiConstant.baseUrl,
        "${ApiConstant.vehicleList}$vehicleId/",
        headers,
      );

      if (response == null) {
        throw Exception('No response from server');
      }

      var parsedResponse = GetVehicleResponseModel.fromJson(
        jsonDecode(response),
      );

      // if (parsedResponse.success ?? false) {
      vehicleDetails.value = parsedResponse;
      hideLoading();
      // } else {
      //   throw Exception(parsedResponse.message ?? 'Failed to load vehicles');
      // }
    } catch (error) {
      hideLoading();

      debugPrint('Error loading vehicle Details: $error');
    } finally {
      // isVehicleLoading.value = false;
      hideLoading();
    }
  }

  Future<bool> deleteVehicleCall() async {
    try {
      showLoading();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': GetStorage().read(accessToken),
      };

      var response = await ServiceCall().delete(
        ApiConstant.baseUrl,
        "${ApiConstant.deleteVehicles}$vehicleId",
        headers,
      );

      if (response == null) {
        throw Exception('No response from server');
      }

      var parsedResponse = jsonDecode(response);

      if (parsedResponse['success'] == true) {
        hideLoading();
        return true;
      } else {
        throw Exception(
          parsedResponse['message'] ?? 'Failed to delete vehicle',
        );
      }
    } catch (error) {
      hideLoading();
      debugPrint('Error deleting vehicle: $error');
      return false;
    }
  }
}
