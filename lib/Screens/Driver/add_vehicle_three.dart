import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xpressfly_git/Common%20Components/common_textfield.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';

class AddVehicleThree extends StatelessWidget {
  const AddVehicleThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.clrF2FAFF,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 18.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 22.w,
                      ),
                      child: Image.asset(ImageConstant.imgAddVehicleThree),
                    ),
                    Text(
                      "Verification",
                      style:
                          TextStyleConstant().subTitleTextStyle18w600Clr242424,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Upload Aadhar Front & Back",
                      style:
                          TextStyleConstant().subTitleTextStyle16w500Clr242424,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Expanded(
                          child: CommonTextFormFieldWithoutBorder(
                            hintText: "Front Image",
                            prefixIcon: Icon(Icons.upload, size: 24.sp),
                          ),
                        ),
                        SizedBox(width: 7.w),
                        Expanded(
                          child: CommonTextFormFieldWithoutBorder(
                            hintText: "Back Image",
                            prefixIcon: Icon(Icons.upload, size: 24.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Upload RC Book Front & Back",
                      style:
                          TextStyleConstant().subTitleTextStyle16w500Clr242424,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Expanded(
                          child: CommonTextFormFieldWithoutBorder(
                            hintText: "Front Image",
                            prefixIcon: Icon(Icons.upload, size: 24.sp),
                          ),
                        ),
                        SizedBox(width: 7.w),
                        Expanded(
                          child: CommonTextFormFieldWithoutBorder(
                            hintText: "Back Image",
                            prefixIcon: Icon(Icons.upload, size: 24.sp),
                          ),
                        ),
                      ],
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
}
