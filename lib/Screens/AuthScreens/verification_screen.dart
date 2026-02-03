import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xpressfly_git/Common%20Components/common_button.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/verification_controller.dart';
import 'package:xpressfly_git/Localization/localization_keys.dart';
import 'package:xpressfly_git/Screens/AuthScreens/bank_details_screen.dart';
import 'package:xpressfly_git/Screens/AuthScreens/device_info_details.dart';
import 'package:xpressfly_git/Utility/app_utility.dart';
// ignore: implementation_imports
import 'package:dio/src/form_data.dart' as formdata;
// ignore: implementation_imports
import 'package:dio/src/multipart_file.dart' as multipart_file;

class VerificationScreen extends StatelessWidget {
  final int type;
  final String? mobileNo;
  final String? otp;
  final String? name;
  final String? city;
  final String? email;
  final String? pincode;

  VerificationScreen({
    super.key,
    required this.type,
    this.mobileNo,
    this.otp,
    this.name,
    this.city,
    this.email,
    this.pincode,
  });

  final VerificationController verificationController = Get.put(
    VerificationController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.clrF7FCFF,
      appBar: AppBar(
        backgroundColor: ColorConstant.clrF7FCFF,
        centerTitle: true,
        elevation: 0,
        leadingWidth: 70.w,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Container(
              height: 50.w,
              width: 50.w,
              decoration: BoxDecoration(
                color: ColorConstant.clrWhite,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back,
                color: ColorConstant.clrPrimary,
                size: 30.sp,
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        title: Text(
          LocalizationKeys.verification.tr,
          style: TextStyleConstant().titleTextStyle26w600Clr242424,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(28),
            bottomRight: Radius.circular(28),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 150.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              decoration: BoxDecoration(
                color: ColorConstant.clrWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 70.h),
                          Text(
                            LocalizationKeys.uploadYourAadhaarImages.tr,
                            style:
                                TextStyleConstant()
                                    .subTitleTextStyle16w500Clr242424,
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _buildImageField(
                                  title: "Upload front",
                                  imageFile:
                                      verificationController.aadharFrontImg,
                                  onTap:
                                      () => _showImageSourceDialog(
                                        verificationController.aadharFrontImg,
                                      ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: _buildImageField(
                                  title: "Upload back",
                                  imageFile:
                                      verificationController.aadharBackImg,
                                  onTap:
                                      () => _showImageSourceDialog(
                                        verificationController.aadharBackImg,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Visibility(
                            visible: type == 1,
                            child: Column(
                              children: [
                                Text(
                                  LocalizationKeys.uploadYourLicenceImages.tr,
                                  style:
                                      TextStyleConstant()
                                          .subTitleTextStyle16w500Clr242424,
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: _buildImageField(
                                        title: LocalizationKeys.uploadFront.tr,
                                        imageFile:
                                            verificationController
                                                .licenseFrontImg,
                                        onTap:
                                            () => _showImageSourceDialog(
                                              verificationController
                                                  .licenseFrontImg,
                                            ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: _buildImageField(
                                        title: LocalizationKeys.uploadBack.tr,
                                        imageFile:
                                            verificationController
                                                .licenseBackImg,
                                        onTap:
                                            () => _showImageSourceDialog(
                                              verificationController
                                                  .licenseBackImg,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// FIXED BOTTOM BUTTON
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.h, top: 10.h),
                    child:
                        type == 1
                            ? CommonButtonRounded(
                              color: ColorConstant.clrSecondary,
                              btnText: LocalizationKeys.next.tr,
                              onPressed: () {
                                if (_validateImages()) {
                                  Get.to(
                                    () => BankDetailsScreen(
                                      type: type,
                                      mobileNo: mobileNo,
                                      otp: otp,
                                      name: name,
                                      email: email,
                                      city: city,
                                      pincode: pincode,
                                      aadharFrontImg:
                                          verificationController
                                              .aadharFrontImg
                                              .value!,
                                      aadharBackImg:
                                          verificationController
                                              .aadharBackImg
                                              .value!,
                                      licenseFrontImg:
                                          verificationController
                                              .licenseFrontImg
                                              .value!,
                                      licenseBackImg:
                                          verificationController
                                              .licenseBackImg
                                              .value!,
                                    ),
                                  );
                                }
                              },
                            )
                            : CommonButton(
                              color: ColorConstant.clrSecondary,
                              radius: 50.sp,
                              btnText: LocalizationKeys.saveDetails.tr,
                              onPressed: () async {
                                // if (bankDetailController.bankDetailFormKey.currentState!
                                //     .validate()) {
                                deviceInfo = await getDeviceInfo();
                                var formData = formdata.FormData.fromMap({
                                  "phone": mobileNo,
                                  // "otp": otp,
                                  "name": name,
                                  "city": city,
                                  "pincode": pincode,
                                  "device_fcm_token":
                                      "c_-jq5UPIwCQilLKVuWtgf:APA91bFG4hy_yuIW2OidJLe7CCWWtM6u5hMolcMcXATwrUDTv9nzq4fd5NnA97vyEtb9VnzS4l7CmEtwDQQRLoBKoUVtceb9OyUb7iWjEbeQs6RKgGV2w74",
                                  "device_id": deviceInfo["deviceId"],
                                  "device_name": deviceInfo["deviceName"],
                                  "device_type": deviceInfo["deviceType"],
                                  "is_duty_on": "",
                                  "profile_image": "",
                                  "email": email,
                                  "address": "surat",
                                  // "adhar_card_front": aadharFrontImg.path,
                                  // "adhar_card_back": aadharBackImg.path,
                                  // "driver_license_front": licenseFrontImg.path,
                                  // "driver_license_back": licenseBackImg.path,
                                });
                                formData.files.add(
                                  MapEntry(
                                    "adhar_card_front",
                                    multipart_file.MultipartFile.fromFileSync(
                                      verificationController
                                          .aadharFrontImg
                                          .value!
                                          .path,
                                      filename:
                                          verificationController
                                              .aadharFrontImg
                                              .value!
                                              .path
                                              .split('/')
                                              .last,
                                    ),
                                  ),
                                );

                                formData.files.add(
                                  MapEntry(
                                    "adhar_card_back",
                                    multipart_file.MultipartFile.fromFileSync(
                                      verificationController
                                          .aadharBackImg
                                          .value!
                                          .path,
                                      filename:
                                          verificationController
                                              .aadharBackImg
                                              .value!
                                              .path
                                              .split('/')
                                              .last,
                                    ),
                                  ),
                                );

                                await verificationController
                                    .createCustomerApiCall((isSuccess) {
                                      if (isSuccess) {
                                        showMessage(
                                          "Success",
                                          "Customer created successfully",
                                        );
                                      }
                                    }, details: formData);
                                // }
                              },
                            ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20.h,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                ImageConstant.imgVerification,
                height: 180.h,
                width: 160.w,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageField({
    required String title,
    required Rx<File?> imageFile,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   title,
        //   style: TextStyleConstant().subTitleTextStyle16w500Clr242424,
        // ),
        // SizedBox(height: 6.h),
        GestureDetector(
          onTap: onTap,
          child: Obx(() {
            return Container(
              // height: imageFile.value != null ? 100.h : null,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 0.7),
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white,
              ),
              child:
                  imageFile.value != null
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.file(
                          imageFile.value!,
                          width: double.infinity,
                          height: 82.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildUploadPlaceholder(null);
                          },
                        ),
                      )
                      : _buildUploadPlaceholder(title),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildUploadPlaceholder(String? placeHolder) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstant.clrFAFBFF,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
      child: Column(
        children: [
          Icon(
            Icons.file_upload_outlined,
            size: 30.sp,
            color: ColorConstant.clr999999,
          ),
          Text(
            placeHolder ?? LocalizationKeys.upload.tr,
            style: TextStyle(fontSize: 14.sp, color: ColorConstant.clr999999),
          ),
        ],
      ),
    );
  }

  void _showImageSourceDialog(Rx<File?> imageFile) {
    Get.focusScope?.unfocus();
    showModalBottomSheet(
      context: Get.context!,
      builder:
          (context) => SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                      _pickImage(ImageSource.gallery, imageFile);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundColor: ColorConstant.clrSecondary,
                          child: Icon(
                            Icons.photo_library,
                            color: ColorConstant.clrWhite,
                            size: 30.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          LocalizationKeys.gallery.tr,
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle16w400clrSecondary,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                      _pickImage(ImageSource.camera, imageFile);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundColor: ColorConstant.clrSecondary,
                          child: Icon(
                            Icons.photo_camera,
                            color: ColorConstant.clrWhite,
                            size: 30.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          LocalizationKeys.camera.tr,
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle16w400clrSecondary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Future<void> _pickImage(ImageSource source, Rx<File?> imageFile) async {
    await verificationController.pickImage(source, imageFile);
  }

  bool _validateImages() {
    if (verificationController.aadharFrontImg.value == null) {
      showMessage(
        LocalizationKeys.alert.tr,
        LocalizationKeys.pleaseUploadAadhaarFrontImage.tr,
      );
      return false;
    }

    if (verificationController.aadharBackImg.value == null) {
      showMessage(
        LocalizationKeys.alert.tr,
        LocalizationKeys.pleaseUploadAadhaarBackImage.tr,
      );
      return false;
    }

    if (verificationController.licenseFrontImg.value == null) {
      showMessage(
        LocalizationKeys.alert.tr,
        LocalizationKeys.pleaseUploadLicenseFrontImage.tr,
      );
      return false;
    }

    if (verificationController.licenseBackImg.value == null) {
      showMessage(
        LocalizationKeys.alert.tr,
        LocalizationKeys.pleaseUploadLicenseBackImage.tr,
      );
      return false;
    }

    return true;
  }
}
