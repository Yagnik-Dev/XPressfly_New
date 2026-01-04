import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Screens/Driver/swipe_to_accept_button.dart';

class OrderRequestScreen extends StatelessWidget {
  const OrderRequestScreen({super.key});

  final bool isOrderAvailable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.clrF2FAFF,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(46.h),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.r),
            bottomRight: Radius.circular(30.r),
          ),
          child: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text(
              "Order Request",
              style: TextStyleConstant().titleTextStyle26w600Clr242424,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child:
            isOrderAvailable
                ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.imgNoOrder,
                        height: 150.h,
                        width: 200.w,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Oops!",
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle26w600Clr242424,
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        "No more order right now",
                        textAlign: TextAlign.center,
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle12w400Clr9D9D9D,
                      ),
                    ],
                  ),
                )
                : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(12.w, 20.h, 20.w, 10.h),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Today",
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle18w500Clr242424,
                        ),
                      ),
                    ),
                    // Card Container for Order Details
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: 7.w),
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // User Info Row
                          Container(
                            padding: EdgeInsets.all(12.sp),
                            decoration: BoxDecoration(
                              color: ColorConstant.clrFAFBFF,
                              border: Border.all(
                                color: ColorConstant.clrEEEEEE,
                              ),
                              borderRadius: BorderRadius.circular(12.sp),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        "https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80",
                                        width: 55,
                                        height: 55,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Javed Alam",
                                            style:
                                                TextStyleConstant()
                                                    .subTitleTextStyle18w600Clr242424,
                                          ),
                                          Text(
                                            "+91 98765-54321",
                                            style:
                                                TextStyleConstant()
                                                    .subTitleTextStyle14w400clr666666,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Distance Container
                                    Container(
                                      decoration: BoxDecoration(
                                        color: ColorConstant.clrSecondary,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 11.w,
                                        vertical: 6.h,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "53.4",
                                            style:
                                                TextStyleConstant()
                                                    .subTitleTextStyle14w700clrWhite,
                                          ),
                                          Text(
                                            "KM",
                                            style:
                                                TextStyleConstant()
                                                    .subTitleTextStyle14w700clrWhite,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: ColorConstant.clrWhite,
                                            border: Border.all(
                                              color: ColorConstant.clrSecondary,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.location_on,
                                            color: ColorConstant.clrSecondary,
                                            size: 20,
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        Text(
                                          "Pick\nPoint",
                                          style:
                                              TextStyleConstant()
                                                  .subTitleTextStyle10w400ClrSubText,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 11.w),
                                    Expanded(
                                      child: Text(
                                        "Near 9 Square Building, Honey Park, Honey Park Area, Adajan, Surat, Gujarat 395009",
                                        style:
                                            TextStyleConstant()
                                                .subTitleTextStyle14w400Clr242424,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: ColorConstant.clrBorder,
                                  thickness: 1,
                                  endIndent: 10,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 18.w),
                                child: Text(
                                  "DELIVERY DETAILS",
                                  style:
                                      TextStyleConstant()
                                          .subTitleTextStyle12w400Clr9D9D9D,
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: ColorConstant.clrBorder,
                                  thickness: 1,
                                  indent: 10,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 8),

                          // Delivery order number and date row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "#872-AT9",
                                style:
                                    TextStyleConstant()
                                        .subTitleTextStyle18w500Clr242424,
                              ),
                              Text(
                                "Wed, 10 Sep 2025",
                                style:
                                    TextStyleConstant()
                                        .subTitleTextStyle12w400clr666666,
                              ),
                            ],
                          ),

                          SizedBox(height: 12),

                          // Drop Point Row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Location Icon with circle border
                              SizedBox(width: 6),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: ColorConstant.clrSecondary,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.location_on,
                                      color: ColorConstant.clrSecondary,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    "Drop\nPoint",
                                    style:
                                        TextStyleConstant()
                                            .subTitleTextStyle10w400ClrSubText,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              SizedBox(width: 11.w),
                              Expanded(
                                child: Text(
                                  "Upam Square Building, Shreeji Society, Navrangpur, Ahmedabad, Gujarat 380009",
                                  style:
                                      TextStyleConstant()
                                          .subTitleTextStyle14w400Clr242424,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Expanded(
                              //   child: Container(
                              //     margin: EdgeInsets.only(right: 12.w),
                              //     decoration: BoxDecoration(
                              //       color: ColorConstant.clrF7FCFF,
                              //       borderRadius: BorderRadius.circular(50),
                              //     ),
                              //     child: Row(
                              //       mainAxisSize: MainAxisSize.min,
                              //       children: [
                              //         Container(
                              //           decoration: BoxDecoration(
                              //             shape: BoxShape.circle,
                              //             color: ColorConstant.clrSecondary,
                              //           ),
                              //           alignment: Alignment.centerLeft,
                              //           padding: EdgeInsets.fromLTRB(
                              //             6.w,
                              //             2.h,
                              //             2.w,
                              //             2.h,
                              //           ),
                              //           child: Container(
                              //             padding: EdgeInsets.all(11.sp),
                              //             decoration: BoxDecoration(
                              //               shape: BoxShape.circle,
                              //               color: Colors.white,
                              //             ),
                              //             child: Image.asset(
                              //               ImageConstant.imgSwipeToAccept,
                              //               height: 16.h,
                              //               width: 16.w,
                              //             ),
                              //           ),
                              //         ),
                              //         SizedBox(width: 8),
                              //         Text(
                              //           "Swipe to Accept",
                              //           style:
                              //               TextStyleConstant()
                              //                   .subTitleTextStyle14w600Clr008000,
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              Expanded(
                                child: SwipeToAcceptButton(
                                  onAccept: () async {
                                    log("Order Accepted");
                                  },
                                ),
                              ),
                              SizedBox(width: 20.h),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 12.h,
                                ),
                                decoration: BoxDecoration(
                                  color: ColorConstant.clrF7FCFF,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(
                                  "Reject",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
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
    );
  }
}
