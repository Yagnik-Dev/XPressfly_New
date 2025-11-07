import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Common%20Components/common_textfield.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
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
            "Edit Profile",
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
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: ColorConstant.clrSecondary),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(
                        "Back",
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle18w600Clr242424,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        if (profileController.formKeyProfile.currentState!
                            .validate()) {
                          profileController.updateUserProfile((success) {
                            if (success) {
                              Get.back();
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
                        "Save",
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
        body: Column(
          children: [
            SizedBox(height: 20.h),
            Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50.r,
                      backgroundImage: NetworkImage(
                        "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                      ),
                    ),
                    Container(
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
                  ],
                ),
                SizedBox(height: 10.h),
                // Name Field - Editable like in the screenshot
                // SizedBox(
                //   width: 200.w,
                //   child: CommonTextFormFieldWithoutBorder(
                //     controller: profileController.nameTextEditingController,
                //     hintText: "Enter your name",
                //     // textAlign: TextAlign.center,
                //     // contentPadding: EdgeInsets.symmetric(
                //     //   vertical: 8.h,
                //     //   horizontal: 16.w,
                //     // ),
                //     // style: TextStyleConstant().subTitleTextStyle22w600Clr242424
                //     //     .copyWith(fontSize: 22.sp),
                //     suffixIcon: Padding(
                //       padding: EdgeInsets.only(right: 8.w),
                //       child: Icon(
                //         Icons.edit,
                //         size: 18.h,
                //         color: ColorConstant.clrSubText,
                //       ),
                //     ),
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please enter your name';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                SizedBox(
                  width: 200.w,
                  child: Obx(
                    () =>
                        profileController.isEditingName.value
                            ? CommonTextFormFieldWithoutBorder(
                              controller:
                                  profileController.nameTextEditingController,
                              hintText: "Enter your name",
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
                                  return 'Please enter your name';
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
            // Details Card
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: ColorConstant.clrWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: profileController.formKeyProfile,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Your Details",
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle20w500Clr242424,
                        ),
                        SizedBox(height: 20.h),

                        // Phone Field
                        Text(
                          "Number",
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle16w500ClrSubText,
                        ),
                        SizedBox(height: 6.h),
                        CommonTextFormFieldWithoutBorder(
                          hintText: "+91 98765 43210",
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          controller:
                              profileController.mobileTextEditingController,
                          suffixIcon: Icon(
                            Icons.edit,
                            color: ColorConstant.clrPrimary,
                            size: 18.h,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter mobile number';
                            } else if (value.length < 10) {
                              return 'Mobile number must be 10 digits';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),

                        // Email Field
                        Text(
                          "Pincode",
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle16w500Clr242424,
                        ),
                        SizedBox(height: 6.h),
                        CommonTextFormFieldWithoutBorder(
                          controller:
                              profileController.pincodeTextEditingController,
                          keyboardType: TextInputType.number,
                          // hintText: "Enter your pincode",
                          maxLength: 6,
                          suffixIcon: Icon(
                            Icons.edit,
                            color: ColorConstant.clrPrimary,
                            size: 18.h,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your pincode';
                            } else if (value.length != 6) {
                              return 'Pincode must be 6 digits';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),
                        // Address Field
                        Text(
                          "Address",
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle16w500ClrSubText,
                        ),
                        SizedBox(height: 6.h),
                        CommonTextFormFieldWithoutBorder(
                          hintText: "90, Houses, Surat, Gujarat - 395010",
                          controller:
                              profileController.cityTextEditingController,
                          maxLines: 2,
                          suffixIcon: Icon(
                            Icons.edit,
                            color: ColorConstant.clrPrimary,
                            size: 18.h,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter city';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
