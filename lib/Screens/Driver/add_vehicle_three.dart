import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/add_vehicle_maincontroller.dart';

class AddVehicleThree extends StatelessWidget {
  AddVehicleThree({super.key});

  final AddVehicleMainController addVehicleMainController =
      Get.find<AddVehicleMainController>();

  Future<void> _pickImage(ImageSource source, Rx<File?> imageFile) async {
    await addVehicleMainController.pickImage(source, imageFile);
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
              height: imageFile.value != null ? 100.h : 44.h,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 0.7),
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white,
              ),
              child:
                  imageFile.value != null
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.file(
                          imageFile.value!,
                          width: double.infinity,
                          height: 40.h,
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
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          Icon(Icons.upload, size: 20.sp, color: Colors.grey.shade500),
          SizedBox(width: 8.w),
          Text(
            placeHolder ?? "Upload",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
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
                          'Gallery',
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
                          'Camera',
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
                      "Verification",
                      style:
                          TextStyleConstant().subTitleTextStyle18w600Clr242424,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Upload Aadhar Front & Back",
                      style:
                          TextStyleConstant().subTitleTextStyle16w500Clr242424,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildImageField(
                            title: "Front Image",
                            imageFile: addVehicleMainController.aadharFrontImg,
                            onTap:
                                () => _showImageSourceDialog(
                                  addVehicleMainController.aadharFrontImg,
                                ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: _buildImageField(
                            title: "Back Image",
                            imageFile: addVehicleMainController.aadharBackImg,
                            onTap:
                                () => _showImageSourceDialog(
                                  addVehicleMainController.aadharBackImg,
                                ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Upload RC Book Front & Back",
                      style:
                          TextStyleConstant().subTitleTextStyle16w500Clr242424,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildImageField(
                            title: "Front Image",
                            imageFile: addVehicleMainController.rcBookFrontImg,
                            onTap:
                                () => _showImageSourceDialog(
                                  addVehicleMainController.rcBookFrontImg,
                                ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: _buildImageField(
                            title: "Back Image",
                            imageFile: addVehicleMainController.rcBookBackImg,
                            onTap:
                                () => _showImageSourceDialog(
                                  addVehicleMainController.rcBookBackImg,
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
    );
  }
}
