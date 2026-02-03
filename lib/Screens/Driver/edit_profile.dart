import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xpressfly_git/Common%20Components/common_textfield.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/profile_controller.dart';
import 'package:xpressfly_git/Localization/localization_keys.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final ProfileController profileController = Get.find<ProfileController>();

  Future<void> _pickImage(ImageSource source, Rx<File?> imageFile) async {
    await profileController.pickImage(source, imageFile);
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
                            Icons.image,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          LocalizationKeys.gallery.tr,
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle14w400clr666666,
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
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          LocalizationKeys.camera.tr,
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle14w400clr666666,
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

  // Widget _buildImageField({
  //   required String title,
  //   required Rx<File?> imageFile,
  //   required VoidCallback onTap,
  // }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         title,
  //         style: TextStyleConstant().subTitleTextStyle16w500ClrSubText,
  //       ),
  //       SizedBox(height: 8.h),
  //       GestureDetector(
  //         onTap: onTap,
  //         child: Obx(
  //           () => Container(
  //             height: 120.h,
  //             width: double.infinity,
  //             decoration: BoxDecoration(
  //               border: Border.all(color: ColorConstant.clrBorder, width: 2),
  //               borderRadius: BorderRadius.circular(12.r),
  //             ),
  //             child:
  //                 imageFile.value == null
  //                     ? Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Icon(
  //                           Icons.cloud_upload_outlined,
  //                           size: 32.sp,
  //                           color: ColorConstant.clrSecondary,
  //                         ),
  //                         SizedBox(height: 8.h),
  //                         Text(
  //                           LocalizationKeys.tapToUpload.tr,
  //                           style:
  //                               TextStyleConstant()
  //                                   .subTitleTextStyle14w400ClrSubText,
  //                         ),
  //                       ],
  //                     )
  //                     : Image.file(imageFile.value!, fit: BoxFit.cover),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final userRole1 = GetStorage().read(userRole) ?? 'customer';
    final isDriver = userRole1 == 'driver';

    return Theme(
      data: ThemeData(
        dividerTheme: DividerThemeData(color: Colors.transparent),
      ),
      child: Scaffold(
        backgroundColor: ColorConstant.clrF7FCFF,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            LocalizationKeys.editProfile.tr,
            style: TextStyleConstant().titleTextStyle26w600Clr242424,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
          ),
        ),
        persistentFooterButtons: [
          Container(
            color: ColorConstant.clrWhite,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
                top: 0,
                left: 22,
                right: 22,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.r),
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 100.w,
                        alignment: Alignment.center,
                        child: Text(
                          LocalizationKeys.back.tr,
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle18w600Clr242424,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        if (profileController.formKeyProfile.currentState!
                            .validate()) {
                          profileController.updateUserProfile((success) async {
                            if (success) {
                              // Clear the local profile image cache
                              // profileController.profileImage.value = null;

                              // Refresh user details from API to get updated image URL
                              await profileController.getUserDetails((p0) {});

                              // Force refresh
                              await Future.delayed(Duration(milliseconds: 500));

                              // Refresh the observable to trigger UI update
                              profileController.userDetails.refresh();

                              Get.back(result: true);
                            }
                          });
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: ColorConstant.clrSecondary,
                        side: const BorderSide(color: Colors.transparent),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(
                        LocalizationKeys.save.tr,
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle18w500clrFFFAFA,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Obx(
                        () => CircleAvatar(
                          radius: 50.r,
                          backgroundImage:
                              profileController.profileImage.value != null
                                  ? FileImage(
                                    profileController.profileImage.value!,
                                  )
                                  : (profileController
                                                      .userDetails
                                                      .value
                                                      .user
                                                      ?.profileImage !=
                                                  null &&
                                              profileController
                                                  .userDetails
                                                  .value
                                                  .user!
                                                  .profileImage!
                                                  .isNotEmpty
                                          ? NetworkImage(
                                            profileController
                                                .userDetails
                                                .value
                                                .user!
                                                .profileImage!,
                                          )
                                          : NetworkImage(
                                            "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                                          ))
                                      as ImageProvider,
                        ),
                      ),
                      // Only show camera icon for profile image if customer
                      // if (!isDriver)
                      InkWell(
                        onTap:
                            () => _showImageSourceDialog(
                              profileController.profileImage,
                            ),
                        child: Container(
                          margin: EdgeInsets.only(left: 6.w, top: 4.h),
                          padding: EdgeInsets.all(8.sp),
                          decoration: BoxDecoration(
                            color: ColorConstant.clrWhite,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: ColorConstant.clrEEEEEE,
                              width: 2.w,
                            ),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            size: 14.h,
                            color: ColorConstant.clrPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: 200.w,
                    child: Obx(
                      () =>
                          profileController.isEditingName.value
                              ? CommonTextFormFieldWithoutBorder(
                                controller:
                                    profileController.nameTextEditingController,
                                hintText: LocalizationKeys.enterYourName.tr,
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(right: 8.w),
                                  child: InkWell(
                                    onTap:
                                        () =>
                                            profileController
                                                .isEditingName
                                                .value = false,
                                    child: Icon(
                                      Icons.check,
                                      size: 18.h,
                                      color: ColorConstant.clrPrimary,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return LocalizationKeys
                                        .pleaseEnterYourName
                                        .tr;
                                  }
                                  return null;
                                },
                              )
                              : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    profileController
                                        .nameTextEditingController
                                        .text,
                                    style: TextStyleConstant()
                                        .subTitleTextStyle22w600Clr242424
                                        .copyWith(fontSize: 22.sp),
                                  ),
                                  SizedBox(width: 8.w),
                                  InkWell(
                                    onTap:
                                        () =>
                                            profileController
                                                .isEditingName
                                                .value = true,
                                    child: Icon(
                                      Icons.edit,
                                      size: 18.h,
                                      color: ColorConstant.clrSubText,
                                    ),
                                  ),
                                ],
                              ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: ColorConstant.clrWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: Form(
                  key: profileController.formKeyProfile,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocalizationKeys.yourDetails.tr,
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle20w500Clr242424,
                      ),
                      SizedBox(height: 20.h),
                      // Phone Field
                      Text(
                        LocalizationKeys.phoneNumber.tr,
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle16w500ClrSubText,
                      ),
                      SizedBox(height: 6.h),
                      CommonTextFormFieldWithoutBorder(
                        hintText: LocalizationKeys.examplePhone.tr,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        readOnly: true,
                        controller:
                            profileController.mobileTextEditingController,
                        // suffixIcon: Icon(
                        //   Icons.edit,
                        //   color: ColorConstant.clrPrimary,
                        //   size: 18.h,
                        // ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocalizationKeys.pleaseEnterMobileNumber.tr;
                          } else if (value.length < 10) {
                            return LocalizationKeys
                                .mobileNumberMustBe10Digits
                                .tr;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      // Email Field
                      Text(
                        LocalizationKeys.email.tr,
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle16w500ClrSubText,
                      ),
                      SizedBox(height: 6.h),
                      CommonTextFormFieldWithoutBorder(
                        controller:
                            profileController.emailTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: LocalizationKeys.userEmailExample.tr,
                        suffixIcon: Icon(
                          Icons.edit,
                          color: ColorConstant.clrPrimary,
                          size: 18.h,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocalizationKeys.pleaseEnterEmail.tr;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      // Pincode Field
                      Text(
                        LocalizationKeys.pincode.tr,
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle16w500ClrSubText,
                      ),
                      SizedBox(height: 6.h),
                      CommonTextFormFieldWithoutBorder(
                        controller:
                            profileController.pincodeTextEditingController,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        suffixIcon: Icon(
                          Icons.edit,
                          color: ColorConstant.clrPrimary,
                          size: 18.h,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocalizationKeys.pleaseEnterPincode.tr;
                          } else if (value.length != 6) {
                            return LocalizationKeys.pincodeMustBe6Digits.tr;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      // City Field
                      Text(
                        LocalizationKeys.city.tr,
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle16w500ClrSubText,
                      ),
                      SizedBox(height: 6.h),
                      CommonTextFormFieldWithoutBorder(
                        hintText: LocalizationKeys.enterYourCity.tr,
                        controller: profileController.cityTextEditingController,
                        suffixIcon: Icon(
                          Icons.edit,
                          color: ColorConstant.clrPrimary,
                          size: 18.h,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocalizationKeys.pleaseEnterCity.tr;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      // Address Field
                      Text(
                        LocalizationKeys.address.tr,
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle16w500ClrSubText,
                      ),
                      SizedBox(height: 6.h),
                      CommonTextFormFieldWithoutBorder(
                        hintText: LocalizationKeys.addressExample.tr,
                        controller:
                            profileController.addressTextEditingController,
                        maxLines: 2,
                        suffixIcon: Icon(
                          Icons.edit,
                          color: ColorConstant.clrPrimary,
                          size: 18.h,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocalizationKeys.pleaseEnterAddress.tr;
                          }
                          return null;
                        },
                      ),
                      // if (!isDriver) ...[
                      //   SizedBox(height: 20.h),
                      //   Text(
                      //     "Documents",
                      //     style:
                      //         TextStyleConstant()
                      //             .subTitleTextStyle20w500Clr242424,
                      //   ),
                      //   SizedBox(height: 16.h),
                      //   _buildImageField(
                      //     title: "Aadhar Card Front",
                      //     imageFile: profileController.aadharCardFront,
                      //     onTap:
                      //         () => _showImageSourceDialog(
                      //           profileController.aadharCardFront,
                      //         ),
                      //   ),
                      //   SizedBox(height: 16.h),
                      //   _buildImageField(
                      //     title: "Aadhar Card Back",
                      //     imageFile: profileController.aadharCardBack,
                      //     onTap:
                      //         () => _showImageSourceDialog(
                      //           profileController.aadharCardBack,
                      //         ),
                      //   ),
                      // ],
                      // Bank Details Section - Only for Drivers
                      if (isDriver) ...[
                        SizedBox(height: 20.h),
                        Text(
                          LocalizationKeys.bankDetails.tr,
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle20w500Clr242424,
                        ),
                        SizedBox(height: 16.h),
                        // Bank Account Holder Name
                        Text(
                          LocalizationKeys.accountHolderName.tr,
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle16w500ClrSubText,
                        ),
                        SizedBox(height: 6.h),
                        CommonTextFormFieldWithoutBorder(
                          controller:
                              profileController.bankAccountHolderNameController,
                          hintText: LocalizationKeys.enterAccountHolderName.tr,
                          readOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocalizationKeys
                                  .pleaseEnterAccountHolderName
                                  .tr;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),
                        // Bank Account Number
                        Text(
                          LocalizationKeys.accountNumber.tr,
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle16w500ClrSubText,
                        ),
                        SizedBox(height: 6.h),
                        CommonTextFormFieldWithoutBorder(
                          controller:
                              profileController.bankAccountNumberController,
                          keyboardType: TextInputType.number,
                          readOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocalizationKeys
                                  .pleaseEnterAccountNumber
                                  .tr;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),
                        // IFSC Code
                        Text(
                          LocalizationKeys.ifscCode.tr,
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle16w500ClrSubText,
                        ),
                        SizedBox(height: 6.h),
                        CommonTextFormFieldWithoutBorder(
                          controller: profileController.bankIFSCController,
                          maxLength: 11,
                          readOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocalizationKeys.pleaseEnterIfscCode.tr;
                            } else if (value.length != 11) {
                              return LocalizationKeys
                                  .ifscCodeMustBe11Characters
                                  .tr;
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 20.h),
                        // Text(
                        //   "Documents",
                        //   style:
                        //       TextStyleConstant()
                        //           .subTitleTextStyle20w500Clr242424,
                        // ),
                        // SizedBox(height: 16.h),
                        // Aadhar Card Images
                        // _buildImageField(
                        //   title: "Aadhar Card Front",
                        //   imageFile: profileController.aadharCardFront,
                        //   onTap:
                        //       () => _showImageSourceDialog(
                        //         profileController.aadharCardFront,
                        //       ),
                        // ),
                        // SizedBox(height: 16.h),
                        // _buildImageField(
                        //   title: "Aadhar Card Back",
                        //   imageFile: profileController.aadharCardBack,
                        //   onTap:
                        //       () => _showImageSourceDialog(
                        //         profileController.aadharCardBack,
                        //       ),
                        // ),
                        // SizedBox(height: 16.h),
                        // Driver License Images
                        // _buildImageField(
                        //   title: "Driver License Front",
                        //   imageFile: profileController.driverLicenseFront,
                        //   onTap:
                        //       () => _showImageSourceDialog(
                        //         profileController.driverLicenseFront,
                        //       ),
                        // ),
                        // SizedBox(height: 16.h),
                        // _buildImageField(
                        //   title: "Driver License Back",
                        //   imageFile: profileController.driverLicenseBack,
                        //   onTap:
                        //       () => _showImageSourceDialog(
                        //         profileController.driverLicenseBack,
                        //       ),
                        // ),
                      ],
                      // SizedBox(height: 30.h),
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
