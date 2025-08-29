import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: ColorConstant.clrPrimary,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.gifSplashLogoBG,
                        height: 150.h,
                        // width: 245.w,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 54.h),
                        child: Image.asset(
                          ImageConstant.gifSplashScreen,
                          height: 85.h,
                          // color: Colors.transparent,
                          // width: 245.w,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Image.asset(
                    'assets/images/app_logo.png',
                    height: 27.h,
                    // width: 245.w,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
