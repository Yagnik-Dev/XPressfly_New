import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Localization/localization_keys.dart';
import 'package:xpressfly_git/Screens/AuthScreens/your_details.dart';

class JoinAsScreen extends StatelessWidget {
  final String? mobileNo, otp;
  const JoinAsScreen({super.key, this.mobileNo, this.otp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstant.clrF7FCFF,
      appBar: AppBar(
        leadingWidth: 70.w,
        centerTitle: true,
        backgroundColor: ColorConstant.clrF7FCFF,
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
          LocalizationKeys.joinAs.tr,
          style: TextStyleConstant().titleTextStyle26w600Clr242424,
        ),
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 4.h),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: Container(
          //           height: 2.h,
          //           color: ColorConstant.clrSecondary,
          //         ),
          //       ),
          //       Expanded(
          //         child: Container(height: 2.h, color: ColorConstant.clrEEEEEE),
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(height: 12.h),
          Text(
            LocalizationKeys.selectYourTypeOfAccount.tr,
            style: TextStyleConstant().subTitleTextStyle16w500ClrSubText,
          ),
          SizedBox(height: 18.h),
          Container(
            height: 170.h,
            margin: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              color: ColorConstant.clrBorder,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Stack(
              children: [
                // background image
                ClipRRect(
                  borderRadius: BorderRadius.circular(24.r),
                  child: Image.asset(
                    ImageConstant.imgAsDriver,
                    fit: BoxFit.fill,
                    height: 170.h,
                    width: double.infinity,
                  ),
                ),

                // bottom black gradient overlay
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 120.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24.r),
                        bottomRight: Radius.circular(24.r),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.8),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 20.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              LocalizationKeys.asDriver.tr,
                              style:
                                  TextStyleConstant()
                                      .titleTextStyle20w600ClrWhite,
                            ),
                            Text(
                              LocalizationKeys.asDriverDescription.tr,
                              style:
                                  TextStyleConstant()
                                      .subTitleTextStyle16w500ClrD9C0C0,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => YourDetailsScreen(
                              mobileNo: mobileNo,
                              otp: otp,
                              type: 1,
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(14.sp),
                          decoration: BoxDecoration(
                            color: ColorConstant.clrBackGround,
                            borderRadius: BorderRadius.circular(20.sp),
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: ColorConstant.clrSecondary,
                            size: 26.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 9.h),
          Container(
            height: 170.h,
            margin: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              color: ColorConstant.clrBorder,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Stack(
              children: [
                // background image
                ClipRRect(
                  borderRadius: BorderRadius.circular(24.r),
                  child: Image.asset(
                    ImageConstant.imgAsCustomer,
                    fit: BoxFit.fill,
                    height: 170.h,
                    width: double.infinity,
                  ),
                ),

                // bottom black gradient overlay
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 120.h, // adjust how much fade you want
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24.r),
                        bottomRight: Radius.circular(24.r),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.8), // fade to black
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.w, 12.h, 18.w, 20.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              LocalizationKeys.asCustomer.tr,
                              style:
                                  TextStyleConstant()
                                      .titleTextStyle20w600ClrWhite,
                            ),
                            Text(
                              LocalizationKeys.asCustomerDescription.tr,
                              style:
                                  TextStyleConstant()
                                      .subTitleTextStyle16w500ClrD9C0C0,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => YourDetailsScreen(
                              mobileNo: mobileNo,
                              otp: otp,
                              type: 0,
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(14.sp),
                          decoration: BoxDecoration(
                            color: ColorConstant.clrBackGround,
                            borderRadius: BorderRadius.circular(20.sp),
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: ColorConstant.clrSecondary,
                            size: 26.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
