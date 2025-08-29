import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Common%20Components/common_button.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Routes/app_routes.dart';

class SelectAuthScreen extends StatelessWidget {
  const SelectAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: ColorConstant.clrPrimary,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 120.h),
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      ImageConstant.gifSplashLogoBG,
                      height: 140.h,
                      // width: 245.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 54.h),
                      child: Image.asset(
                        ImageConstant.gifSplashScreen,
                        height: 75.h,
                        // color: Colors.transparent,
                        // width: 245.w,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Image.asset(
                  'assets/images/app_logo.png',
                  height: 24.h,
                  // width: 245.w,
                ),
              ],
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 22.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Let’s get started',
                    style: TextStyleConstant().subTitleTextStyle18w600,
                  ),
                  SizedBox(height: 20.h),
                  CommonButton(
                    btnText: 'LOGIN',
                    onPressed: () {
                      Get.toNamed(AppRoutes.loginScreen);
                    },
                    color: ColorConstant.clrSecondary,
                  ),
                  SizedBox(height: 10.h),
                  CommonButton(
                    btnText: 'SIGN UP',
                    onPressed: () {},
                    color: ColorConstant.clrPrimary,
                  ),
                ],
              ),
              // height: 350.h,
            ),
          ],
        ),
      ),
    );
  }
}
