import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Common%20Components/common_button.dart';
import 'package:xpressfly_git/Common%20Components/common_textfield.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: 38.h,
            left: 15.w,
            child: Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                    color: ColorConstant.clrF1F1F1,
                    border: Border.all(
                      color: ColorConstant.clrFFE2DF,
                      width: 1.w,
                    ),
                    // borderRadius: BorderRadius.circular(12.r),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: ColorConstant.clrPrimary,
                    size: 24.sp,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              ImageConstant.imgLoginTop,
              height: 170.h,
              // width: 290.w,
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "Welcome to\nXPRESSFLY",
                      textAlign: TextAlign.center,
                      style: TextStyleConstant().titleTextStyle34w600Clr242424,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Number",
                    style: TextStyleConstant().subTitleTextStyle16w500,
                  ),
                  SizedBox(height: 8.h),
                  CommonTextFormField(),
                  SizedBox(height: 18.h),
                  CommonButton(
                    btnText: "GET OTP",
                    onPressed: () {
                      Get.toNamed(AppRoutes.otpScreen);
                    },
                    color: ColorConstant.clrSecondary,
                  ),
                  SizedBox(height: 18.h),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "New to Xpressfly? ",
                            style: TextStyleConstant().subTitleTextStyle16w500,
                          ),
                          TextSpan(
                            text: "Signup",
                            style:
                                TextStyleConstant()
                                    .subTitleTextStyle16w500Clr242424,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              ImageConstant.imgLoginBottom,
              height: 135.h,
              // width: 180.w,
            ),
          ),
        ],
      ),
    );
  }
}
