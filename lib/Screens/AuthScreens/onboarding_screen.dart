import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Localization/localization_keys.dart';
import 'package:xpressfly_git/Routes/app_routes.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.clrBackGround,
      floatingActionButton: InkWell(
        onTap: () {
          Get.offAndToNamed(AppRoutes.selectAuthScreen);
        },
        child: Container(
          padding: EdgeInsets.all(18.sp),
          decoration: BoxDecoration(
            color: ColorConstant.clrSecondary,
            borderRadius: BorderRadius.circular(20.sp),
          ),
          child: Icon(Icons.arrow_forward, color: Colors.white, size: 26.sp),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(ImageConstant.imgOnBoarding),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                Text(
                  LocalizationKeys.fastReliableDeliveredYourWay.tr,
                  style: TextStyleConstant().titleTextStyle34w600,
                ),
                SizedBox(height: 10.h),
                Text(
                  LocalizationKeys.trackScheduleAndDeliverWithEase.tr,
                  style: TextStyleConstant().subTitleTextStyle18w400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
