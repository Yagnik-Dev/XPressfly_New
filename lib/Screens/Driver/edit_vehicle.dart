import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Common%20Components/common_textfield.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';

class EditVehicleDetailsScreen extends StatelessWidget {
  const EditVehicleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.clrF2FAFF,
      appBar: AppBar(
        leadingWidth: 70.w,
        centerTitle: true,
        backgroundColor: ColorConstant.clrF2FAFF,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Container(
              height: 50.w,
              width: 50.w,
              decoration: const BoxDecoration(
                color: Colors.white,
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
          "Edit Details",
          style: TextStyleConstant().titleTextStyle26w600Clr242424,
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 455.h,
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 60.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Vehicle Model",
                                style:
                                    TextStyleConstant()
                                        .subTitleTextStyle18w500Clr242424,
                              ),
                              SizedBox(height: 6.h),
                              CommonTextFormFieldWithoutBorder(),
                            ],
                          ),
                        ),
                        SizedBox(width: 7.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Vehicle Number",
                                style:
                                    TextStyleConstant()
                                        .subTitleTextStyle18w500Clr242424,
                              ),
                              SizedBox(height: 6.h),
                              CommonTextFormFieldWithoutBorder(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Where You Can Deliver",
                      style:
                          TextStyleConstant().subTitleTextStyle18w500Clr242424,
                    ),
                    SizedBox(height: 6.h),
                    CommonTextFormFieldWithoutBorder(),
                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
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
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          /// Truck image (floating above the container)
          Positioned(
            top: 50.h,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(ImageConstant.imgSmallTruckFull, height: 180),
            ),
          ),
        ],
      ),
    );
  }
}
