import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Constants/api_constant.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Models/get_vehicle_Details_model.dart';
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
    isVehicleLoading.value = true;

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': GetStorage().read(accessToken),
      };

      var response = await ServiceCall().get(
        ApiConstant.baseUrl,
        "${ApiConstant.vehiclesDetails}/$vehicleId",
        headers,
      );

      if (response == null) {
        throw Exception('No response from server');
      }

      var parsedResponse = GetVehicleResponseModel.fromJson(
        jsonDecode(response),
      );

      if (parsedResponse.success ?? false) {
        vehicleDetails.value = parsedResponse;
      } else {
        throw Exception(parsedResponse.message ?? 'Failed to load vehicles');
      }
    } catch (error) {
      debugPrint('Error loading vehicles: $error');
    } finally {
      isVehicleLoading.value = false;
    }
  }

  Future<void> deleteVehicleCall(int vehicleId) async {
    isVehicleLoading.value = true;

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': GetStorage().read(accessToken),
      };

      var response = await ServiceCall().delete(
        ApiConstant.baseUrl,
        "${ApiConstant.vehiclesDetails}/$vehicleId",
        headers,
      );

      if (response == null) {
        throw Exception('No response from server');
      }

      var parsedResponse = GetVehicleResponseModel.fromJson(
        jsonDecode(response),
      );

      if (parsedResponse.success ?? false) {
        vehicleDetails.value = parsedResponse;
      } else {
        throw Exception(parsedResponse.message ?? 'Failed to load vehicles');
      }
    } catch (error) {
      debugPrint('Error loading vehicles: $error');
    } finally {
      isVehicleLoading.value = false;
    }
  }
}
