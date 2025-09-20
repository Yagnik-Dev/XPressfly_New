import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Common%20Components/common_drawer.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Routes/app_routes.dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawer: const CommonDrawer(),
      backgroundColor: ColorConstant.clrBackGroundLight,
      body: Column(
        children: [
          SizedBox(height: 30.h),
          Row(
            children: [
              Container(
                height: 46.h,
                width: 46.w,
                margin: EdgeInsets.only(right: 10.w, left: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(ImageConstant.imgUser),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello Jagnish",
                      style:
                          TextStyleConstant().subTitleTextStyle18w600Clr242424,
                    ),
                    Text(
                      "Surat, GJ",
                      style:
                          TextStyleConstant().subTitleTextStyle16w500ClrSubText,
                    ),
                  ],
                ),
              ),
              Builder(
                builder:
                    (context) => InkWell(
                      onTap: () {
                        Scaffold.of(
                          context,
                        ).openEndDrawer(); // ✅ open CommonDrawer
                      },
                      child: Container(
                        height: 46.h,
                        width: 46.w,
                        margin: EdgeInsets.only(right: 16.w),
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(ImageConstant.imgInformation),
                      ),
                    ),
              ),
              SizedBox(height: 4.w),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(34.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today Earning',
                  style: TextStyleConstant().subTitleTextStyle16w500Clr242424,
                ),
                // SizedBox(height: 2.h),
                Text(
                  '₹ 3,265.00',
                  style:
                      TextStyleConstant().subTitleTextStyle40w600clrSecondary,
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Trips',
                            style:
                                TextStyleConstant()
                                    .subTitleTextStyle14w500ClrSubText,
                          ),
                          SizedBox(height: 4),
                          Text(
                            '15',
                            style:
                                TextStyleConstant()
                                    .subTitleTextStyle14w600clr242424,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Distance',
                            style:
                                TextStyleConstant()
                                    .subTitleTextStyle14w500ClrSubText,
                          ),
                          SizedBox(height: 4),
                          Text(
                            '60km',
                            style:
                                TextStyleConstant()
                                    .subTitleTextStyle14w600clr242424,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFFE74C3C),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
              decoration: BoxDecoration(
                color: Colors.white,
                // here set radius only top left-right
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Vehicle List',
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle20w500Clr242424,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.addVehicleMainScreen);
                        },
                        child: Text(
                          'Add Vehicle',
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle14w500ClrSubText,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Vehicle',
                      hintStyle:
                          TextStyleConstant().subTitleTextStyle14w500ClrCCCCCC,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.search,
                          color: ColorConstant.clrC8C8C8,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide(color: ColorConstant.clrEEEEEE),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide(color: ColorConstant.clrEEEEEE),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide(color: ColorConstant.clrEEEEEE),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 14.h,
                        horizontal: 19.w,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        vehicleList.length,
                        (index) => Container(
                          height: 165.h,
                          margin: EdgeInsets.only(top: 16.h, right: 12.w),
                          decoration: BoxDecoration(
                            color: vehicleList[index].bgColor,
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                      18.w,
                                      18.h,
                                      0,
                                      0,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              vehicleList[index].vehicleName,
                                              style:
                                                  TextStyleConstant()
                                                      .subTitleTextStyle16w500Clr242424,
                                            ),
                                            Text(
                                              vehicleList[index].vehicleNumber,
                                              style:
                                                  TextStyleConstant()
                                                      .subTitleTextStyle14w500ClrCCCCCC,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 45.h),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                              AppRoutes.vehicleDetailsScreen,
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(14.sp),
                                            decoration: BoxDecoration(
                                              color: ColorConstant.clrFFFAFA,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.arrow_forward,
                                              color: ColorConstant.clrSecondary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Image.asset(
                                    vehicleList[index].imagePath,
                                    height: 160.h,
                                    width: 160.w,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VehicleList {
  String vehicleName;
  String vehicleNumber;
  String imagePath;
  Color bgColor;

  VehicleList({
    required this.vehicleName,
    required this.vehicleNumber,
    required this.imagePath,
    required this.bgColor,
  });
}

List<VehicleList> vehicleList = [
  VehicleList(
    vehicleName: 'Mahindra Jeeto',
    vehicleNumber: 'GJ05AE8080',
    imagePath: ImageConstant.imgSmallTruck,
    bgColor: Color(0xffFEE3BA),
  ),
  VehicleList(
    vehicleName: 'Suzuki Dzire LXi',
    vehicleNumber: 'GJ05AE8080',
    imagePath: ImageConstant.imgMotorCar,
    bgColor: Color(0xffD5E8FF),
  ),
  VehicleList(
    vehicleName: 'Mahindra Jeeto',
    vehicleNumber: 'GJ05AE8080',
    imagePath: ImageConstant.imgSmallTruck,
    bgColor: Color(0xffFEE3BA),
  ),
];
