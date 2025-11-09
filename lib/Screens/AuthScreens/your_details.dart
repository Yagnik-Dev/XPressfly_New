import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Common%20Components/common_button.dart';
import 'package:xpressfly_git/Common%20Components/common_textfield.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/login_controller.dart';

class YourDetailsScreen extends StatelessWidget {
  final int type;
  final String? mobileNo;
  final String? otp;

  YourDetailsScreen({super.key, required this.type, this.mobileNo, this.otp});

  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.clrF7FCFF,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: ColorConstant.clrF7FCFF,
        leadingWidth: 70.w,
        centerTitle: true,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Container(
              height: 50.w,
              width: 50.w,
              decoration: BoxDecoration(
                color: ColorConstant.clrWhite,
                // border: Border.all(color: ColorConstant.clrFFE2DF, width: 1.w),
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
        title: Text(
          "Your Details",
          style: TextStyleConstant().titleTextStyle26w600Clr242424,
        ),
      ),
      body: Form(
        key: loginController.formKeyYourDetails,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 4.h),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 2.h,
                      color: ColorConstant.clrEEEEEE,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 2.h,
                      color: ColorConstant.clrSecondary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              "Enter your details",
              textAlign: TextAlign.center,
              style: TextStyleConstant().subTitleTextStyle16w500ClrSubText,
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your name",
                      style: TextStyleConstant().subTitleTextStyle16w500,
                    ),
                    SizedBox(height: 8.h),
                    CommonTextFormField(
                      controller: loginController.nameTextEditingController,
                      // hintText: "Enter your name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Your city",
                      style: TextStyleConstant().subTitleTextStyle16w500,
                    ),
                    SizedBox(height: 8.h),
                    CommonTextFormField(
                      controller: loginController.cityTextEditingController,
                      // hintText: "Enter your city",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your city';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Your pincode",
                      style: TextStyleConstant().subTitleTextStyle16w500,
                    ),
                    SizedBox(height: 8.h),
                    CommonTextFormField(
                      controller: loginController.pincodeTextEditingController,
                      keyboardType: TextInputType.number,
                      // hintText: "Enter your pincode",
                      maxLength: 6,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your pincode';
                        } else if (value.length != 6) {
                          return 'Pincode must be 6 digits';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
              child: CommonButton(
                btnText: 'DONE',
                onPressed: () {
                  if (loginController.formKeyYourDetails.currentState
                          ?.validate() ??
                      false) {
                    loginController.registerApiCall(
                      (p0) {},
                      details: {
                        "name": loginController.nameTextEditingController.text,
                        "city": loginController.cityTextEditingController.text,
                        "pincode":
                            loginController.pincodeTextEditingController.text,
                        "mobile_number": mobileNo,
                        "otp": otp,
                        "user_type": type,
                      },
                    );

                    // type == 1
                    //     ? Get.toNamed(AppRoutes.driverBottomBarScreen)
                    //     : Get.toNamed(AppRoutes.customerBottomBarScreen);
                  }
                  // Get.toNamed(AppRoutes.driverBottomBarScreen);
                },
                color: ColorConstant.clrSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
