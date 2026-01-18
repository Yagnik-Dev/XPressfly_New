import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xpressfly_git/Common%20Components/common_textfield.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/add_vehicle_maincontroller.dart';
import 'package:xpressfly_git/Localization/localization_keys.dart';

class AddVehicleOne extends StatelessWidget {
  AddVehicleOne({super.key});

  final AddVehicleMainController addvehicleController =
      Get.find<AddVehicleMainController>();

  Future<void> _pickImage(ImageSource source, Rx<File?> imageFile) async {
    await addvehicleController.pickImage(source, imageFile);
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
      backgroundColor: ColorConstant.clrWhite,

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
                      child: Image.asset(ImageConstant.imgAddVehicleThree),
                    ),
                    Text(
                      LocalizationKeys.yourDetails.tr,
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
                  key: addvehicleController.addVehicleFormKey,
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
                                  LocalizationKeys.fullName.tr,
                                  style:
                                      TextStyleConstant()
                                          .subTitleTextStyle16w500Clr242424,
                                ),
                                SizedBox(height: 6.h),
                                CommonTextFormFieldWithoutBorder(
                                  readOnly: true,
                                  maxLines: 1,
                                  controller:
                                      addvehicleController
                                          .fullNameTextEditingController,
                                  validator:
                                      (p0) =>
                                          p0 == null || p0.isEmpty
                                              ? LocalizationKeys
                                                  .pleaseEnterFullName
                                                  .tr
                                              : null,
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
                                  LocalizationKeys.number.tr,
                                  style:
                                      TextStyleConstant()
                                          .subTitleTextStyle16w500Clr242424,
                                ),
                                SizedBox(height: 6.h),
                                CommonTextFormFieldWithoutBorder(
                                  readOnly: true,
                                  controller:
                                      addvehicleController
                                          .mobileNoTextEditingController,
                                  maxLines: 1,
                                  keyboardType: TextInputType.phone,
                                  maxLength: 10,
                                  validator:
                                      (p0) =>
                                          p0 == null || p0.isEmpty
                                              ? LocalizationKeys
                                                  .pleaseEnterMobileNumber
                                                  .tr
                                              : null,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        LocalizationKeys.address.tr,
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle16w500Clr242424,
                      ),
                      SizedBox(height: 6.h),
                      CommonTextFormFieldWithoutBorder(
                        readOnly: true,
                        maxLines: 2,
                        controller:
                            addvehicleController.addressTextEditingController,
                        validator:
                            (p0) =>
                                p0 == null || p0.isEmpty
                                    ? LocalizationKeys.pleaseEnterAddress.tr
                                    : null,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        LocalizationKeys.uploadYourRcBookImages.tr,
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle16w500Clr242424,
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildImageField(
                              title: LocalizationKeys.uploadFront.tr,
                              imageFile: addvehicleController.rcBookFrontImg,
                              onTap:
                                  () => _showImageSourceDialog(
                                    addvehicleController.rcBookFrontImg,
                                  ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: _buildImageField(
                              title: LocalizationKeys.uploadBack.tr,
                              imageFile: addvehicleController.rcBookBackImg,
                              onTap:
                                  () => _showImageSourceDialog(
                                    addvehicleController.rcBookBackImg,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [..
                      //     Expanded(
                      //       child: CommonTextFormFieldWithoutBorder(
                      //         controller:
                      //             addvehicleController
                      //                 .licenseNoTextEditingController,
                      //         validator:
                      //             (p0) =>
                      //                 p0 == null || p0.isEmpty
                      //                     ? 'Please enter license number'
                      //                     : null,
                      //       ),
                      //     ),
                      //     SizedBox(width: 10.w),
                      //     Expanded(
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           _buildImageField(
                      //             title: "Select Image",
                      //             imageFile: addvehicleController.licenceImg,
                      //             onTap:
                      //                 () => _showImageSourceDialog(
                      //                   addvehicleController.licenceImg,
                      //                 ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
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
