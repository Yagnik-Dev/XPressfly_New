import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Common%20Components/common_textfield.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/add_vehicle_maincontroller.dart';
import 'package:xpressfly_git/Screens/Driver/vehicle_type_dialog.dart';
import 'package:xpressfly_git/Localization/localization_keys.dart';

class AddVehicleTwo extends StatelessWidget {
  AddVehicleTwo({super.key});

  final AddVehicleMainController addvehicleController =
      Get.find<AddVehicleMainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.clrF2FAFF,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 18.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 22.w,
                      ),
                      child: Image.asset(ImageConstant.imgAddVehicleTwo),
                    ),
                    Text(
                      LocalizationKeys.vehicleDetails.tr,
                      style:
                          TextStyleConstant().subTitleTextStyle18w600Clr242424,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Form(
                  key: addvehicleController.addVehicleTwoFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LocalizationKeys.vehicleModel.tr,
                                  style:
                                      TextStyleConstant()
                                          .subTitleTextStyle16w500Clr242424,
                                ),
                                SizedBox(height: 6.h),
                                CommonTextFormFieldWithoutBorder(
                                  controller:
                                      addvehicleController
                                          .vehicleModelTextEditingController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return LocalizationKeys
                                          .pleaseEnterVehicleModel
                                          .tr;
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 7.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LocalizationKeys.vehicleNumber.tr,
                                  style:
                                      TextStyleConstant()
                                          .subTitleTextStyle16w500Clr242424,
                                ),
                                SizedBox(height: 6.h),
                                CommonTextFormFieldWithoutBorder(
                                  controller:
                                      addvehicleController
                                          .vehicleNoTextEditingController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return LocalizationKeys
                                          .pleaseEnterVehicleNumber
                                          .tr;
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        LocalizationKeys.vehicleType.tr,
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle16w500Clr242424,
                      ),
                      SizedBox(height: 6.h),
                      GestureDetector(
                        onTap: () {
                          Get.focusScope?.unfocus();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return VehicleTypeScreen(
                                onSelected:
                                    addvehicleController.pickVehicleType,
                              );
                            },
                          );
                        },
                        child: Obx(
                          () => Container(
                            // alignment: Alignment.topLeft,
                            padding: EdgeInsets.fromLTRB(
                              12.w,
                              addvehicleController.selectedVehicleTitle.value ==
                                      ""
                                  ? 22.5.h
                                  : 13.5.h,
                              0.w,
                              addvehicleController.selectedVehicleTitle.value ==
                                      ""
                                  ? 22.5.h
                                  : 13.5.h,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  addvehicleController
                                              .selectedVehicleTitle
                                              .value ==
                                          ""
                                      ? ColorConstant.clrWhite
                                      : addvehicleController
                                          .selectedVehicleColor
                                          .value,
                              borderRadius: BorderRadius.circular(8.5.r),
                              border: Border.all(
                                color: ColorConstant.clrEEEEEE,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (addvehicleController
                                        .selectedVehicleTitle
                                        .value !=
                                    "")
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: Text(
                                      addvehicleController
                                          .selectedVehicleTitle
                                          .value,
                                      style:
                                          TextStyleConstant()
                                              .subTitleTextStyle18w600Clr242424,
                                    ),
                                  ),
                                Spacer(),
                                if (addvehicleController
                                        .selectedVehicleIcon
                                        .value !=
                                    "")
                                  Image.network(
                                    addvehicleController
                                        .selectedVehicleIcon
                                        .value,
                                    height: 75.h,
                                    width: 75.w,
                                    // fit: BoxFit.contain,
                                  ),
                                // Icon(
                                //   Icons.arrow_drop_down,
                                //   color: ColorConstant.clrSubText,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        LocalizationKeys.whereYouCanDeliver.tr,
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle16w500Clr242424,
                      ),
                      SizedBox(height: 6.h),
                      CommonTextFormFieldWithoutBorder(
                        controller:
                            addvehicleController.pinCodeTextEditingController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            // Remove any non-digit characters
                            String digitsOnly = value.replaceAll(
                              RegExp(r'[^0-9]'),
                              '',
                            );

                            // Split into groups of 6 digits
                            List<String> pincodes = [];
                            for (int i = 0; i < digitsOnly.length; i += 6) {
                              if (i + 6 <= digitsOnly.length) {
                                pincodes.add(digitsOnly.substring(i, i + 6));
                              }
                            }

                            // Join with commas and add remaining digits
                            String formattedText = pincodes.join(', ');
                            if (digitsOnly.length % 6 != 0) {
                              if (pincodes.isNotEmpty) formattedText += ', ';
                              formattedText += digitsOnly.substring(
                                (digitsOnly.length ~/ 6) * 6,
                              );
                            }

                            // Update text field value
                            if (formattedText != value) {
                              addvehicleController
                                  .pinCodeTextEditingController
                                  .value = TextEditingValue(
                                text: formattedText,
                                selection: TextSelection.collapsed(
                                  offset: formattedText.length,
                                ),
                              );
                            }
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocalizationKeys
                                .pleaseEnterDeliveryPincodes
                                .tr;
                          }
                          // Validate that all pincodes are 6 digits
                          List<String> pincodes =
                              value.split(',').map((e) => e.trim()).toList();
                          for (String pincode in pincodes) {
                            if (pincode.length != 6 ||
                                !RegExp(r'^[0-9]+$').hasMatch(pincode)) {
                              return LocalizationKeys
                                  .allPincodesMustBe6Digits
                                  .tr;
                            }
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
