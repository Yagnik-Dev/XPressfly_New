import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Common%20Components/common_drawer.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/driver_home_controller.dart';
import 'package:xpressfly_git/Controller/profile_controller.dart';
import 'package:xpressfly_git/Models/get_user_wise_vehicle_model.dart';
import 'package:xpressfly_git/Routes/app_routes.dart';

class DriverHomeScreen extends StatelessWidget {
  DriverHomeScreen({super.key});

  final DriverHomeController driverHomeController = Get.put(
    DriverHomeController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawer: const CommonDrawer(),
      backgroundColor: ColorConstant.clrBackGroundLight,
      body: Column(
        children: [
          SizedBox(height: 30.h),
          _buildAppBar(),
          _buildEarningsCard(),
          SizedBox(height: 4.h),
          Obx(
            () => Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top:
                          Get.find<ProfileController>()
                                      .userDetails
                                      .value
                                      .user
                                      ?.isVerified ==
                                  false
                              ? 30.h
                              : 0,
                    ), // Space for verification container
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 18.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Visibility(
                          visible:
                              Get.find<ProfileController>()
                                  .userDetails
                                  .value
                                  .user
                                  ?.isVerified ==
                              false,
                          child: SizedBox(height: 20.h),
                        ),
                        _buildVehicleHeader(),
                        SizedBox(height: 10.h),
                        _buildSearchField(),
                        SizedBox(height: 16.h),
                        _buildVehicleList(),
                      ],
                    ),
                  ),
                  Visibility(
                    visible:
                        Get.find<ProfileController>()
                            .userDetails
                            .value
                            .user
                            ?.isVerified ==
                        false,
                    child: Positioned(
                      top: 0,
                      left: 0.w,
                      right: 0.w,
                      child: _buildVerificationContainer(),
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

  // Add this new method for the verification container
  Widget _buildVerificationContainer() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorConstant.clr3B3B3B,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            ImageConstant.imgVerificationRequired,
            height: 40.h,
            width: 40.w,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verification Required',
                  style: TextStyleConstant().subTitleTextStyle16w600clrWhite,
                ),
                SizedBox(height: 4.h),
                Text(
                  'Verify Your Account With Your Details',
                  style: TextStyleConstant().subTitleTextStyle10w400clrD5D5D5,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: ColorConstant.clr292929,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_outward_rounded,
              color: ColorConstant.clrWhite,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
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
          child: InkWell(
            onTap: () {
              log(
                "refresh token ${GetStorage().read(refreshTokenVal).toString()}",
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello ${GetStorage().read(userName) ?? 'Driver'}",
                  style: TextStyleConstant().subTitleTextStyle18w600Clr242424,
                ),
                Text(
                  GetStorage().read(userAddress) ?? 'address',
                  style: TextStyleConstant().subTitleTextStyle16w500ClrSubText,
                ),
              ],
            ),
          ),
        ),
        Builder(
          builder:
              (context) => InkWell(
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
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
    );
  }

  Widget _buildEarningsCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(19.w, 0, 0, 19.h),
      // padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(34.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Text(
                'Today Earning',
                style: TextStyleConstant().subTitleTextStyle16w500Clr242424,
              ),
              Text(
                '₹ 3,265.00',
                style: TextStyleConstant().subTitleTextStyle40w600clrSecondary,
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
                  Obx(
                    () => Transform.scale(
                      scale: 0.9,
                      child: Switch(
                        value: driverHomeController.isSwitched.value,
                        activeColor: ColorConstant.clrSecondary,
                        activeTrackColor: ColorConstant.clrSecondary.withValues(
                          alpha: 0.3,
                        ),
                        inactiveTrackColor: ColorConstant.clrWhite,
                        inactiveThumbColor: ColorConstant.clrSecondary,
                        trackOutlineColor: WidgetStatePropertyAll(
                          ColorConstant.clrSecondary,
                        ),
                        onChanged: (value) {
                          driverHomeController.isSwitched.value = value;
                          driverHomeController.toggleDutyApiCall(
                            details: {
                              "user_id": GetStorage().read(userId),
                              "on_duty": value ? "1" : "0",
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                ],
              ),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(34.r),
              bottomLeft: Radius.circular(30.r),
            ),
            child: Image.asset(
              ImageConstant.imgCardTopRight,
              // height: 100.h,
              width: 110.w,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Vehicle List',
          style: TextStyleConstant().subTitleTextStyle20w500Clr242424,
        ),
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.addVehicleMainScreen)?.then((_) async {
              // Refresh vehicle list after returning from Add Vehicle screen
              await driverHomeController.getData();
            });
          },
          child: Text(
            'Add Vehicle',
            style: TextStyleConstant().subTitleTextStyle14w500ClrSubText,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search Vehicle',
        hintStyle: TextStyleConstant().subTitleTextStyle14w500ClrCCCCCC,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(Icons.search, color: ColorConstant.clrC8C8C8),
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
        contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 19.w),
      ),
    );
  }

  Widget _buildVehicleList() {
    return Obx(() {
      if (driverHomeController.isVehicleLoading.value) {
        return Center(
          child: CircularProgressIndicator(color: ColorConstant.clrSecondary),
        );
      }

      final vehicles =
          driverHomeController.userWiseVehicleList.value.data ?? [];

      if (vehicles.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.directions_car_outlined,
                size: 50.sp,
                color: ColorConstant.clrCCCCCC,
              ),
              SizedBox(height: 16.h),
              Text(
                'No vehicles found',
                style: TextStyleConstant().subTitleTextStyle16w500Clr242424,
              ),
              SizedBox(height: 8.h),
              Text(
                'Add your first vehicle to get started',
                style: TextStyleConstant().subTitleTextStyle14w500ClrCCCCCC,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.addVehicleMainScreen)?.then((_) async {
                    // Refresh vehicle list after returning from Add Vehicle screen
                    await driverHomeController.getData();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.clrSecondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                child: Text(
                  'Add Vehicle',
                  style: TextStyleConstant().subTitleTextStyle14w700clrWhite,
                ),
              ),
            ],
          ),
        );
      }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children:
              vehicles
                  .asMap()
                  .entries
                  .map((entry) => _buildVehicleCard(entry.value, entry.key))
                  .toList(),
        ),
      );
    });
  }

  Widget _buildVehicleCard(GetUserVehicleData vehicle, int index) {
    // Determine background color and image based on vehicle type
    Color bgColor = index.isEven ? Color(0xFFFEE3BA) : Color(0xFFC2EAFF);
    String imagePath =
        vehicle.vehicleType?.logo ??
        ImageConstant.imgSmallTruck; // Default image if logo is null
    // String imagePath = _getVehicleImage(vehicle.vehicleModel);

    return Container(
      height: 165.h,
      margin: EdgeInsets.only(top: 0.h, right: 12.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(18.w, 18.h, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vehicle.vehicleModel ?? 'Unknown Vehicle',
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle16w500Clr242424,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          vehicle.vehicleNumber ?? 'No Number',
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle16w500Clr242424,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SizedBox(height: 45.h),
                    InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.vehicleDetailsScreen,
                          arguments:
                              vehicle.id, // Pass vehicle data to details screen
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
              // Image.network(imagePath, height: 160.h, width: 160.w),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Image.network(
                  imagePath,
                  fit: BoxFit.fill,
                  height: 140.h,
                  width: 160.w,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getVehicleColor(String? vehicleType) {
    switch (vehicleType?.toLowerCase()) {
      case 'truck':
      case 'mahindra jeeto':
        return Color(0xffFEE3BA);
      case 'car':
      case 'suzuki dzire':
        return Color(0xffD5E8FF);
      default:
        return Color(0xffFEE3BA);
    }
  }

  String _getVehicleImage(String? vehicleType) {
    switch (vehicleType?.toLowerCase()) {
      case 'truck':
      case 'mahindra jeeto':
        return ImageConstant.imgSmallTruck;
      case 'car':
      case 'suzuki dzire':
        return ImageConstant.imgMotorCar;
      default:
        return ImageConstant.imgSmallTruck;
    }
  }
}
