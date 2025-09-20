import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';

class VehicleDetailsScreen extends StatelessWidget {
  const VehicleDetailsScreen({super.key});

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
          "Vehicle Details",
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Mahindra Jeeto",
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle22w600Clr242424,
                        ),
                        Text(
                          "GJ05AE8080",
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle16w500Clr242424,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "The perfect mini truck with ample space to carry TVs, tables, chairs and all your household essentials with ease.",
                      style:
                          TextStyleConstant().subTitleTextStyle14w400ClrSubText,
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Overview",
                        style:
                            TextStyleConstant().titleTextStyle20w600Clr242424,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildOverviewCard(
                          ImageConstant.imgDistance,
                          "Distance",
                          "6,570",
                          " km",
                        ),
                        _buildOverviewCard(
                          ImageConstant.imgTrips,
                          "Trips",
                          "50",
                          "",
                        ),
                        _buildOverviewCard(
                          ImageConstant.imgCapacity,
                          "Capacity",
                          "705",
                          " kg",
                        ),
                      ],
                    ),
                    // const SizedBox(height: 30),
                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              backgroundColor: ColorConstant.clrF2FAFF,
                              side: const BorderSide(color: Colors.transparent),
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                            ),
                            icon: Image.asset(
                              ImageConstant.imgDeleteBtn,
                              color: Colors.redAccent,
                              width: 24.w,
                              height: 24.h,
                            ),
                            label: Text(
                              "Delete",
                              style:
                                  TextStyleConstant()
                                      .subTitleTextStyle18w600Clr242424,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              backgroundColor: ColorConstant.clrSecondary,
                              side: const BorderSide(color: Colors.transparent),
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                            ),
                            icon: Image.asset(
                              ImageConstant.imgEditBtn,
                              color: ColorConstant.clrFFFAFA,
                              width: 24.w,
                              height: 24.h,
                            ),
                            label: Text(
                              "Edit",
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

  // Reusable Card Widgets
  static Widget _buildOverviewCard(
    String imageIcon,
    String title,
    String value1,
    String value2,
  ) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(15.sp),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: const Color(0xffF6FAFF),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imageIcon,
              color: Colors.black54,
              width: 24,
              height: 24,
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: TextStyleConstant().subTitleTextStyle12w500Clr242424,
            ),
            const SizedBox(height: 4),
            // Text(
            //   value,
            //   style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            // ),
            Text.rich(
              TextSpan(
                text: value1,
                style: TextStyleConstant().subTitleTextStyle18w600Clr242424,
                children: [
                  TextSpan(
                    text: value2,
                    style: TextStyleConstant().subTitleTextStyle12w500Clr242424,
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
