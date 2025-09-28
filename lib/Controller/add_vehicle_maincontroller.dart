import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddVehicleMainController extends GetxController {
  var fullNameTextEditingController = TextEditingController();
  var mobileNoTextEditingController = TextEditingController();
  var licenseNoTextEditingController = TextEditingController();
  var addressTextEditingController = TextEditingController();
  GlobalKey<FormState> addVehicleFormKey = GlobalKey<FormState>();
  Rx<File?> licenceImg = Rx<File?>(null);

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
}
