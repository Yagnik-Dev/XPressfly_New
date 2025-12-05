import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xpressfly_git/Common%20Components/common_textfield.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Screens/Driver/order_history_screen.dart';

class BookAOrderOne extends StatefulWidget {
  const BookAOrderOne({super.key});

  @override
  State<BookAOrderOne> createState() => _BookAOrderOneState();
}

class _BookAOrderOneState extends State<BookAOrderOne> {
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
                padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 18.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: ColorConstant.clrF7FCFF,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ColorConstant.clrEEEEEE,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.arrow_circle_down,
                                color: ColorConstant.clrSecondary,
                                size: 20.w,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            DashedLineVertical(
                              height: 30.h,
                              dashHeight: 3.h,
                              dashGap: 4.h,
                              color: ColorConstant.clrSubText,
                              strokeWidth: 1.w,
                            ),
                            SizedBox(height: 6.h),
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: ColorConstant.clrF7FCFF,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ColorConstant.clrEEEEEE,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.location_on,
                                color: ColorConstant.clrSecondary,
                                size: 20.w,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Column(
                            children: [
                              CommonTextFormFieldWithoutBorder(
                                hintText: "Enter Pickup Location with Pin-code",
                                fillColor: ColorConstant.clrF7FCFF,
                                maxLines: 1,
                              ),
                              SizedBox(height: 12.h),
                              CommonTextFormFieldWithoutBorder(
                                maxLines: 1,
                                hintText: "Enter Drop Location with Pin-code",
                                fillColor: ColorConstant.clrF7FCFF,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Box Image above the container
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  // The container with order details
                  Container(
                    margin: EdgeInsets.only(
                      top: 65.h,
                    ), // Push container down so image overlaps
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 74.h, 20.w, 30.h),
                      child: Column(
                        children: [
                          Text(
                            "Order Details",
                            style:
                                TextStyleConstant()
                                    .subTitleTextStyle22w600Clr242424,
                          ),
                          SizedBox(height: 20.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Receiver Name & Mobile no.",
                              style:
                                  TextStyleConstant()
                                      .subTitleTextStyle16w500Clr242424,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Expanded(
                                child: CommonTextFormFieldWithoutBorder(
                                  hintText: "ex. Rohit Shah",
                                  fillColor: ColorConstant.clrF7FCFF,
                                ),
                              ),
                              SizedBox(width: 9.w),
                              Expanded(
                                child: CommonTextFormFieldWithoutBorder(
                                  hintText: "ex. 98765 43210",
                                  maxLines: 1,
                                  fillColor: ColorConstant.clrF7FCFF,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Sender Name & Mobile no.",
                              style:
                                  TextStyleConstant()
                                      .subTitleTextStyle16w500Clr242424,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Expanded(
                                child: CommonTextFormFieldWithoutBorder(
                                  hintText: "ex. Mohit Shah",
                                  fillColor: ColorConstant.clrF7FCFF,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: CommonTextFormFieldWithoutBorder(
                                  hintText: "ex. 98765 43210",
                                  fillColor: ColorConstant.clrF7FCFF,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Approx Weight of Your Items",
                              style:
                                  TextStyleConstant()
                                      .subTitleTextStyle16w500Clr242424,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          CommonTextFormFieldWithoutBorder(
                            hintText: "ex. 15-20 kg Simple table",
                            fillColor: ColorConstant.clrF7FCFF,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // The box image, positioned above the container
                  Positioned(
                    child: Image.asset(ImageConstant.imgBox, height: 130.h),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
