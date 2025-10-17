import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xpressfly_git/Common%20Components/common_textfield.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';

class BookAOrderThree extends StatefulWidget {
  const BookAOrderThree({super.key});

  @override
  State<BookAOrderThree> createState() => _BookAOrderThreeState();
}

class _BookAOrderThreeState extends State<BookAOrderThree> {
  int selectedPayment = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.clrF2FAFF,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 18.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choose the pickup date & time",
                      style:
                          TextStyleConstant().subTitleTextStyle22w600Clr242424,
                    ),
                    SizedBox(height: 10.h),
                    CommonTextFormFieldWithoutBorder(
                      hintText: "Select date",
                      fillColor: ColorConstant.clrF7FCFF,
                      suffixIcon: Icon(
                        Icons.calendar_month,
                        color: ColorConstant.clrSecondary,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Time",
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle18w500Clr242424,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: CommonTextFormFieldWithoutBorder(
                            hintText: "09:00 AM to 02:00 PM",
                            maxLines: 1,
                            fillColor: ColorConstant.clrF7FCFF,
                          ),
                        ),
                        SizedBox(width: 9.w),
                        Expanded(
                          child: CommonTextFormFieldWithoutBorder(
                            hintText: "03:00 PM to 07:00 PM",
                            maxLines: 1,
                            fillColor: ColorConstant.clrF7FCFF,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  "Select Payment Type",
                  style: TextStyleConstant().subTitleTextStyle18w500Clr242424,
                ),
              ),
              SizedBox(height: 14.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedPayment = 0),
                        child: Container(
                          padding: EdgeInsets.all(14.h),
                          decoration: BoxDecoration(
                            color: ColorConstant.clrF7FCFF,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: ColorConstant.clrEEEEEE,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    selectedPayment == 0
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_off,
                                    color:
                                        selectedPayment == 0
                                            ? ColorConstant.clrSecondary
                                            : ColorConstant.clr242424,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "Pay With UPI",
                                    style:
                                        TextStyleConstant()
                                            .subTitleTextStyle14w500Clr242424,
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                "Fast & secure payment\nwith no extra charges.",
                                style:
                                    TextStyleConstant()
                                        .subTitleTextStyle12w400ClrSubText,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedPayment = 1),
                        child: Container(
                          padding: EdgeInsets.all(13.h),
                          decoration: BoxDecoration(
                            color: ColorConstant.clrF7FCFF,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: ColorConstant.clrEEEEEE,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    selectedPayment == 1
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_off,
                                    color:
                                        selectedPayment == 1
                                            ? ColorConstant.clrSecondary
                                            : ColorConstant.clr242424,
                                  ),
                                  SizedBox(width: 7.w),
                                  Text(
                                    "Cash On Delivery",
                                    maxLines: 2,
                                    style:
                                        TextStyleConstant()
                                            .subTitleTextStyle14w500Clr242424,
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                "Pay in cash at delivery.\n₹10 platform fee applies.",
                                style:
                                    TextStyleConstant()
                                        .subTitleTextStyle12w400ClrSubText,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> listImages = [
  ImageConstant.imgParcelOne,
  ImageConstant.imgParcelTwo,
  ImageConstant.imgParcelThree,
  ImageConstant.imgParcelFour,
  ImageConstant.imgParcelFive,
  ImageConstant.imgParcelFive,
];
