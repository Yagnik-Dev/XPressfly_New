import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Common%20Components/common_button.dart';
import 'package:xpressfly_git/Common%20Components/common_textfield.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Screens/AuthScreens/verification_screen.dart';

class YourDetailsScreen extends StatelessWidget {
  final int type;
  final String? mobileNo;
  final String? otp;

  YourDetailsScreen({super.key, required this.type, this.mobileNo, this.otp});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
          "Your Details",
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
        Padding(
          padding: EdgeInsets.only(bottom: 4.h, top: 4.h),
          child: CommonButtonRounded(
            color: ColorConstant.clrSecondary,
            btnText: "Next",
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Get.to(
                  VerificationScreen(
                    type: type,
                    mobileNo: mobileNo,
                    otp: otp,
                    name: nameController.text.trim(),
                    city: cityController.text.trim(),
                    pincode: pincodeController.text.trim(),
                  ),
                );
              }
            },
          ),
        ),
      ],
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
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 70.h),
                            Text(
                              "Your name",
                              style:
                                  TextStyleConstant()
                                      .subTitleTextStyle16w500ClrSubText,
                            ),
                            SizedBox(height: 6.h),
                            CommonTextFormFieldWithoutBorder(
                              controller: nameController,
                              validator:
                                  (p0) =>
                                      p0 == null || p0.isEmpty
                                          ? "Please enter your name"
                                          : null,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              "Your city",
                              style:
                                  TextStyleConstant()
                                      .subTitleTextStyle16w500ClrSubText,
                            ),
                            SizedBox(height: 6.h),
                            CommonTextFormFieldWithoutBorder(
                              controller: cityController,
                              validator:
                                  (p0) =>
                                      p0 == null || p0.isEmpty
                                          ? "Please enter your city"
                                          : null,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              "Your pincode",
                              style:
                                  TextStyleConstant()
                                      .subTitleTextStyle16w500ClrSubText,
                            ),
                            SizedBox(height: 6.h),
                            CommonTextFormFieldWithoutBorder(
                              controller: pincodeController,
                              maxLength: 6,
                              keyboardType: TextInputType.number,
                              validator:
                                  (p0) =>
                                      p0 != null && p0.length < 6
                                          ? "Please enter valid pincode"
                                          : null,
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),

                    // Padding(
                    //   padding: EdgeInsets.only(bottom: 20.h, top: 10.h),
                    //   child: CommonButtonRounded(
                    //     color: ColorConstant.clrSecondary,
                    //     btnText: "Next",
                    //     onPressed: () {
                    //       if (formKey.currentState!.validate()) {
                    //         Get.to(VerificationScreen(
                    //           type: type,
                    //           mobileNo: mobileNo,
                    //           otp: otp,
                    //           name: nameController.text.trim(),
                    //           city: cityController.text.trim(),
                    //           pincode: pincodeController.text.trim(),
                    //         ));
                    //       }
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 20.h,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                ImageConstant.imgYourDetails,
                height: 180.h,
                width: 160.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
