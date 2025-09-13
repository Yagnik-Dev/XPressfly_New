import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xpressfly_git/Common%20Components/common_textfield.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';

class AddVehicleOne extends StatelessWidget {
  const AddVehicleOne({super.key});

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
                      child: Image.asset(ImageConstant.imgAddVehicleOne),
                    ),
                    Text(
                      "Your Details",
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
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Full Name",
                                style:
                                    TextStyleConstant()
                                        .subTitleTextStyle16w500Clr242424,
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
                                "Number",
                                style:
                                    TextStyleConstant()
                                        .subTitleTextStyle16w500Clr242424,
                              ),
                              SizedBox(height: 6.h),
                              CommonTextFormFieldWithoutBorder(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "License Number & Upload Image",
                      style:
                          TextStyleConstant().subTitleTextStyle16w500Clr242424,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Expanded(child: CommonTextFormFieldWithoutBorder()),
                        SizedBox(width: 7.w),
                        SizedBox(
                          width: 120.w,
                          child: CommonTextFormFieldWithoutBorder(
                            prefixIcon: Icon(Icons.upload, size: 24.sp),
                            hintText: "Select Image",
                            maxLines: 1,
                          ),
                        ),
                        // Container(
                        //   height: 48.h,
                        //   width: 120.w,
                        //   padding: EdgeInsets.symmetric(horizontal: 8.w),
                        //   decoration: BoxDecoration(
                        //     color: ColorConstant.clrBackGround,
                        //     borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        //     border: Border.all(
                        //       color: ColorConstant.clrEEEEEE,
                        //       width: 1,
                        //     ),
                        //   ),
                        //   child: Row(
                        //     children: [
                        //       Icon(
                        //         Icons.upload,
                        //         color: ColorConstant.clrSubText,
                        //         size: 24.sp,
                        //       ),
                        //       SizedBox(width: 6.w),
                        //       Text(
                        //         "Select Image",
                        //         overflow: TextOverflow.ellipsis,
                        //         maxLines: 1,
                        //         style:
                        //             TextStyleConstant()
                        //                 .subTitleTextStyle16w500ClrSubText,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Address",
                      style:
                          TextStyleConstant().subTitleTextStyle16w500Clr242424,
                    ),
                    SizedBox(height: 6.h),
                    CommonTextFormFieldWithoutBorder(maxLines: 2),
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
